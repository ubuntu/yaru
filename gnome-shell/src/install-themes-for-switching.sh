#!/usr/bin/env bash
# -*- coding: UTF-8 -*-

project_name="$1"
project_lname="$2"
gnomeshell_theme_dir="${MESON_INSTALL_DESTDIR_PREFIX}/$3"
variant_suffix="$4"
variant_target="${gnomeshell_theme_dir}/${project_name}${variant_suffix}/gnome-shell.css"
variant_symlink="${gnomeshell_theme_dir}/${project_lname}${variant_suffix}.css"

cp $variant_target $variant_symlink
