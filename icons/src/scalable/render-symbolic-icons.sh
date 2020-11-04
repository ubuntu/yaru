#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
## Optimize SVG icons with [svgo](https://github.com/svg/svgo)
## usage:
##
## options:
##     -a, --all                Optimize ALL the icons in icons/src/<context> [default:0]
##     -c, --context <name>     Optimize ALL the icons in icons/src/<context> and save them under icons/Suru/<context>
##     -f, --file <name>        Optimize only the icon in icons/src/<context>/<path> and save it under icons/Suru/<context>/<name> (needs --context)
##
## NOTE:
## contexts are: actions, apps, categories, devices, emblems, mimetypes, places, status.

# CLInt GENERATED_CODE: start

# No-arguments is not allowed
[ $# -eq 0 ] && sed -ne 's/^## \(.*\)/\1/p' $0 && exit 1

# Converting long-options into short ones
for arg in "$@"; do
  shift
  case "$arg" in
"--all") set -- "$@" "-a";;
"--context") set -- "$@" "-g";;
"--file") set -- "$@" "-f";;
  *) set -- "$@" "$arg"
  esac
done

function print_illegal() {
    echo Unexpected flag in command line \"$@\"
}

# Parsing flags and arguments
while getopts 'hac:f:' OPT; do
    case $OPT in
        h) sed -ne 's/^## \(.*\)/\1/p' $0
           exit 1 ;;
        a) _all=1 ;;
        c) _context=$OPTARG ;;
        f) _file=$OPTARG ;;
        \?) print_illegal $@ >&2;
            echo "---"
            sed -ne 's/^## \(.*\)/\1/p' $0
            exit 1
            ;;
    esac
done
# CLInt GENERATED_CODE: end

info() {
  echo [+] $@
}

fatal() {
  echo [!] $@
  exit 1
}

contexts=( actions apps categories devices emblems mimetypes places status )

###################################################
# CHECKS
###################################################

# current workding directory expected to be yaru/icons/src/scalable
CWD=$(pwd)
if [[ ! ${CWD} =~ "icons/src/scalable" ]]; then
  fatal "unexpected working directory ${CWD}. Please execute the script under yaru/icons/src/scalable folder."
fi
info "working directory OK."

command -v svgo 1>&2>/dev/null
if [[ $? == 1 ]]; then
  fatal "missing dependency: svgo."
fi
info "dependencies OK."

###################################################
# FUNCTIONS
###################################################
optimize() {
  GROUP=$1
  NAME=$2

  INPUT=${GROUP}/${NAME}
  [[ ! -f ${INPUT} ]] && fatal "could not find input file: ${INPUT}"

  OUTDIR=../../Suru/scalable/${GROUP}/
  OUTPUT=../../Suru/scalable/${GROUP}/${NAME}
  [[ ! -d ${OUTDIR} ]] && fatal "could not find output directory: ${OUTDIR}"

  cmd="svgo --pretty --disable=convertShapeToPath --input=${INPUT} --output=${OUTPUT}"
  #echo "$cmd"
  $cmd >/dev/null
}

###################################################
# MAIN
###################################################

# render single file
if [[ ! -z ${_file} ]]; then
  [[ -z ${_context} ]] && fatal "No icon context found! Please provide the icon context with --context."
  info "rendering ${_context}/${_file}"
  optimize $_context $_file
  exit 0
fi

# render single context
if [[ ! -z ${_context} ]]; then
  count=$(ls ${_context} | wc -l)
  let i=1
  for file in $(ls ${_context}); do
    echo "[$i/$count] rendering ${_context}/${file}"
    optimize $_context $file
    let i++
  done
  exit 0
fi

# render all
if [[ ! -z ${_all} ]]; then
  for context in "${contexts[@]}"; do
    info "rendering context ${context}"
    count=$(ls ${context} | wc -l)
    let i=1
    for file in $(ls ${context}); do
      info "[$i/$count] rendering ${context}/${file}"
      optimize $context $file
      let i++
    done
  done
  exit 0
fi

fatal "no command given!"
