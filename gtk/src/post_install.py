#!/usr/bin/env python3

import sys
from os import environ, path
from shutil import move

data_dir = sys.argv[1]
project_name = sys.argv[2]
variant = sys.argv[3]

PREFIX = environ.get('MESON_INSTALL_DESTDIR_PREFIX', '')

themes_dir = path.join(PREFIX, data_dir, 'themes')
print("themedir: {}".format(themes_dir))

gresource_src = path.join(themes_dir, project_name + '-' + variant, 'gtk-3.20', variant + '-gtk.gresource')
gresource_dst = path.join(themes_dir, project_name + '-' + variant, 'gtk-3.20', 'gtk.gresource')

print('Replace %s with %s' % (gresource_src, gresource_dst))
move(gresource_src, gresource_dst)

