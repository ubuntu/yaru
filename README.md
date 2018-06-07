Suru Icons & Cursors
====================

This project is a revitalization of the Suru icon set that was designed for Ubuntu Touch. The principles and styles created for Suru now serve as the basis for a new FreeDesktop icon theme.

## Copying or Reusing

This project is licenced under the terms of either the [GNU General Public License, version 3](https://www.gnu.org/licenses/gpl-3.0.txt) or [Creative Commons Attribution-ShareAlike 4.0 License](https://creativecommons.org/licenses/by-sa/4.0/).

The Suru icon assets (any and all `.png` files) are licenced under the terms of the CC-by-SA (which is encoded in the PNG metadata), all SVG icons, icon source materials, scripts and other bits are free software licenced under the GNU GPL; you can copy, redistribute and/or modify aspects of this work under the terms of each license accordingly.

## Installing & Using

You can install Suru from source using the Meson build system.

```bash
# build
meson "build" --prefix=/usr
# install
sudo ninja -C "build" install
```

By default it installs to `/usr/` but you can specify a different directory with a prefix like: `/usr/local` or `$HOME/.local`.

After which you should be able to pick Suru as your icon or cursor theme in GNOME Tweak tool, or you can set either from a terminal with:

```bash
# set the icon theme
gsettings set org.gnome.desktop.interface icon-theme "Suru"
# or the cursor theme
gsettings set org.gnome.desktop.interface cursor-theme "Suru"
```

### Uninstalling Suru

To uninstall Suru, simply run the following. (If you installed it without superuser priveleges just omit the  `sudo`.)

```bash
sudo ninja -C "build" uninstall
```

Once uninstalled you can reset your icon and cursor theme to the default setting by running the following.

```bash
# reset icon theme to default
gsettings reset org.gnome.desktop.interface icon-theme
# reset cursor theme to default
gsettings reset org.gnome.desktop.interface cursor-theme
```

## Contributing

Contributions are obviously welcome! If you would like to contribute to this project, please have [read this](/CONTRIBUTING.md) regarding contributions.

Alternatively, if you would like to support development by making a donation you can do so [here](https://snwh.org/donate).