#! /bin/bash

INKSCAPE="inkscape"
OPTIPNG="optipng"

SRC_FILE="assets.svg"

scales=(
  "assets;96"
  "assets-hdpi;144"
  "assets-xhdpi;196"
)

INDEX="assets.txt"


# check command avalibility
has_command() {
  "$1" -v $1 > /dev/null 2>&1
}

for scale in ${scales[@]}
do

  # Get directory and DPI as variables
  IFS=";" read ASSETS_DIR DPI <<< ${scale}

  mkdir -p $ASSETS_DIR

  for asset in `cat $INDEX`
  do

    if [ -f $ASSETS_DIR/$asset.png ]; then
      echo $ASSETS_DIR/$asset.png exists.
    else
      echo
      echo Rendering $ASSETS_DIR/$asset.png

      $INKSCAPE --export-id=$asset \
          --export-id-only \
          --export-dpi=$DPI \
          --export-filename=$ASSETS_DIR/$asset.png $SRC_FILE >/dev/null
      $OPTIPNG -o7 --quiet $ASSETS_DIR/$asset.png
    fi

  # End asset loop
  done

  # Symlink Titlebar Assets
  for num in {2..5}
  do
    ln -srfv $ASSETS_DIR/title-1-active.png $ASSETS_DIR/title-$num-active.png
    ln -srfv $ASSETS_DIR/title-1-inactive.png $ASSETS_DIR/title-$num-inactive.png
  done

# End scale loop
done

exit 0
