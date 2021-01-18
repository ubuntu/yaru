#!/usr/bin/env python3

from contextlib import suppress
from os import environ, path
from shutil import move
from subprocess import call
import sys

project_name = 'Suru'
with suppress(IndexError):
    data_dir = sys.argv[1]
    project_name = sys.argv[2]
    flavour = sys.argv[3]

PREFIX = environ.get('MESON_INSTALL_DESTDIR_PREFIX', '/usr')
icons_dir = path.join(PREFIX, data_dir, 'icons')

if flavour == 'default':
    flavour_name = project_name
else:
    flavour_name = "{project}-{flavour}".format(project=project_name, flavour=flavour)

flavour_dir = path.join(icons_dir, flavour_name)

# rename cursor.theme and index.theme
for theme_type in ['index', 'cursor']:
    theme_name = "{flavour}-{theme_type}.theme".format(flavour=flavour, theme_type=theme_type)
    theme_src = path.join(flavour_dir, theme_name)
    if path.exists(theme_src):
        theme_dst = path.join(flavour_dir, "{theme_type}.theme".format(theme_type=theme_type))
        move(theme_src, theme_dst)

if not environ.get('DESTDIR', ''):
    PREFIX = environ.get('MESON_INSTALL_PREFIX', '/usr')
    print("Updating icon cache: {flavour_name}".format(flavour_name=flavour_name))
    call(['gtk-update-icon-cache', '-qtf', path.join(PREFIX, 'share/icons', flavour_name)])
