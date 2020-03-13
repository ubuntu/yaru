#!/usr/bin/env bash
# -*- coding: UTF-8 -*-

project_name="$1"
destdir_prefix="${MESON_INSTALL_DESTDIR_PREFIX}/share"
install_prefix="${MESON_INSTALL_PREFIX}/share"

echo meson install destdir prefix ${MESON_INSTALL_DESTDIR_PREFIX}
echo meson install prefix ${MESON_INSTALL_PREFIX}

set -x
dest_dir="${destdir_prefix}/themes/${project_name}"
mkdir -p "${dest_dir}"

# Use relative path for symlink, since the review-tools
# check do not allow absolute links
rel_install_prefix=$(realpath --relative-to="${dest_dir}" "${install_prefix}")

ln -sf "${rel_install_prefix}/gnome-shell/theme/${project_name}" "${dest_dir}/gnome-shell"
