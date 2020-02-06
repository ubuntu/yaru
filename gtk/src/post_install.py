#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# vi: set ft=python :

import sys
from os import environ, path
from shutil import move

PREFIX = environ.get('MESON_INSTALL_PREFIX', '/usr')
data_dir = sys.argv[1]
project_name = sys.argv[2]
flavours = sys.argv[3:]

themes_dir = path.join(PREFIX, data_dir, 'themes')

for f in flavours:
    if f == 'default':
        flavour_name = project_name
    else:
        flavour_name = "{project}-{flavour}".format(project=project_name, flavour=f)

    # rename index.theme
    theme_index_name = flavour_name + "-index.theme"
    theme_index_src = path.join(themes_dir, flavour_name, theme_index_name)

    # print('searching ', theme_index_src)
    if path.exists(theme_index_src):
        theme_index_dst = path.join(themes_dir, flavour_name, 'index.theme')
        # print('Replace %s with %s' % (theme_index_src, theme_index_dst))
        move(theme_index_src, theme_index_dst)


    # rename gresource, gtk.css and gtk-dark.css
    for gtkver in ['3.20', '3.0']:
        for variant in ['', '-dark']:
            theme_gtk_css = flavour_name + "-gtk{variant}-{ver}-generated.css".format(ver=gtkver, variant=variant)
            theme_gtk_css_src = path.join(themes_dir, flavour_name, 'gtk-' + gtkver, theme_gtk_css)

            # print('searching ', theme_gtk_css_src)
            if path.exists(theme_gtk_css_src):
                theme_gtk_css_dst = path.join(themes_dir, flavour_name, 'gtk-' + gtkver, 'gtk{variant}.css'.format(variant=variant))
                # print('Replace %s with %s' % (theme_gtk_css_src, theme_gtk_css_dst))
                move(theme_gtk_css_src, theme_gtk_css_dst)
