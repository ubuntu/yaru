#! /bin/bash
## Render script for gtk assets.
## usage:
##    render-assets.sh --dir gtk-3.20                # render all the assets, unless the png exists already
##    render-assets.sh --dir gtk-3.20 --force        # render all the assets, overwriting the ones that exist already
##    render-assets.sh --dir gtk-3.20 --asset slider # render only the assets whose name starts with "slider"
##
## options
##    -d, --dir <folder>    gtk folder
##    -a, --asset <name>    render only the asset matching the name
##    -f, --force           Force rendering of existing generated assets [default: 0]
##    -o, --optimize        Optimize PNG files [default: 0]
##    -s, --svg <filename>  SVG file name [default: assets.svg]

# CLInt GENERATED_CODE: start
# Default values
_force=0
_optimize=0
_svg=assets.svg

# No-arguments is not allowed
[ $# -eq 0 ] && sed -ne 's/^## \(.*\)/\1/p' $0 && exit 1

# Converting long-options into short ones
for arg in "$@"; do
  shift
  case "$arg" in
"--dir") set -- "$@" "-d";;
"--asset") set -- "$@" "-a";;
"--force") set -- "$@" "-f";;
"--optimize") set -- "$@" "-o";;
"--svg") set -- "$@" "-s";;
  *) set -- "$@" "$arg"
  esac
done

function print_illegal() {
    echo Unexpected flag in command line \"$@\"
}

# Parsing flags and arguments
while getopts 'hfod:a:s:' OPT; do
    case $OPT in
        h) sed -ne 's/^## \(.*\)/\1/p' $0
           exit 1 ;;
        f) _force=1 ;;
        o) _optimize=1 ;;
        d) _dir=$OPTARG ;;
        a) _asset=$OPTARG ;;
        s) _svg=$OPTARG ;;
        \?) print_illegal $@ >&2;
            echo "---"
            sed -ne 's/^## \(.*\)/\1/p' $0
            exit 1
            ;;
    esac
done
# CLInt GENERATED_CODE: end

[ -z $_dir ] && echo "--dir input is mandatory!" && sed -ne 's/^## \(.*\)/\1/p' $0 && exit 1

INKSCAPE="/usr/bin/inkscape"
[ `command -v $INKSCAPE | wc -l ` != 1 ] && echo "install $INKSCAPE" && exit
OPTIPNG="/usr/bin/optipng"
[ `command -v $OPTIPNG | wc -l ` != 1 ] && echo "install $OPTIPNG" && exit


ASSETS_DIR="assets"
SRC_FILE="$_dir"/$_svg
INDEX=${SRC_FILE/.svg/.txt}

for i in `cat $INDEX`; do
  if [[ ! -z $_asset ]] && [[ $i != $_asset* ]]; then
    # Skip assets that do not match --asset input (if defined)
    continue
  fi

  if [ "$_dir" == "gtk-2.0" ]; then
    if [ -f $_dir/$ASSETS_DIR/$i.png ] && [ $_force == 0 ]; then
      echo $_dir/$ASSETS_DIR/$i.png exists.
    else
      echo Rendering $_dir/$ASSETS_DIR/$i.png
      $INKSCAPE --export-id=$i \
        --export-id-only \
        --export-background-opacity=0 \
        --export-png=$_dir/$ASSETS_DIR/$i.png $SRC_FILE >/dev/null
      [ "$_optimize" == 1 ] && $OPTIPNG -o7 --quiet $_dir/$ASSETS_DIR/$i.png
    fi
  fi

  if [ "$_dir" == "gtk-3.0" ] || [ "$_dir" == "gtk-3.20" ]; then
    if [ -f $_dir/$ASSETS_DIR/$i.png ] && [ $_force == 0 ]; then
        echo $_dir/$ASSETS_DIR/$i.png exists.
    else
        echo Rendering $_dir/$ASSETS_DIR/$i.png
        $INKSCAPE --export-id=$i \
                  --export-dpi=90 \
                  --export-id-only \
                  --export-png=$_dir/$ASSETS_DIR/$i.png $SRC_FILE >/dev/null
        [ "$_optimize" == 1 ] && $OPTIPNG -o7 --quiet $_dir/$ASSETS_DIR/$i.png
    fi

    if [ -f $_dir/$ASSETS_DIR/$i@2.png ] && [ $_force == 0 ]; then
        echo $_dir/$ASSETS_DIR/$i@2.png exists.
    else
        echo Rendering $_dir/$ASSETS_DIR/$i@2.png
        $INKSCAPE --export-id=$i \
                  --export-dpi=180 \
                  --export-id-only \
                  --export-png=$_dir/$ASSETS_DIR/$i@2.png $SRC_FILE >/dev/null
        [ "$_optimize" ] && $OPTIPNG -o7 --quiet $_dir/$ASSETS_DIR/$i.png
    fi
  fi
done

exit 0


