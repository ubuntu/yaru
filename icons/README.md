Yaru Icons & Cursors
====================

This project is a revitalization of the Suru icon set that was designed for Ubuntu Touch. The principles and styles created for Suru now serve as the basis for a new FreeDesktop icon theme.

## Copying or Reusing

This project has mixed licensing. You are free to copy, redistribute and/or modify aspects of this work under the terms of each licence accordingly (unless otherwise specified).

The Yaru icon assets (any and all source `.svg` files or rendered `.png` files) are licensed under the terms of the [Creative Commons Attribution-ShareAlike 4.0 License](https://creativecommons.org/licenses/by-sa/4.0/).

Included scripts are free software licensed under the terms of the [GNU General Public License, version 3](https://www.gnu.org/licenses/gpl-3.0.txt).

## Installing & Using

You can build and install Yaru from source using Meson.

```bash
# build
meson "build" --prefix=/usr
# install
sudo ninja -C "build" install
```

By default it installs to `/usr/` but you can specify a different directory with a prefix like: `/usr/local` or `$HOME/.local`.

After which you should be able to pick Yaru as your icon or cursor theme in GNOME Tweak tool, or you can set either from a terminal with:

```bash
# set the icon theme
gsettings set org.gnome.desktop.interface icon-theme "Yaru"
# or the cursor theme
gsettings set org.gnome.desktop.interface cursor-theme "Yaru"
```

### Uninstalling Yaru

To uninstall Yaru, simply run the following. (If you installed it without superuser privileges just omit the  `sudo`.)

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

## Generating accent color icons

Assets must be provided in the fullcolor `accented` subfolder, using colors that can be replaced via `colorize-dummy-svg.py`
(that generates the colors from gtk themes using `yaru-colors-defs.scss·`)

To generate the icons you need to use meson:
```bash
# On the project root
meson build
ninja -C build render-accented-icons

# You can also render just one accent with
ninja -C build render-icons-[variant] # build-render-icons-blue

```
