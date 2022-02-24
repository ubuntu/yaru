This theme uses libsass to process the sass/*.scss. Never edit any of the .css files manually.

#### Editing the theme

In most cases edits will done in sass/_common.scss. The sass directory contains several other supporting style sheets:

* _colors.scss This file defines the color variables used by the theme

* _drawing.scss Drawing helper mixins/functions to allow for easier definition of widget drawing

Once you have made your edits run ./parse-sass.sh to update the css files
