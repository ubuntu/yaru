## Icon Sources

**Notes:**
* Do not edit the icon assets of the theme directly, instead edit source files in this directory and render them with the appropriate script.
* To edit the icons will need `inkscape` installed and you use the render scripts you'll need `python` and `ruby` installed 

### Source Files

The sources for all the different icons are kept organized in this `src` folder for ease of development.

`fullcolor`
 - sources for all full color icons.

`mixed`
 - sources for icons of a mixed style with both a pictographic and colored style.

`symbolic/source-plate.svg`
 - the source plate for all of the symbolic icons. Each icon should be grouped within an empty 16x16 pixel square and the group should be given a label which is the icon name.

### Render Scripts

For simplified development, has various scripts to extract or render icons from the larger SVG source files.

`extract-symbolic-icons.rb`
 - This script will extract any new symbolic icons from the [source SVG](./symbolic/source-plate.svg)` or extract individual icons when passed the icon name: `./extract-symbolic-icons.rb <icon-name>`. 

`render-bitmaps.py`
- This script with render PNG icons, provided there are source changes, in both @1x and @2x (HiDPi) resolutions from the source files in [fullcolor](./fullcolor) and [mixed](./mixed). 

### Resources

`Suru.gpl`
- The Inkscape colour palette for the Suru icons. You can copy it to `.config/inkscape/palettes` and restart Inkscape to able to choose it from the palette menu.