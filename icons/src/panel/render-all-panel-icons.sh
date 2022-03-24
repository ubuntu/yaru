#!/bin/bash
#
# Super simple script for copy and optimize panel icons
#
# Legal Stuff:
#
# This script is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation; version 3.
#
# This script is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, see <https://www.gnu.org/licenses/gpl-3.0.txt>

info() {
  echo [+] $@
}

fatal() {
  echo [!] $@
  exit 1
}

###################################################
# CHECKS
###################################################

# current workding directory expected to be yaru/icons/src/panel
CWD=$(pwd)
if [[ ! ${CWD} =~ "icons/src/panel" ]]; then
  fatal "unexpected working directory ${CWD}. Please execute the script under yaru/icons/src/panel folder."
fi
info "working directory OK."

# check for missing svgo dependency
command -v svgo 1>&2>/dev/null
if [[ $? == 1 ]]; then
  fatal "missing dependency: svgo."
fi
info "dependencies OK."

###################################################
# MAIN
###################################################

VARIANTS=("default" "dark")

info "copy and optimize panel icons."
for VARIANT in "${VARIANTS[@]}"
do
    [[ ! -d ${VARIANT} ]] && fatal "could not find variant folder: ${VARIANT}"

	[[ $VARIANT = "default" ]] && THEME="Yaru-panel" || THEME="Yaru-panel-${VARIANT}"
    OUTDIR=../../${THEME}/

    # Remove old generated icons
    [[ -d ${OUTDIR} ]] && rm -r ${OUTDIR}

    # Copy new ones
    cp -r ${VARIANT}/. ${OUTDIR}

    # Optimize icons
    svgo -rq ${OUTDIR}
done
info "done."
