#!/bin/bash
#
## A script for quick generation of symlinks of an in-development icon theme
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
##
## usage:
##      generate-symlinks.sh [--all|--match <string>] --variant <variant> [--verbose]
##
## options:
##      -a, --all              Generates all the symlinks defined in .list files
##                             (warning: this might break manually generated symlinks)
##      -m, --match <string>   Generates only the symlinks in .list files that matches
##                             the provided string
##      -t, --variant <string> Generates only the symlinks for the specified variant
##      -n, --dry-run          Do not generate symlinks, simulate only
##      -v, --verbose          More verbose output (useful for debugging)
##
## example:
##      To generate only power-profile-* symlinks
##
##      $ generate-symlinks.sh --match power-profile
##
# CLInt GENERATED_CODE: start

# No-arguments is not allowed
[ $# -eq 0 ] && sed -ne 's/^## \(.*\)/\1/p' $0 && exit 1

# Converting long-options into short ones
for arg in "$@"; do
	shift
	case "$arg" in
		"--all") set -- "$@" "-a";;
		"--match") set -- "$@" "-m";;
		"--variant") set -- "$@" "-t";;
		"--verbose") set -- "$@" "-v";;
		"--dry-run") set -- "$@" "-n";;
		*) set -- "$@" "$arg"
	esac
done

function print_illegal() {
	echo Unexpected flag in command line \"$@\"
}

# Parsing flags and arguments
while getopts 'hanvm:t:' OPT; do
	case $OPT in
		h) sed -ne 's/^## \(.*\)/\1/p' $0
			exit 1 ;;
		a) _all=1 ;;
		n) _dry_run=1 ;;
		v) _verbose=1 ;;
		m) _match=$OPTARG ;;
		t) _variant=$OPTARG ;;
		\?) print_illegal $@ >&2;
			echo "---"
			sed -ne 's/^## \(.*\)/\1/p' $0
			exit 1
			;;
	esac
done
# CLInt GENERATED_CODE: end

[ ! -z $_match ] && needle=$_match || needle=''

function dlog() {
	[ ! -z $_verbose ] && echo $*
}

if [ "${BASH_VERSION%%.*}" -lt 4 ]; then
	echo "Too old bash version ${BASH_VERSION}!";
	exit 1
fi

DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

# Icon sizes, contexts and variants
CONTEXTS=("actions" "apps" "devices" "categories" "mimetypes" "places" "phosh" "status" "emblems" "ui")
OPTIONAL_CONTEXTS=("panel" "animations")
SIZES=("16x16" "24x24" "32x32" "48x48" "256x256" "16x16@2x" "24x24@2x" "32x32@2x" "48x48@2x" "256x256@2x")
OPTIONAL_SIZES=("8x8" "8x8@2x" "22x22")
VARIANTS=("default" "dark" "mate")

CONTEXTS+=("${OPTIONAL_CONTEXTS[@]}")
SIZES+=("${OPTIONAL_SIZES[@]}")

if [ -n "$_variant" ]; then
	if [[ ! " ${VARIANTS[*]} " =~ " ${_variant} " ]]; then
		echo "WARNING: Requested $_variant is not known"
	fi

	VARIANTS=($_variant)
fi


linker () {
	local icon_folder=$1
	local icon_subfolder=$2
	declare -A generated_links

	LIST="$DIR/${icon_folder}/$CONTEXT.list"
	if [ ! -d "$DIR/../../$THEME/$icon_subfolder/$CONTEXT" ]; then
		dlog "  -- no $icon_subfolder/$CONTEXT, skipping it"
		return
	fi

	cd $DIR/../../$THEME/$icon_subfolder/$CONTEXT
	while read line;
	do
		if [[ "$line" =~ ^[[:space:]]*$ ]]; then
			dlog "Ignoring empty line in $LIST"
			continue
		fi

		if [[ $line != *"$needle"* ]]; then
			dlog "line $line does not match with $needle: skipping"
			continue
		fi

		SOURCE_FILE=${line%% *}
		if [ -f "$SOURCE_FILE" ]; then
			line_array=($line)
			target="${line_array[0]}"
			link_name="${line_array[1]}"
			echo "[$icon_subfolder/$CONTEXT] linking $link_name -> $target"
			if [ -n "${generated_links["$link_name"]}" ]; then
				echo "  ERROR: $link_name is already linked to ${generated_links["$link_name"]}"
				exit 1
			fi
			if [ "$target" = "$link_name" ]; then
				echo "  ERROR: Can't link a file with itself!"
				exit 1
			fi
			if [ -L "$target" ]; then
				echo "  ERROR: $target is already a symlink, please point it to a real file!"
				exit 1
			fi
			if [ -z "$_dry_run" ]; then
				ln -sf "$target" "$link_name"
			fi
			generated_links["$link_name"]="$target"
		elif [ $VARIANT = "default" ] &&
			 [[ ! " ${OPTIONAL_SIZES[*]} " =~ " $icon_subfolder " ]] &&
			 [[ ! " ${OPTIONAL_CONTEXTS[*]} " =~ " $CONTEXT " ]]; then
			# The default variant must have all icons availables
			echo "  ERROR: could not find symlink file \"$SOURCE_FILE\" in $(pwd)"
			exit 1
		else
			# The variants can ignore the missing icons
			dlog "skipping \"$line\" for $VARIANT variant: could not find source symlink file \"$SOURCE_FILE\" in $(pwd)"
		fi

	done < $LIST
	cd $DIR/../../$THEME
	return $symlinks_counter
}

# Fullcolor icons
echo "Generating links for fullcolor icons..."
for VARIANT in "${VARIANTS[@]}"
do
	[[ $VARIANT = "default" ]] && THEME="Yaru" || THEME="Yaru-${VARIANT}"
	for CONTEXT in "${CONTEXTS[@]}"
	do
		dlog " -- "${CONTEXT}
		for SIZE in "${SIZES[@]}"
		do
			linker "fullcolor" $SIZE
		done
	done
done
echo "Done"

# Symbolic icons
echo "Generating links for symbolic icons..."
for VARIANT in "${VARIANTS[@]}"
do
	[[ $VARIANT = "default" ]] && THEME="Yaru" || THEME="Yaru-${VARIANT}"
	for CONTEXT in "${CONTEXTS[@]}"
	do
		dlog " -- "$CONTEXT
		linker "symbolic" "scalable"
	done
done
echo "Done"

# Clear symlink errors
if command -v symlinks 2>&1 >/dev/null; then
	echo "Deleting broken links..."
	symlinks -cdr $DIR/../../$THEME
	echo "Done."
fi
