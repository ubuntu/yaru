#!/bin/bash
#
# Description:
#   A script for quick generation of symlinks of an in-development icon theme
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


DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
THEME="Suru"

# echo $DIR

# Icon sizes and contexts
CONTEXTS=("actions" "apps" "devices" "categories" "mimetypes" "places" "status")
SIZES=("16x16" "24x24" "32x32" "48x48" "256x256" "16x16@2x" "24x24@2x" "32x32@2x" "48x48@2x" "256x256@2x")

# Fullcolor icons
echo "Generating links for fullcolor icons..."
# contexts for loop
for CONTEXT in "${CONTEXTS[@]}"
do
	echo " -- "${CONTEXT}
	# Sizes Loop
	for SIZE in "${SIZES[@]}"
	do
		LIST="$DIR/fullcolor/$CONTEXT.list"
		# Check if directory exists
		if [ -d "$DIR/../../$THEME/$SIZE/$CONTEXT" ]; then
			cd $DIR/../../$THEME/$SIZE/$CONTEXT
			while read line;
			do
				ln -sf $line
			done < $LIST
			cd $DIR/../../$THEME
		else
			echo "  -- skipping "$SIZE"/"$CONTEXT
		fi
	done
done
echo "Done."


# Symbolic icons
echo "Generating links for symbolic icons..."
# contexts for loop
for CONTEXT in "${CONTEXTS[@]}"
do
	echo " -- "$CONTEXT
	LIST="$DIR/symbolic/$CONTEXT.list"
	# Check if directory exists
	if [ -d "$DIR/../../$THEME/scalable/$CONTEXT" ]; then
		cd $DIR/../../$THEME/scalable/$CONTEXT
		while read line;
		do
			ln -sf $line
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
