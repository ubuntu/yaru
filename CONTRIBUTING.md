# Contributing to Communitheme

Communitheme consists of three parts. Each part is located in a different repository. Make sure to use the contributing instructions for the right part.

- [`gnome-shell-communitheme`](https://github.com/ubuntu/gnome-shell-communitheme) is the theme for the gnome shell. This themes stuff like the calendar widget, the Ubuntu dock, the top panel, the login screen and more.
- [`gtk-communitheme`](https://github.com/ubuntu/gtk-communitheme) themes gtk+2 and gtk+3. This specifies how applications like Files, Terminal, Ubuntu Software look.
- [`suru-icon-theme`](https://github.com/ubuntu/suru-icon-theme) contains all the icons.

## Build and install `gnome-shell-communitheme` from source

This installation method is to try out the theme while developing it. If you're not a developer, use the daily build ppa as specified in the [README.md](./README.md).

 **These instructions are for the gnome-shell theme only, refer to the other repositories for the other parts.**

We are using `meson` and `ninja` to build and install it. GNOME Shell only recognizes themes in its path by default, so you need to install it in `/usr/share/gnome-shell/theme` by default.

```sh
meson build --prefix=/usr
cd build
sudo ninja install
```

Log now into the Ubuntu Communitheme session.

You can do any modification in `<project_dir>/communitheme`. Now, after any modifications you want to test, being in the `build` directory:

```sh
sudo ninja install
# <Alt-F2>, 'rt', <Enter>
```

Finally, if you want to change the GDM look and point to the same stylesheet:

```sh
update-alternatives --install /usr/share/gnome-shell/theme/gdm3.css gdm3.css /usr/share/gnome-shell/theme/communitheme/gnome-shell.css 15
```

## Why do we import from package content and not from upstream git repository?

We sync our version to be compatible with the GTK and GNOME Shell versions being in ubuntu repositories. This is why we sync from them (or rebase them as soon as we update a new version with changes in ubuntu).

## What is removed from the initial data/theme/ directory?

We remove on new version import:

- upstream `gnome-shell*.css`: they are generated them with our modifications
- upstream `meson.build`: we define our own
- `data/theme/parse-sass.sh`: we handle building directly with meson.
