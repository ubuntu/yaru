#!/bin/sh
set -eu

check_package() {
    pkg=$1
    broken=$(find "debian/$pkg" -xtype l 2>/dev/null)
    if [ -n "$broken" ]; then
        echo "Broken symlinks found in $pkg:"
        echo "$broken"
        exit 1
    fi
}

for pkg in $(dh_listpackages | grep -v yaru-theme-unity); do
    check_package "$pkg"
done
