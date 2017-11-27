# Ubuntu GNOME Shell CommuniTheme
ubuntu GNOME Shell community theme

## How to test it?

We have a set of packages creating a new "Ubuntu CommuniTheme session". Just install:

```sh
sudo apt install ubuntu-communitheme-session
```

Restart your computer, the login screen will have this theme by default, and a new session will be selectable in GDM named "Ubuntu CommuniTheme". This will start the GNOME-Shell, GTK2, GTK3 themes and icon themes.

## How to build from source and install it?

We are using `meson` and `ninja` to build and install it. GNOME Shell only recognizes themes in its path by default, so you need to install it in `/usr/share/gnome-shell/theme` by default.

```sh
meson build --prefix=/usr
cd build
sudo ninja install
```

Log now into the Ubuntu CommuniTheme session.

You can do any modification in `<project_dir>/communitheme`. Now, after any modifications you want to test, being in the `build` directory:

```sh
sudo ninja install
# <Alt-F2>, 'rt', <Enter>
```

Finally, if you want to change the GDM look and point to the same stylesheet:

```sh
update-alternatives --install /usr/share/gnome-shell/theme/gdm3.css gdm3.css /usr/share/gnome-shell/theme/ubuntu-communitheme/gnome-shell.css 15
```

## Why do we import from package content and not from upstream git repository?

We sync our version to be compatible with the GTK and GNOME Shell versions being in ubuntu repositories. This is why we sync from them (or rebase them as soon as we update a new version with changes in ubuntu).

## What is removed from the initial data/theme/ directory?

We remove on new version import:

* upstream `gnome-shell*.css`: they are generated them with our modifications
* upstream `meson.build`: we define our own
* `data/theme/parse-sass.sh`: we handle building directly with meson.

