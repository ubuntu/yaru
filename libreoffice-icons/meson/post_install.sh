#!/bin/bash

for dir in \
    /usr/lib64/libreoffice/share/config \
    /usr/lib/libreoffice/share/config \
    /usr/local/lib/libreoffice/share/config \
    /opt/libreoffice*/share/config; do
        [ -d "$dir" ] || continue
        ln -sf $1 "$dir"
done
