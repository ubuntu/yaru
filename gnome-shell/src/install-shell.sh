#!/usr/bin/env bash
# -*- coding: UTF-8 -*-

project_name="$1"
prefix="${MESON_INSTALL_DESTDIR_PREFIX}/share"

ln -sf "${prefix}/themes/${project_name}/gnome-shell" "${prefix}/gnome-shell/theme/${project_name}"
