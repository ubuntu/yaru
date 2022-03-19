#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# vi: set ft=python :

import sys
from os import environ, path
from shutil import move

PREFIX = environ.get('MESON_INSTALL_DESTDIR_PREFIX', '/usr')
data_dir = sys.argv[1]
project_name = sys.argv[2]
flavours = sys.argv[3:]

themes_dir = path.join(PREFIX, data_dir, 'themes')

for f in flavours:
    if f == 'default':
        flavour_name = project_name
    else:
        flavour_name = "{project}-{flavour}".format(project=project_name, flavour=f)

    flavour_dir = path.join(themes_dir, flavour_name, 'cinnamon')

    # rename cinnamon.css
    cinnamon_css_name = flavour_name + ".css"
    cinnamon_css_src = path.join(flavour_dir, cinnamon_css_name)
    if path.exists(cinnamon_css_src):
        cinnamon_css_dst = path.join(flavour_dir, 'cinnamon.css')
        move(cinnamon_css_src, cinnamon_css_dst)
