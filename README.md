# Ubuntu GTK+ 2 and 3 Communitheme

Ubuntu GTK+ 2 and 3 community theme.

## How to test it?

You can build the theme from source to test it locally. We're working on setting up a ppa and a Gnome session.

<!-- We have a set of packages creating a new "Ubuntu Communitheme session". Just install:

```sh
sudo apt install ubuntu-communitheme-session
```

Restart your computer, the login screen will have this theme by default, and a new session will be selectable in GDM named "Ubuntu Communitheme". This will start the GNOME-Shell, GTK2, GTK3 themes and icon themes. -->

## How to build from source and install it?

We are using `meson` and `ninja` to build and install it. The following instructions install it in `/usr/share/themes`.

```sh
meson build --prefix=/usr
cd build
sudo ninja install
```

Now choose `Communitheme` in Gnome Tweaks.

You can do any modification in `<project_dir>/Communitheme`. Now, after any modifications you want to test, being in the `build` directory:

```sh
sudo ninja install
# <Alt-F2>, 'rt', <Enter>
```

## Why do we import from package content and not from upstream git repository?

We sync our version to be compatible with the GTK and GNOME Shell versions being in ubuntu repositories. This is why we sync from them (or rebase them as soon as we update a new version with changes in ubuntu).

## What is removed from the initial data/theme/ directory?

We remove on new version import:

* `*.in`, `Makefile.*`, `meson.build`: we have our own build system.
* `adwaita_engine.c`: we use the default adwaita engine
* `*.css`: we build these from the `*.cscc` sources
