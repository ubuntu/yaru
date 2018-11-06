#!/bin/sh
set -eu

theme_dir="${MESON_INSTALL_DESTDIR_PREFIX}/$1"
project_name="$2"

install -m755 -d "${theme_dir}"
install -m755 -d "${theme_dir}/gtk-3.0"
ln -sf "../../${project_name}/gtk-3.0/gtk-dark.css" "${theme_dir}/gtk-3.0/gtk.css"
ln -sf "../../${project_name}/gtk-3.0/assets" "${theme_dir}/gtk-3.0/assets"
install -m755 -d "${theme_dir}/gtk-3.20"
ln -sf "../../${project_name}/gtk-3.20/gtk-dark.css" "${theme_dir}/gtk-3.20/gtk.css"
ln -sf "../../${project_name}/gtk-3.20/assets" "${theme_dir}/gtk-3.20/assets"
