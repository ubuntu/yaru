#!/usr/bin/env python3
# Copyright © 2026, Canonical Ltd
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library. If not, see <http://www.gnu.org/licenses/>.
# Authors:
#       Marco Trevisan <marco.trevisan@canonical.com>

"""Replace duplicate installed icon files with relative-path symlinks.
"""

import argparse
import filecmp
import os
import sys
from pathlib import Path


def find_regular_files(theme_dir: Path) -> list[Path]:
    files = []
    for dirpath, _dirnames, filenames in os.walk(theme_dir):
        for filename in filenames:
            filepath = Path(dirpath) / filename
            if not filepath.is_symlink():
                files.append(filepath)
    return files


def group_by_size(files: list[Path]) -> dict[int, list[Path]]:
    by_size: dict[int, list[Path]] = {}
    for f in files:
        by_size.setdefault(f.stat().st_size, []).append(f)
    return by_size


def deduplicate_icons(theme_dir: Path, deprioritized_categories: list[str] = [],
                      skip_categories: list[str] = []) -> None:
    files = find_regular_files(theme_dir)

    if skip_categories:
        files = [f for f in files
                 if not any(part in skip_categories
                            for part in f.relative_to(theme_dir).parts)]

    def sort_key(p: Path) -> tuple[bool, str]:
        is_deprioritized = any(part in deprioritized_categories
                               for part in p.relative_to(theme_dir).parts)
        return (is_deprioritized, str(p))

    for candidates in group_by_size(files).values():
        if len(candidates) < 2:
            continue

        candidates.sort(key=sort_key)

        seen = []
        for path in candidates:
            for canonical in seen:
                if filecmp.cmp(canonical, path, shallow=False):
                    rel = os.path.relpath(canonical, path.parent)
                    print(f'Symlinking {path} -> {rel}')
                    path.unlink()
                    os.symlink(rel, path)
                    break
            else:
                seen.append(path)


def main() -> None:
    parser = argparse.ArgumentParser(
        description='Replace duplicate icon files with relative-path symlinks.')
    parser.add_argument('theme_name', help='Name of the installed icon theme')
    parser.add_argument(
        '--deprioritize-categories', nargs='+', dest='deprioritized_categories',
        default=[], metavar='CATEGORY',
        help='Icon categories that should never be used as a symlink source')
    parser.add_argument(
        '--skip-categories', nargs='+', dest='skip_categories',
        default=[], metavar='CATEGORY',
        help='Icon categories to exclude entirely from deduplication')
    args = parser.parse_args()

    destdir = os.environ.get('DESTDIR', '')
    prefix = os.environ['MESON_INSTALL_PREFIX']

    theme_dir = Path(destdir + prefix) / 'share' / 'icons' / args.theme_name

    if not theme_dir.is_dir():
        print(f'Theme directory not found: {theme_dir}', file=sys.stderr)
        sys.exit(1)

    deduplicate_icons(theme_dir, args.deprioritized_categories, args.skip_categories)


if __name__ == '__main__':
    main()
