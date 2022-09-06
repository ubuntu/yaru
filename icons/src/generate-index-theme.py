#!/usr/bin/env python3
# Copyright © 2022, Canonical Ltd
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

import argparse
import configparser
import fnmatch
import os

from glob import glob

DEFAULT_MIN_SIZE = 16
DEFAULT_BIG_MIN_SIZE = 64
DEFAULT_MAX_SIZE = 256

CONTEXT_MAPPING = {
    'apps': 'Applications',
    'mimetypes': 'MimeTypes',
    'panel': 'Status',
    'ui': 'UI',
}

CUSTOM_PARAMETERS = {
    'scalable/ui': {
        'MinSize': 8,
        'MaxSize': 512,
    }
}

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('theme_name')
    parser.add_argument('--inherits', action='append',
        default=['hicolor', 'Humanity'])
    parser.add_argument(
        '--comment', default='A desktop adaptation of the Ubuntu mobile icons.')
    parser.add_argument('--source-dir', default=None)
    parser.add_argument('--output-dir', default='.')
    parser.add_argument('--output-name', default='index.theme')
    parser.add_argument('--filter', action='append', default=[])
    parser.add_argument('--exclude', action='append', default=[])
    parser.add_argument('--exclude-directory', action='append', default=[])
    parser.add_argument('--exclude-context', action='append', default=[])

    args = parser.parse_args()
    src_dir = os.path.join(os.path.abspath(args.source_dir))

    theme = configparser.ConfigParser()
    theme.optionxform = str
    args.inherits.reverse()
    theme['Icon Theme'] = {
        'Name': args.theme_name,
        'Comment': args.comment,
        'Inherits': ','.join(args.inherits),
        'Example': 'folder',
    }

    directories = set()

    for icon in (glob(os.path.join(src_dir, '**', '*.png'), recursive=True) +
                 glob(os.path.join(src_dir, '**', '*.svg'), recursive=True)):
        if [fl for fl in args.exclude if fnmatch.fnmatch(icon, fl)]:
            continue

        if args.filter and not [fl for fl in args.filter if fnmatch.fnmatch(icon, fl)]:
            continue

        rel_path = os.path.relpath(icon, src_dir)
        [directory, _] = rel_path.rsplit('/', 1)

        if (directory not in args.exclude_directory and
            directory.split('/')[-1] not in args.exclude_context):
            directories.add(directory)

    directories = sorted(directories)

    theme['Icon Theme']['Directories'] = ','.join(directories)

    for dir in directories:
        [sizes, context] = dir.split('/')
        data = {
            'Context': CONTEXT_MAPPING.get(context, context.title()),
        }

        if '@' in sizes:
            [sizes, scale] = sizes.split('@')
            data['Scale'] = scale[:-1]

        if sizes.startswith('scalable'):
            data['Size'] = DEFAULT_MIN_SIZE
            data['MinSize'] = DEFAULT_MIN_SIZE
            data['MaxSize'] = DEFAULT_MAX_SIZE
            data['Type'] = 'Scalable'

            if 'max' in sizes:
                data['MaxSize'] = sizes.rsplit('-', 1)[-1]
                data['Size'] = min(int(data['Size']), int(data['MaxSize']))

            if 'min' in sizes:
                data['MinSize'] = sizes.rsplit('-', 1)[-1]
                data['Size'] = max(int(data['Size']), int(data['MinSize']))

        elif 'x' in sizes:
            [width, height] = sizes.split('x')
            assert width == height
            data['Size'] = width

            if width == '256':
                data['MinSize'] = DEFAULT_BIG_MIN_SIZE
                data['MaxSize'] = DEFAULT_MAX_SIZE
                data['Type'] = 'Scalable'
            else:
                data['Type'] = 'Fixed'

        data.update(CUSTOM_PARAMETERS.get(dir, {}))
        theme[dir] = data

    output_file = os.path.join(args.output_dir, args.output_name)
    print('Writing theme index at', output_file)
    with open(output_file, 'w') as f:
        theme.write(f, space_around_delimiters=False)
