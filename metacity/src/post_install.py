#!/usr/bin/env python3

from contextlib import suppress
from os import environ, path, remove, symlink
from shutil import move
import sys

with suppress(IndexError):
    data_dir = sys.argv[1]
    project_name = sys.argv[2]
    flavour = sys.argv[3]

PREFIX = environ.get('MESON_INSTALL_DESTDIR_PREFIX', '/usr')
themes_dir = path.join(PREFIX, data_dir, 'themes')

if flavour == 'default':
    flavour_name = project_name
else:
    flavour_name = "{project}-{flavour}".format(project=project_name, flavour=flavour)

flavour_dir = path.join(themes_dir, flavour_name)

# rename metacity-theme-1.xml
theme_name = "{flavour}-metacity-theme-1.xml".format(flavour=flavour)
theme_src = path.join(flavour_dir, 'metacity-1', theme_name)
if path.exists(theme_src):
    theme_dst = path.join(flavour_dir, 'metacity-1', 'metacity-theme-1.xml')
    move(theme_src, theme_dst)
    # create symlinks
    for v in ["2", "3"]:
        theme_link = path.join(flavour_dir, 'metacity-1', "metacity-theme-{ver}.xml".format(ver=v))
        try:
            symlink('metacity-theme-1.xml', theme_link)
        except FileExistsError:
            remove(theme_link)
            symlink('metacity-theme-1.xml', theme_link)
