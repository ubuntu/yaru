#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
## Helper script to sync Adwaita from upstream to a destination folder
## usage:
##
##      adwaita-sync.sh --destination <path>
##
## options:
##    -d, --destination <path>    Destination folder - mandatory
# CLInt GENERATED_CODE: start

# No-arguments is not allowed
[ $# -eq 0 ] && sed -ne 's/^## \(.*\)/\1/p' $0 && exit 1

# Converting long-options into short ones
for arg in "$@"; do
  shift
  case "$arg" in
"--destination") set -- "$@" "-d";;
  *) set -- "$@" "$arg"
  esac
done

function print_illegal() {
    echo Unexpected flag in command line \"$@\"
}

# Parsing flags and arguments
while getopts 'had:' OPT; do
    case $OPT in
        h) sed -ne 's/^## \(.*\)/\1/p' $0
           exit 1 ;;
        d) _destination=$OPTARG ;;
        \?) print_illegal $@ >&2;
            echo "---"
            sed -ne 's/^## \(.*\)/\1/p' $0
            exit 1
            ;;
    esac
done
# CLInt  GENERATED_CODE: end

wget_check=`which wget | wc -l`
[ $wget_check == 0 ] && echo "install wget" && exit 1

root=https://gitlab.gnome.org/GNOME/gnome-shell/raw/gnome-3-34/data/theme

[ ! -d ${_destination} ] && echo ${_destination} folder does not exists && exit 1
[ ! -d gnome-shell-sass ] && mkdir ${_destination}/gnome-shell-sass

files=(
  gnome-shell-sass/_colors.scss
  gnome-shell-sass/_common.scss
  gnome-shell-sass/COPYING
  gnome-shell-sass/_drawing.scss
  gnome-shell-sass/gnome-shell-sass.doap
  gnome-shell-sass/_high-contrast-colors.scss
  gnome-shell-sass/NEWS
  gnome-shell-sass/README.md
  calendar-today.svg
  checkbox-focused.svg
  checkbox-off-focused.svg
  checkbox-off.svg
  checkbox.svg
  dash-placeholder.svg
  gnome-shell-high-contrast.scss
  gnome-shell.scss
  key-enter.svg
  key-hide.svg
  key-layout.svg
  key-shift-latched-uppercase.svg
  key-shift.svg
  key-shift-uppercase.svg
  meson.build
  message-indicator-symbolic.svg
  no-events.svg
  noise-texture.png
  no-notifications.svg
  pad-osd.css
  process-working.svg
  README.md
  running-indicator.svg
  toggle-off-hc.svg
  toggle-off-intl.svg
  toggle-on-hc.svg
  toggle-on-intl.svg
)

set -e
for i in ${files[@]}; do
    wget ${root}/${i} -O ${_destination}/${i}
done
