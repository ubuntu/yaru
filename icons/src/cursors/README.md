## Cursor Theme Source

- Do not edit cursor assets directly (i.e. those in the "Suru" folder)! 
- To modify the cursors, edit source SVG file found in this directory and render them with the appropriate script.
- To edit the cursors you will need `inkscape` installed and to build and the render the cursor set you'll need `python-pil` and `x11-apps` installed.

## Render Scripts

For simplified development, has various scripts to render and build the cursor set are provided:

 - [**render-cursors.py**](./render-cursors.py) will render the cursor PNG assets into [bitmaps](./bitmaps) at the appropriate sizes; run by passing the source filename to it: `./render-cursors.py source-cursors.svg`
Inside the Bitmaps folder you'll find folders containing the rendered `.png` files (24x24, 32x32,...). These must be removed, but the `.in` files are needed for the script to run.

 - [**x11-make.sh**](./x11-make.sh) builds the cursor assets into a Xcursor set and renders them to `/icons/Suru/cursors/`. These files have no extension.
 
 - [**w32-make.sh**](./w32-make.sh) builds the cursor assets into a Windows cursor set and renders them to `/icons/Suru/cursors/`. These files have the `.cur`extension.

## Cursor SVG source

The [source SVG](./source-cursors.svg) for the cursors is laid out in such a way to make editing/creating cursors simple, with a variety of layers:

 - `hotspots` shows the exact point where the cursor is active within the 24x24 region (hidden by default)
 - `slices` is read by the render script and each 24x24 square had an ID that is the cursor file name (hidden by default)
 - `cursors` pretty self-explanatory, these are the drawn cursors
 - `labels` are just labels

Both the busy cursors (the large and pointer versions) require 60 different assets to achieve a 60 FPS animation when compiled (each variant is a 6&deg; rotation of the busy indicator).

## CSS Cursors test

The [csscursors.html](./csscursors.html) let's you see your browser's cursor style and where the HOTSPOT is simply by hover over the boxes containing the CSS cursor name. In `CURSORNAMES.md` you'll find the naming specification and a description of the cursors.
