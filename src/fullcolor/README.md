## Full Color Icon Sources

The source SVG files for all icons are found in subfolders within this directory. Each subfolder corresponds to a icon's `context` and the sources are sorted accordingly.

To edit the icon sources (or create a new one using a template) you will need `inkscape` installed and you'll need `python` and `optipng` to run the render script.

**[render-bitmaps.py](./render-bitmaps.py) - the render script**
 - This script will render PNG icons, provided there are source changes, in both @1x and @2x (HiDPi) resolutions from the source files.
 - You can render a single icon by passing the icon name to this script: `./render-bitmaps.py <icon-name>`

### Templates

There's a couple provided templates that make creating a new icon simple (as an alternative to deriving an icon from one of the pre-existing icons).

**[App Icon Template.svg](./App%20Icon%20Template.svg) - an app icon template**
 - a blank template file for Suru application icons 
 - the only layers that need modifying are the `Background` layer (to change the color of the icon) and the `Pictogram` layer (where you add the icon's distinct overall pictogram)

**[Blank Template.svg](./Blank%20Template.svg) - a blank icon template**
 - a completely blank template file for the fullcolor Suru icons (every icon follows this template.)

Both templates have a `Baseplate` layer which contain the necessary metadata for rendering an icon: it's **context** (such as `apps` or `status`, etc.) and **icon-name** (the asset filename). This layer must also be hidden or it will appear in your render.