# Contributing to Communitheme

Communitheme consists of three parts. Each part is located in a different repository but the instructions in this file cover all the repositories.

- [`gnome-shell-communitheme`](https://github.com/ubuntu/gnome-shell-communitheme) is the theme for the gnome shell. This themes stuff like the calendar widget, the Ubuntu dock, the top panel, the login screen and more.
- [`gtk-communitheme`](https://github.com/ubuntu/gtk-communitheme) themes gtk+2 and gtk+3. This specifies how applications like Files, Terminal, Ubuntu Software look.
- [`suru-icon-theme`](https://github.com/ubuntu/suru-icon-theme) contains all the icons.

## Build and install themes from source

This installation method is to try out the theme while developing it. If you're not a developer, use the daily build ppa as specified in the [README.md](./README.md).

**Gnome Shell theme**

```bash
# Download the repository from github
git clone https://github.com/ubuntu/gnome-shell-communitheme.git
cd gnome-shell-communitheme
# Initialize build system (only required once per repo)
meson build --prefix=/usr
cd build
# Build and install
sudo ninja install
```

If you want to change the GDM look and point to the same stylesheet. You only need to do this once.

```sh
update-alternatives --install /usr/share/gnome-shell/theme/gdm3.css gdm3.css /usr/share/gnome-shell/theme/communitheme/gnome-shell.css 15
```

**GTK theme**

```bash
# Download the repository from github
git clone https://github.com/ubuntu/gtk-communitheme.git
# Enter the directory you just cloned
cd gtk-communitheme
# Initialize build system (only required once per repo)
meson build --prefix=/usr
cd build
# Build and install
sudo ninja install
```

**Suru Icon theme**

```bash
# Download the repository from github
git clone https://github.com/ubuntu/suru-icon-theme.git
# Enter the directory you just cloned
cd suru-icon-theme
# Initialize build system (only required once per repo)
meson build --prefix=/usr
cd build
# Build and install
sudo ninja install
```

Now everything should be in place. Reboot and login to the `Communitheme on Xorg` session and set the Communitheme themes using Gnome Tweaks.

The GTK2 and GTK3 files go into `/usr/share/themes/Communitheme`. The shell files go into `/usr/share/gnome-shell/theme/communitheme`. You can edit the `gtk.css` and `gnome-shell.css` files in those folders directly for testing, or you can edit the SCSS files inside the folder you cloned from GitHub.

SCSS is the actual "source code" of the theme. This is compiled into the CSS files. Edit the SCSS if you want to contribute your changes back to us. SCSS is simple enough to get the hang of if you already know CSS. You can go through [this SCSS tutorial](http://marksheet.io/sass-scss-less.html) to learn more. After making your edits in the SCSS files, you can run `sudo ninja install` in the `gnome-shell-communitheme/build` folder for the Shell or the `gtk-communitheme/build` folder for GTK3/GTK2. That’ll do all the compiling and installing.

Changes to Gnome Shell theme are visible after doing <kbd>Alt</kbd> + <kbd>F2</kbd> and running <kbd>r</kbd> as command. The changes to GTK theme will be visible after running the following commands.

```bash
# To reload GTK theme
# Change to Adwaita theme and back to Communitheme
gsettings set org.gnome.desktop.interface gtk-theme Adwaita
gsettings set org.gnome.desktop.interface gtk-theme Communitheme
# To reload icon theme
# Change to Humanity icon theme and back to Suru
gsettings set org.gnome.desktop.interface icon-theme Humanity
gsettings set org.gnome.desktop.interface icon-theme Suru
```

## Quick testing in the GTK Inspector

To do some quick testing you can also use the GTK Inspector.

```bash
# Install inspector
sudo apt install libgtk-3-dev
# Enable the shortcut to open it
gsettings set org.gtk.Settings.Debug enable-inspector-keybinding true
```

Now you can open any program GTK3 program and press <kbd>CTRL</kbd> + <kbd>Shift</kbd> + <kbd>D</kbd> to bring up the inspector.

The most useful program to use with the inspector is the widget factory though. Which shows you basically every widget. Run `sudo apt install gtk-3-examples`, then run `gtk3-widget-factory` That will open the widget factory, then you can open the inspector with <kbd>CTRL</kbd> + <kbd>Shift</kbd> + <kbd>D</kbd> again.

Click the upper-left target button to select an object.

![](./docs/widget-factory1.png)

Select something like a button and you’ll see the following.

![](./docs/widget-factory2.png)

We don’t really care too much about that stuff so just click the dropdown button with “Miscellaneous” and select CSS nodes. Which shows you:

![](./docs/widget-factory3.png)

The element you selected will be highlighted within a list of *all elements* in the window. In the left pane you can see the name of the widget you clicked on (button) and its different CSS classes (.text-button .toggle). The right pane shows all the element’s CSS properties and values and where to find it in the gtk.css file. You can see all supported CSS properties in the inspector, but for something more detailed look at the [Gnome CSS Properties reference](https://developer.gnome.org/gtk3/stable/chap-css-properties.html).

Clicking the CSS tab will take you to a text entry window where you can type in CSS that will be applied.

![](./docs/widget-factory4.png)

Putting button `{ background-color: red; }` will make all buttons have a red background. It’s exactly like the inspect element tool in a web browser.

## Why do we import from package content and not from upstream git repository?

We sync our version to be compatible with the GTK and GNOME Shell versions being in ubuntu repositories. This is why we sync from them (or rebase them as soon as we update a new version with changes in ubuntu).

## GTK: What is removed from the initial directory?

We remove on new version import:

- `*.in`, `Makefile.*`, `meson.build`: we have our own build system.
- `adwaita_engine.c`: we use the default adwaita engine
- `*.css`: we build these from the `*.cscc` sources
