#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
## Helper script to sync Adwaita from upstream to a destination folder
## usage:
##
##      gnome-shell-sync.sh --destination <path>
##
## options:
##    -d, --destination <path>    Destination folder - mandatory
##    -b, --branch <name>         Branch name
# CLInt GENERATED_CODE: start

# No-arguments is not allowed
[ $# -eq 0 ] && sed -ne 's/^## \(.*\)/\1/p' $0 && exit 1

# Converting long-options into short ones
for arg in "$@"; do
  shift
  case "$arg" in
"--destination") set -- "$@" "-d";;
"--branch") set -- "$@" "-b";;
  *) set -- "$@" "$arg"
  esac
done

function print_illegal() {
    echo Unexpected flag in command line \"$@\"
}

# Parsing flags and arguments
while getopts 'hab:d:' OPT; do
    case $OPT in
        h) sed -ne 's/^## \(.*\)/\1/p' $0
           exit 1 ;;
        d) _destination=$OPTARG ;;
        b) _branch=$OPTARG ;;
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


_branch=${_branch:=master}
data=https://gitlab.gnome.org/GNOME/gnome-shell/raw/${_branch}/data
root=${data}/theme

[ ! -d ${_destination} ] && echo ${_destination} folder does not exists && exit 1
[ ! -d ${_destination}/gnome-shell-sass ] && mkdir ${_destination}/gnome-shell-sass
[ ! -d ${_destination}/gnome-shell-sass/widgets] && mkdir ${_destination}/gnome-shell-sass/widgets
[ ! -d ${_destination}/data ] && mkdir ${_destination}/data

files=(
  gnome-shell-sass/widgets/_a11y.scss
  gnome-shell-sass/widgets/_app-grid.scss
  gnome-shell-sass/widgets/_base.scss
  gnome-shell-sass/widgets/_buttons.scss
  gnome-shell-sass/widgets/_calendar.scss
  gnome-shell-sass/widgets/_check-box.scss
  gnome-shell-sass/widgets/_corner-ripple.scss
  gnome-shell-sass/widgets/_dash.scss
  gnome-shell-sass/widgets/_dialogs.scss
  gnome-shell-sass/widgets/_entries.scss
  gnome-shell-sass/widgets/_hotplug.scss
  gnome-shell-sass/widgets/_ibus-popup.scss
  gnome-shell-sass/widgets/_keyboard.scss
  gnome-shell-sass/widgets/_login-dialog.scss
  gnome-shell-sass/widgets/_looking-glass.scss
  gnome-shell-sass/widgets/_message-list.scss
  gnome-shell-sass/widgets/_misc.scss
  gnome-shell-sass/widgets/_network-dialog.scss
  gnome-shell-sass/widgets/_notifications.scss
  gnome-shell-sass/widgets/_osd.scss
  gnome-shell-sass/widgets/_overview.scss
  gnome-shell-sass/widgets/_panel.scss
  gnome-shell-sass/widgets/_popovers.scss
  gnome-shell-sass/widgets/_screen-shield.scss
  gnome-shell-sass/widgets/_scrollbars.scss
  gnome-shell-sass/widgets/_search-entry.scss
  gnome-shell-sass/widgets/_search-results.scss
  gnome-shell-sass/widgets/_slider.scss
  gnome-shell-sass/widgets/_switcher-popup.scss
  gnome-shell-sass/widgets/_switches.scss
  gnome-shell-sass/widgets/_tiled-previews.scss
  gnome-shell-sass/widgets/_window-picker.scss
  gnome-shell-sass/widgets/_workspace-switcher.scss
  gnome-shell-sass/widgets/_workspace-thumbnails.scss
  gnome-shell-sass/_colors.scss
  gnome-shell-sass/_common.scss
  gnome-shell-sass/COPYING
  gnome-shell-sass/_drawing.scss
  gnome-shell-sass/gnome-shell-sass.doap
  gnome-shell-sass/_high-contrast-colors.scss
  gnome-shell-sass/NEWS
  gnome-shell-sass/README.md
  gnome-shell-high-contrast.scss
  gnome-shell.scss
  meson.build
  pad-osd.css
  README.md
)

gresource_files=(
  gnome-shell-theme.gresource.xml
)

set -e
for i in ${files[@]}; do
    wget ${root}/${i} -O ${_destination}/${i}
done

for i in ${gresource_files[@]}; do
    gsource=${_destination}/data/${i}
    wget ${data}/${i} -O $gsource
    files=$($(dirname $0)/gresources-xml-parser.py --filter '*.css' $gsource)

    for i in ${files}; do
      wget ${root}/${i} -O ${_destination}/${i}
    done
done
