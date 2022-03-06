#! /bin/bash

INKSCAPE="inkscape"
OPTIPNG="optipng"

SRC_FILE="assets.svg"
ASSETS_DIR="assets"
HDPI_ASSETS_DIR="assets-hdpi"
XHDPI_ASSETS_DIR="assets-xhdpi"

INDEX="assets.txt"

# check command avalibility
has_command() {
  "$1" -v $1 > /dev/null 2>&1
}

mkdir -p $ASSETS_DIR
mkdir -p $HDPI_ASSETS_DIR
mkdir -p $XHDPI_ASSETS_DIR

for i in `cat $INDEX`
do

# Normal
if [ -f $ASSETS_DIR/$i.png ]; then
    echo $ASSETS_DIR/$i.png exists.
else
    echo
    echo Rendering $ASSETS_DIR/$i.png

    $INKSCAPE --export-id=$i \
              --export-id-only \
              --export-filename=$ASSETS_DIR/$i.png $SRC_FILE >/dev/null
    $OPTIPNG -o7 --quiet $ASSETS_DIR/$i.png
fi

# HDPI
if [ -f $HDPI_ASSETS_DIR/$i.png ]; then
    echo $HDPI_ASSETS_DIR/$i.png exists.
else
    echo
    echo Rendering $HDPI_ASSETS_DIR/$i.png

    $INKSCAPE --export-id=$i \
              --export-id-only \
              --export-dpi=144 \
              --export-filename=$HDPI_ASSETS_DIR/$i.png $SRC_FILE >/dev/null
    $OPTIPNG -o7 --quiet $HDPI_ASSETS_DIR/$i.png
fi

# XHDPI
if [ -f $XHDPI_ASSETS_DIR/$i.png ]; then
    echo $XHDPI_ASSETS_DIR/$i.png exists.
else
    echo
    echo Rendering $XHDPI_ASSETS_DIR/$i.png

    $INKSCAPE --export-id=$i \
              --export-id-only \
              --export-dpi=192 \
              --export-filename=$XHDPI_ASSETS_DIR/$i.png $SRC_FILE >/dev/null
    $OPTIPNG -o7 --quiet $XHDPI_ASSETS_DIR/$i.png
fi
done

# Symlink Titlebar Assets
for num in {2..5}
do
  # Normal
  ln -srfv $ASSETS_DIR/title-1-active.png $ASSETS_DIR/title-$num-active.png
  ln -srfv $ASSETS_DIR/title-1-inactive.png $ASSETS_DIR/title-$num-inactive.png

  # HDPI
  ln -srfv $HDPI_ASSETS_DIR/title-1-active.png $HDPI_ASSETS_DIR/title-$num-active.png
  ln -srfv $HDPI_ASSETS_DIR/title-1-inactive.png $HDPI_ASSETS_DIR/title-$num-inactive.png

  # XHDPI
  ln -srfv $XHDPI_ASSETS_DIR/title-1-active.png $XHDPI_ASSETS_DIR/title-$num-active.png
  ln -srfv $XHDPI_ASSETS_DIR/title-1-inactive.png $XHDPI_ASSETS_DIR/title-$num-inactive.png
done


exit 0
