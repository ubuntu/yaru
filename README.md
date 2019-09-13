# Yaru gtk-, gnome-shell-, icon- and sound-theme for Ubuntu using the GNOME desktop

Snap build status: [![Build Status](https://travis-ci.org/ubuntu/yaru.svg?branch=master)](https://travis-ci.org/ubuntu/yaru)

The Yaru theme is the default theme for Ubuntu, backed by the community.
This is the theme that is shaped by the community on the Ubuntu hub, turned into the default theme starting from Ubuntu 18.10 Cosmic Cuttlefish.

More information is available at https://community.ubuntu.com/t/faq-ubuntu-new-theme/1930.

![Files](https://i.imgur.com/Z2rJUjN.png)

![FilesDark](https://i.imgur.com/6jE83Uc.png)

![Dash](https://i.imgur.com/clAKaoi.png)

![Appgrid](https://i.imgur.com/SYiF2Sc.png)

![ShellPopups](https://i.imgur.com/lYdieEX.png)

![Shell OSD](https://i.imgur.com/K3KRgzz.png)

![widgetfactorylight](https://i.imgur.com/ZgT7rtu.png)

![widgetfactorydark](https://i.imgur.com/5VG9wGB.png)

It contains:
 * a GNOME Shell theme
 * a GTK2 and GTK3 theme
 * an icon & cursor theme, derived from the Unity8 Suru icons and [Suru icon](https://snwh.org/suru) theme.
 * a sound theme, combining sounds from the [WoodenBeaver](https://github.com/madsrh/WoodenBeaver) and [Touch-Remix](https://github.com/madsrh/TouchRemix) sound themes with an emphasis on making sound a usability feature instead of an annoyance.

## Yaru on Ubuntu

Yaru theme is the default theme suite for Ubuntu and you receive it when installing Ubuntu 18.10+.
Installing from source is not recommended for average usage.

## Install legacy Yaru/Communitheme snap on Ubuntu 18.04 (bionic beaver)

> Note that for backward compatibility, we kept the name "communitheme" for bionic beaver. It's up to date with bionic branch of Yaru where we try to cherry-pick as much Gtk and Icon theme changes from master as possible. However only icon and sound updates will be pushed into this version of the theme suite.

*Note that these steps only work on Ubuntu 18.04 (bionic beaver). DO NOT install the snap on 18.10+ installations*

Follow these steps in order to install and enable communitheme.

1. Install the communitheme snap on 18.04 by installing `communitheme` in the Ubuntu Software Application or running `snap install communitheme`.
2. Restart your computer. The login screen will now use Communitheme by default. Click on your user, click on the gear icon ans select the "Ubuntu with communitheme snap" session from the login screen, and login.
3. Now everything is using the communitheme including applications, icons, sound notifications and cursor. Any new update of communitheme will come directly to you on a regular basis thanks to the snap without having to run any command!

![install](https://i.imgur.com/Vykmt6N.gif)

![login](https://i.imgur.com/1boZU4F.gif)

## Copying or Reusing

This project has mixed licencing. You are free to copy, redistribute and/or modify aspects of this work under the terms of each licence accordingly (unless otherwise specified).

The Suru icon assets (any and all source `.svg` files or rendered `.png` files) are licensed under the terms of the [Creative Commons Attribution-ShareAlike 4.0 License](https://creativecommons.org/licenses/by-sa/4.0/).

Included scripts are free software licensed under the terms of the [GNU General Public License, version 3](https://www.gnu.org/licenses/gpl-3.0.txt).

## I want to be part of it!

Great, we're looking forward to your PR!

Read [CONTRIBUTING.md](./CONTRIBUTING.md) to figure out how to get started.
