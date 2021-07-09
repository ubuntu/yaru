#!/bin/sh
# Shell script to generate symlinks for mixed-themes
# Yaru-mix-dark: symlinks to Yaru (Light GTK theme and Dark GNOME-Shell theme)
# Yaru-mix: symlinks to Yaru-dark (Dark GTK theme and Light GNOME-Shell theme)
#  
set -eu

srcdir="${MESON_SOURCE_ROOT}/mix"
datadir="${MESON_INSTALL_DESTDIR_PREFIX}/$1"

install -m755 -d "${datadir}/themes/Yaru-mix-dark"
for file in index.theme gtk-2.0 gtk-3.0 gtk-3.20; do
    ln -sfn "../Yaru/${file}" "${datadir}/themes/Yaru-mix-dark/${file}"
done
install -m755 -d "${datadir}/themes/Yaru-mix"
for file in index.theme gtk-2.0 gtk-3.0 gtk-3.20; do
    ln -sfn "../Yaru-dark/${file}" "${datadir}/themes/Yaru-mix/${file}"
done

