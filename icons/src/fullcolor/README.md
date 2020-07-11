## Full Color Icon Sources

The source SVG files for all icons are found in subfolders within this directory. Each subfolder corresponds to a icon's "context" and the sources are sorted accordingly.

To edit the icon sources (or create a new one using a template) you will need "inkscape" installed and you'll need "python" and "optipng" to run the render script.

**[render-bitmaps.py](./render-bitmaps.py) - the render script**
 - This script will render PNG icons, provided there are source changes, in both @1x and @2x (HiDPi) resolutions from the source files.
 - You can render a single icon by passing the icon name to this script: "./render-bitmaps.py <icon-name>"

### Templates

There's a few provided templates that make creating a new icon simple (as an alternative to deriving an icon from one of the pre-existing icons).

**[Horizontal Oblong App Icon Template.svg](./Horizontal%20Oblong%20App%20Icon%20Template.svg) - an app icon template for oblong icons with landscape orientation**
 - a blank template file for Suru application icons 
 - the only layers that need modifying are the "Baseplate" layer (to name and categorise the icon), the "Background" layer (to change the color of the icon) and the "Pictogram" layer (where you add the icon's distinct overall pictogram)
 - if your icon is "white" ( = a very light grey gradient), you can make the "optional outline for white icons" layer visible, to add a faint outline to the 256px icon (nothing is added to the smaller icons because they already have borders)
 - You can also edit the opacity of the highlights layer, because you will probably want to make it more transparent to reduce the highlight when using a darker background

**[Round App Icon Template.svg](./Round%20App%20Icon%20Template.svg) - an app icon template for circular icons**
 - same principles as above

**[Square App Icon Template.svg](./Square%20App%20Icon%20Template.svg) - an app icon template for square icons**
 - same principles as above

**[Vertical Oblong App Icon Template.svg](./Vertical%20Oblong%20App%20Icon%20Template.svg) - an app icon template for oblong icons with portrait orientation**
 - same principles as above

**[Blank Template.svg](./Blank%20Template.svg) - a blank icon template**
 - a completely blank template file for the fullcolor Suru icons (every icon follows this template)

All templates have a "Baseplate" layer which contain the necessary metadata for rendering an icon: the icon's **context** (such as "apps" or "status", etc.) and **icon-name** (the asset filename). This layer must also be hidden or it will appear in your render.
