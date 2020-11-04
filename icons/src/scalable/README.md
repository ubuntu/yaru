# Symbolic Icons Source

To add or modify a symbolic icon, edit its source SVG file, under `src/scalable/<context>` folder, using [inkscape]. Each icon should be drawn within an 16x16 pixel square and use only 1 colour.

The subfolders **actions**, **apps**, **categories**, **devices**, **emblems**, **mimetypes**, **places**, **status**, containing all the symbolic icons, also represents the gnome icon `contexts`. 

To render the image and move it to the proper release folder, `Suru/scalable/<context>`, run the script `render-symbolic-icons.sh`. You will need to install [svgo] to run the render script.



## The render script

The [render-symbolic-icons.sh](render-symbolic-icons.sh) script allows you to render (i.e. optimize) the SVG icon, as well as to move it to the proper destination folder under `Suru/scalable/<context>` directory, ready to be released.

The script can render:
- a single SVG file, using both `--file` and `--context` flag.
- all the SVG files in a context, using the `--context` flag only. 
- all the SVG files, using the `--all` flag only.


[inkscape]: https://inkscape.org/
[svgo]: https://github.com/svg/svgo

