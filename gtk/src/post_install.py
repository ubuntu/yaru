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

    flavour_dir = path.join(themes_dir, flavour_name)

    for gtkver in ['3.0', '4.0']:
        gtk_dir = path.join(flavour_dir, 'gtk-' + gtkver)

        # rename gresource
        theme_gresource = "{flavour}-gtk-{ver}.gresource".format(flavour=flavour_name, ver=gtkver)
        theme_gresource_src = path.join(gtk_dir, theme_gresource)
        if path.exists(theme_gresource_src):
            theme_gresource_dst = path.join(gtk_dir, 'gtk.gresource')
            move(theme_gresource_src, theme_gresource_dst)
