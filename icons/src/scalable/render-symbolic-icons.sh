#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
## Optimize SVG icons with [scour](https://github.com/scour-project/scour)
## usage:
##
## options:
##     -a, --all                Optimize ALL the icons in icons/src/<variant> [default:0]
##     -v, --variant <name>     Optimize the icons in icons/src/<variant> [default:default]
##     -c, --context <name>     Optimize ALL the icons in icons/src/<variant>/<context> and save them under icons/Yaru/<context>
##     -f, --file <name>        Optimize only the icon in icons/src/<variant>/<context>/<path> and save it under icons/Yaru/<context>/<name> (needs --context)
##
## NOTE:
## contexts are: actions, apps, camera, categories, devices, emblems, emotes, generic-symbols, legacy, mimetypes, multimedia, phosh, places, status, time, ui.

# CLInt GENERATED_CODE: start
# Default values
_all=0
_variant=default

# No-arguments is not allowed
[ $# -eq 0 ] && sed -ne 's/^## \(.*\)/\1/p' $0 && exit 1

# Converting long-options into short ones
for arg in "$@"; do
  shift
  case "$arg" in
"--all") set -- "$@" "-a";;
"--variant") set -- "$@" "-v";;
"--context") set -- "$@" "-c";;
"--file") set -- "$@" "-f";;
  *) set -- "$@" "$arg"
  esac
done

function print_illegal() {
    echo Unexpected flag in command line \"$@\"
}

# Parsing flags and arguments
while getopts 'hav:c:f:' OPT; do
    case $OPT in
        h) sed -ne 's/^## \(.*\)/\1/p' $0
           exit 1 ;;
        a) _all=1 ;;
        v) _variant=$OPTARG ;;
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

contexts=( actions apps camera categories devices emblems emotes generic-symbols legacy mimetypes multimedia phosh places status time ui )

###################################################
# CHECKS
###################################################

# current workding directory expected to be yaru/icons/src/scalable
CWD=$(pwd)
if [[ ! ${CWD} =~ "icons/src/scalable" ]]; then
  fatal "unexpected working directory ${CWD}. Please execute the script under yaru/icons/src/scalable folder."
fi
info "working directory OK."

command -v scour 1>&2>/dev/null
if [[ $? == 1 ]]; then
  fatal "missing dependency: scour."
fi
info "dependencies OK."

###################################################
# FUNCTIONS
###################################################
optimize() {
  VARIANT=$1
  GROUP=$2
  NAME=$3

  if [[ ${VARIANT} == "default" ]]; then
    SUFFIX=""
  else
    SUFFIX=-${VARIANT}
  fi

  INPUT=${VARIANT}/${GROUP}/${NAME}
  [[ ! -f ${INPUT} ]] && fatal "could not find input file: ${INPUT}"

  OUTDIR=../../Yaru${SUFFIX}/scalable/${GROUP}/
  OUTPUT=../../Yaru${SUFFIX}/scalable/${GROUP}/${NAME}
  [[ ! -d ${OUTDIR} ]] && fatal "could not find output directory: ${OUTDIR}"

  cmd="scour -i ${INPUT} -o ${OUTPUT} --enable-viewboxing --create-groups --shorten-ids --enable-id-stripping --enable-comment-stripping --disable-embed-rasters --remove-metadata --strip-xml-prolog"
  #echo "$cmd"
  $cmd >/dev/null
}

###################################################
# MAIN
###################################################

# render single file
if [[ ! -z ${_file} ]]; then
  [[ -z ${_context} ]] && fatal "No icon context found! Please provide the icon context with --context."
  info "rendering ${_variant}/${_context}/${_file}"
  optimize $_variant $_context $_file
  exit 0
fi

# render single context
if [[ ! -z ${_context} ]]; then
  count=$(ls ${_variant}/${_context} | wc -l)
  let i=1
  for file in $(ls ${_variant}/${_context}); do
    echo "[$i/$count] rendering ${_variant}/${_context}/${file}"
    optimize $_variant $_context $file
    let i++
  done
  exit 0
fi

# render all
if [[ ! -z ${_all} ]]; then
  for context in "${contexts[@]}"; do
    # If the variant is not the default one, check if context exist
    if [[ ${VARIANT} == "default" || (${VARIANT} != "default" && -d "${_variant}/${context}") ]]; then
      info "rendering context ${context} of ${_variant} variant"
      count=$(ls ${_variant}/${context} | wc -l)
      let i=1
      for file in $(ls ${_variant}/${context}); do
        info "[$i/$count] rendering ${_variant}/${context}/${file}"
        optimize $_variant $context $file
        let i++
      done
    fi
  done
  exit 0
fi

fatal "no command given!"
