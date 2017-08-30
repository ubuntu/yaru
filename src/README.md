## Icon Sources

Notes:
* Do not edit the icon assets of the theme directly, instead edit source files in this directory and render them with the appropriate script.
* To edit the icons will need `inkscape` installed and you use the render scripts you'll need `python` and `ruby` installed 

### Source Files

The sources for all the different icons are kept organized in this `src` folder for ease of development.

`fullcolor`
 - This folder contains the sources for all non-symbolic icons.

`source-symbolic.svg`
 - The SVG source for all of the 16x16 pixel symbolic icons. Each icon should be grouped within an empty 16x16 pixel sqaure and the group should be given a label which is the icon name.

### Render Scripts

For simplified development, has various scripts to extract or render icons from the larger SVG source files.

`extract-symbolic-icons.rb`
 - This script will chop up the [symbolic source SVG ](./source-symbolic.svg)` into individual icons when passed the icon name: `./extract-symbolic-icons.rb <icon-name>`. 

`render-bitmaps.py`
- This script with render all fullcolor icons in both @1x and @2x (HiDPi) resolutions from the source files in [fullcolor](./fullcolor). 

### Resources

`Suru.gpl`
- The Inkscape colour palette for the Suru icons. You can copy it to `.config/inkscape/palettes` and restart Inkscape to able to choose it from the palette menu.