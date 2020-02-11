#!/usr/bin/env bash
# -*- coding: UTF-8 -*-

project_name="$1"
destdir_prefix="${MESON_INSTALL_DESTDIR_PREFIX}/share"
install_prefix="${MESON_INSTALL_PREFIX}/share"

# FIXME tentative fix for "The store was unable to accept this snap: package contains external symlinks"
#mkdir -p "${destdir_prefix}/themes/${project_name}"
#ln -sf "${install_prefix}/gnome-shell/theme/${project_name}" "${destdir_prefix}/themes/${project_name}/gnome-shell"
