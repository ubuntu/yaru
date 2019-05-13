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
##      generate-symlinks.sh [--all|--match <string>] [--verbose]
##
## options:
##      -a, --all            Generates all the symlinks defined in .list files
##                           (warning: this might break manually generated symlinks)
##      -m, --match <string> Generates only the symlinks in .list files that matches
##                           the provided string
##      -v, --verbose        More verbose output
##
## example:
##      $ generate-symlinks.sh -m inode-directory
##
##      This generates only the link defined in ./symbolic/apps.list
# GENERATED_CODE: start

# No-arguments is not allowed
[ $# -eq 0 ] && sed -ne 's/^## \(.*\)/\1/p' $0 && exit 1

# Converting long-options into short ones
for arg in "$@"; do
	shift
	case "$arg" in
		"--all") set -- "$@" "-a";;
		"--match") set -- "$@" "-m";;
		"--verbose") set -- "$@" "-v";;
		*) set -- "$@" "$arg"
	esac
done

function print_illegal() {
	echo Unexpected flag in command line \"$@\"
}

# Parsing flags and arguments
while getopts 'havm:' OPT; do
	case $OPT in
		h) sed -ne 's/^## \(.*\)/\1/p' $0
			exit 1 ;;
		a) _all=1 ;;
		v) _verbose=1 ;;
		m) _match=$OPTARG ;;
		\?) print_illegal $@ >&2;
			echo "---"
			sed -ne 's/^## \(.*\)/\1/p' $0
			exit 1
			;;
	esac
done
# GENERATED_CODE: end

[ ! -z $_match ] && needle=$_match || needle=''

function dlog() {
    [ ! -z $_verbose ] && echo $*
}

DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
THEME="Suru"

# echo $DIR
# Icon sizes and contextthe s
CONTEXTS=("actions" "apps" "devices" "categories" "mimetypes" "places" "status" "emblems")
SIZES=("16x16" "24x24" "32x32" "48x48" "256x256" "16x16@2x" "24x24@2x" "32x32@2x" "48x48@2x" "256x256@2x")

# Fullcolor icons
echo "Generating links for fullcolor icons..."
# contexts for loop
for CONTEXT in "${CONTEXTS[@]}"
do
	dlog " -- "${CONTEXT}
	# Sizes Loop
	for SIZE in "${SIZES[@]}"
	do
		LIST="$DIR/fullcolor/$CONTEXT.list"
		# Check if directory exists
		if [ -d "$DIR/../../$THEME/$SIZE/$CONTEXT" ]; then
			cd $DIR/../../$THEME/$SIZE/$CONTEXT
			while read line;
			do
				if [[ $line == *"$needle"* ]]; then
					echo linking $line in $SIZE"/"$CONTEXT
					ln -sf $line
				else
					dlog "[match only mode] skipping $line"
				fi
			done < $LIST
			cd $DIR/../../$THEME
		else
			dlog "  -- skipping "$SIZE"/"$CONTEXT
		fi
	done
done
echo "Done."


# Symbolic icons
echo "Generating links for symbolic icons..."
# contexts for loop
for CONTEXT in "${CONTEXTS[@]}"
do
	dlog " -- "$CONTEXT
	LIST="$DIR/symbolic/$CONTEXT.list"
	# Check if directory exists
	if [ -d "$DIR/../../$THEME/scalable/$CONTEXT" ]; then
		cd $DIR/../../$THEME/scalable/$CONTEXT
		while read line;
		do
			if [[ $line == *"$needle"* ]]; then
				echo linking $line in $SIZE"/"$CONTEXT
				ln -sf $line
			else
				dlog "[match only mode] line $line does not match with $needle"
			fi
		done < $LIST
		cd $DIR/../../$THEME
	else
		echo "  -- skipping scalable/"$CONTEXT
	fi
done
echo "Done."

# Clear symlink errors
if command -v symlinks 2>&1 >/dev/null; then
	echo "Deleting broken links..."
	symlinks -cdr $DIR/../../$THEME
	echo "Done."
fi
