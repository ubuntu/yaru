#! /bin/bash

INKSCAPE="inkscape"
OPTIPNG="optipng"

# Accept parameters: SVG_FILE INDEX_FILE ASSETS_DIR [--clean]
SRC_FILE="${1:-assets.svg}"
INDEX="${2:-assets.txt}"
ASSETS_DIR="${3:-assets}"

# Check if --clean flag is passed
CLEAN_FLAG=false
for arg in "$@"; do
    if [ "$arg" == "--clean" ]; then
        CLEAN_FLAG=true
        break
    fi
done

# Clean existing assets if requested
if [ "$CLEAN_FLAG" == "true" ] && [ -d "$ASSETS_DIR" ]; then
    rm -f "$ASSETS_DIR"/*.png
fi

# Ensure assets directory exists
mkdir -p "$ASSETS_DIR"

# Render assets
for i in `cat "$INDEX"`
do
if [ -f "$ASSETS_DIR/$i.png" ]; then
    echo "$ASSETS_DIR/$i.png exists."
else
    echo
    echo "Rendering $ASSETS_DIR/$i.png"
    $INKSCAPE --export-id=$i \
              --export-id-only \
              -o "$ASSETS_DIR/$i.png" "$SRC_FILE" >/dev/null \
    && $OPTIPNG -o7 --quiet "$ASSETS_DIR/$i.png"
fi
done
exit 0
