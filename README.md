Suru Icon Theme
================

This project is a revitalization of the Suru icon set that was designed for Ubuntu Touch. The principles and styles created for Suru now serve as the basis for a new FreeDesktop icon theme.

## Contributor Notes

 - Pull requests regarding branded, third-party application icons (for example, Google Chrome) will be rejected. Infringing upon third-party brands is a no-no in this set.
 - Development is focused on targeting the GNOME desktop, changes regarding other desktop environments (such as MATE or KDE) are not currently a priority.
 - See the README in the [icon sources folder](/src) for more about how to contribute or modify icons

## Copying or Reusing

This project is licenced under the terms of the [GNU General Public License, version 3](https://www.gnu.org/licenses/gpl-3.0.txt), so you are free to copy and reuse accordingly.

## Installing & Using

There are no official packages or releases (yet) but you can install this theme from source with the provided Meson build system.

```shell
meson builddir --prefix=/usr
sudo ninja -C builddir install
```

You can use a different prefix like: `/usr/local` or `$HOME/.local`

After which you should be able to pick Suru as your icon theme or set it with:

    gsettings set org.gnome.desktop.interface icon-theme Suru

### Removing Suru

To remove Suru, simply run: `ninja -C builddir uninstall` or, depending on whether or not you installed it with superuser priveleges: `sudo ninja -C builddir uninstall` 

## Donate

You can [donate](https://snwh.org/donate) to support the development of Suru or become a patron on [Patreon](http://patreon.com/snwh/). It goes without saying that your support is much appreciated. &#x1F60A;

