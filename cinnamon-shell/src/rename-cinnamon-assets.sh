#!/usr/bin/env bash
# -*- coding: UTF-8 -*-

# rename and install cinnamon colourable assets

mkdir -p "${DESTDIR}${MESON_INSTALL_PREFIX}/$2"
cp -uv "$1" "${DESTDIR}${MESON_INSTALL_PREFIX}/$3"
