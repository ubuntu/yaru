## Symbolic Icons Source

 - To add or modify a symbolic icon, edit source SVG file found in this directory
 - For simplified development, has various scripts to extract or render icons from the larger SVG source files.
 - To edit the icons you will need `inkscape` and you'll need `ruby` installed to run the render script

**[source-symbolic.svg](./source-symbolic.svg) - the source files that contains all of the symbolic icons**
 - each layer in this source file corresponds to a icon `context` and the icons are sorted accordingly
 - each icon should be drawn within an 16x16 pixel square and use only 1 colour
 - when complete, group all elements within a 16x16 rectangle (with no fill or stroke) and label that group with the `icon-name`

**[extract-symbolic-icons.rb](./extract-symbolic-icons.rb) - the render script**
This script allows you to render all the icons in a single run, or to select the list of icons to render, using the commands `all` and `only` as shown below.
Icons that are already rendered (that is, whose .svg file is present under the Suru folder), won't be rendered again, unless the command `force` is used.

```
Usage:
    extract-symbolic-icons.rb [force] all
    extract-symbolic-icons.rb [force] only <icon>...

Options:
    all     extract all icon in the SVG file
    only    extract only the list of given icon names
    force   force extraction of already existing icon [optional]

Examples:
    extract-symbolic-icons.rb only image1 image2  # render only image1 and image2 if not already rendered
    extract-symbolic-icons.rb force only image3   # render only image3 even if already rendered
    extract-symbolic-icons.rb all                 # render all images, if not already rendered
    extract-symbolic-icons.rb force all           # render all images even if already rendered
```

dependencies:
- [inkscape](https://inkscape.org/)
- [docopt](https://github.com/docopt/docopt.rb): command line option parser, that will make you smile
- [svgo](https://github.com/svg/svgo): SVG Optimizer is a Nodejs-based tool for optimizing SVG vector graphics files.

