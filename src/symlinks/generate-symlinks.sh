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

THEMEDIR="$HOME/Projects/Suru/suru-icon-theme/Suru"
DATADIR="$HOME/Projects/Suru/icon-dev-scripts/Suru/data"

# Icon sizes and contexts
CONTEXTS=("actions" "apps" "devices" "categories" "mimetypes" "places" "status")
SIZES=("16x16" "24x24" "32x32" "48x48" "256x256" "16x16@2x" "24x24@2x" "32x32@2x" "48x48@2x" "256x256@2x")

# Colored icons
echo "Generating links for colored icons..."

for CONTEXT in "${CONTEXTS[@]}"
do
	echo " -- "${CONTEXT}
	# Sizes Loop
	for SIZE in "${SIZES[@]}"
	do
		LIST="$DATADIR/$CONTEXT.list"
		# Check if directory exists
		if [ -d "$THEMEDIR/$SIZE/$CONTEXT" ]; then
			cd $THEMEDIR/$SIZE/$CONTEXT
			while read line;
			do
				ln -sf $line
			done < $LIST
			cd $THEMEDIR
		else
			echo "  -- skipping "$SIZE"/"$CONTEXT
		fi
	done
done
echo "Done."


# Symbolic icons
echo "Generating links for symbolic icons..."

for CONTEXT in "${CONTEXTS[@]}"
do
	echo " -- "$CONTEXT
	LIST="$DATADIR/symbolic/$CONTEXT.list"
	# Check if directory exists
	if [ -d "$THEMEDIR/symbolic/$CONTEXT" ]; then
		cd $THEMEDIR/symbolic/$CONTEXT
		while read line;
		do
			ln -sf $line
		done < $LIST
		cd $THEMEDIR
	else
		echo "  -- skipping symbolic/"$CONTEXT
	fi
done
echo "Done."

# Clear symlink errors
echo "Deleting broken links..."
symlinks -cdr $THEMEDIR/
echo "Done."
