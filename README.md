Suru Icon Theme
================

This project is a revitalization of the Suru icon set that was designed for Ubuntu Touch. The principles and styles created for Suru now serve as the basis for a new FreeDesktop icon theme.

Contributions are welcome and if you would like to contribute to this project, please read the [accompanying documentation](/CONTRIBUTING.md) regarding contributions.

## Copying or Reusing

This project is licenced under the terms of either the [GNU General Public License, version 3](https://www.gnu.org/licenses/gpl-3.0.txt) or [Creative Commons Attribution-ShareAlike 4.0 License](https://creativecommons.org/licenses/by-sa/4.0/).

The Suru icon assets (any and all `.png` icons) are licenced under the terms of the CC-by-SA (which is encoded in the PNG metadata), all SVG icons, icon source materials, scripts and other bits are free software licenced under the GNU GPL; you can copy, redistribute and/or modify aspects of this work under the terms of each license accordingly.

## Installing & Using

You can install Suru from source using the Meson build system.

```shell
meson builddir --prefix=/usr
sudo ninja -C builddir install
```

By default it installs to `/usr/` but you can specify a different directory with a prefix like: `/usr/local` or `$HOME/.local`.

After which you should be able to pick Suru as your icon theme or set it with:

    gsettings set org.gnome.desktop.interface icon-theme Suru

### Uninstalling Suru

To uninstall Suru, simply run: `sudo ninja -C builddir uninstall` or, if you installed it without superuser priveleges: `ninja -C builddir uninstall` and you can reset your icon theme to the default:

    gsettings reset org.gnome.desktop.interface icon-theme

