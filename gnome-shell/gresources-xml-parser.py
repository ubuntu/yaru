#! /usr/bin/env python3
# Copyright © 2020, Canonical Ltd
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
import fnmatch
import os
import xml.etree.ElementTree as ET

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('gresource_source', type=argparse.FileType('r'))
    parser.add_argument('--path', default='')
    parser.add_argument('--filter', action='append', default=[])

    args = parser.parse_args()
    gsource_xml = ET.ElementTree(file=args.gresource_source.name)
    source_files = [f.text for f in gsource_xml.findall('.//gresource/file')]

    filtered = []
    for f in source_files:
        if [fl for fl in args.filter if fnmatch.fnmatch(f, fl)]:
            continue

        filtered.append(os.path.join(args.path, f))

    print('\n'.join(filtered))
