#!/bin/sh
set -eu

srcdir="${MESON_SOURCE_ROOT}/inverted"
datadir="${MESON_INSTALL_DESTDIR_PREFIX}/$1"

install -m755 -d "${datadir}/themes/Yaru-inverted-dark"
for file in index.theme gtk-2.0 gtk-3.0 gtk-3.20; do
    ln -sfn "../Yaru/${file}" "${datadir}/themes/Yaru-inverted-dark/${file}"
done
install -m755 -d "${datadir}/themes/Yaru-inverted"
for file in index.theme gtk-2.0 gtk-3.0 gtk-3.20; do
    ln -sfn "../Yaru-dark/${file}" "${datadir}/themes/Yaru-inverted/${file}"
done

