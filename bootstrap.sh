#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
## This script will make you up and running for testing and/or development on the Yaru project.
## usage:
##  bootstrap.sh --development
##  bootstrap.sh --testing
##  bootstrap.sh --build
##
##  options:
##    -d, --development Install the dependencies for building and installing Yaru theme
##    -t, --testing     Install the dependencies for testing an already installed Yaru theme
##    -b, --build       Build and install Yaru theme
# CLInt GENERATED_CODE: start

# No-arguments is not allowed
[ $# -eq 0 ] && sed -ne 's/^## \(.*\)/\1/p' $0 && exit 1

# Converting long-options into short ones
for arg in "$@"; do
  shift
  case "$arg" in
"--development") set -- "$@" "-d";;
"--testing") set -- "$@" "-t";;
"--build") set -- "$@" "-b";;
  *) set -- "$@" "$arg"
  esac
done

function print_illegal() {
    echo Unexpected flag in command line \"$@\"
}

# Parsing flags and arguments
while getopts 'hdtb' OPT; do
    case $OPT in
        h) sed -ne 's/^## \(.*\)/\1/p' $0
           exit 1 ;;
        d) _development=1 ;;
        t) _testing=1 ;;
        b) _build=1 ;;
        \?) print_illegal $@ >&2;
            echo "---"
            sed -ne 's/^## \(.*\)/\1/p' $0
            exit 1
            ;;
    esac
done
# CLInt GENERATED_CODE: end

# TODO choose between apt and dnf (at least initially)
INSTALLER="apt install"

function log {
  echo "[+]" $@
}

development_deps=(meson sassc)
testing_deps=(libgtk-3-dev gtk-3-examples gnome-tweaks)

function install {
  target=$1
  shift
  deps=($@)
  log "the following application will be installed for $target Yaru"
  for d in ${deps[@]}; do
    echo - $d
  done
  log "Press ENTER to continue"
  read
  sudo ${INSTALLER} ${deps[@]}
}

function build {
  if [ ! -d build ]; then
    meson build
  fi
  ninja -C build install
}

[ ! -z $_development ] && install "building and installing" ${development_deps[@]}
[ ! -z $_testing ] && install "testing" ${testing_deps[@]}
[ ! -z $_build ] && build
