#!/bin/sh
set -eu

srcdir="${MESON_SOURCE_ROOT}/communitheme-compat"
datadir="${MESON_INSTALL_DESTDIR_PREFIX}/$1"

install -m755 -d "${datadir}/icons/communitheme"
install -m644 "${srcdir}/communitheme-icons.theme" "${datadir}/icons/communitheme/index.theme"
install -m755 -d "${datadir}/icons/Suru"
install -m644 "${srcdir}/Suru-icons.theme" "${datadir}/icons/Suru/index.theme"
install -m755 -d "${datadir}/sounds/communitheme"
install -m644 "${srcdir}/communitheme-sounds.theme" "${datadir}/sounds/communitheme/index.theme"

install -m755 -d "${datadir}/themes/Communitheme"
for file in index.theme gtk-2.0 gtk-3.0 gtk-3.20; do
    ln -s "../Yaru/${file}" "${datadir}/themes/Communitheme/${file}"
done
