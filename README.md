# Communitheme default ubuntu theme

Snap build status: [![Build Status](https://travis-ci.org/ubuntu/communitheme.svg?branch=master)](https://travis-ci.org/ubuntu/communitheme)

Communitheme theme, which is going to be the default theme for ubuntu, entirely backed by the community.
This is the theme that is shaped by the community on the Ubuntu hub, which will turn into the default ubuntu theme.

More information is available at https://community.ubuntu.com/t/faq-ubuntu-new-theme/1930.

![Dash](https://i.imgur.com/Td2GLe5.png)

![widgetfactorylight](https://i.imgur.com/ZG7GIYM.png)

It contains:
 * a GNOME Shell theme
 * a GTK2 and GTK3 theme
 * an icon theme, derived from the [Suru icon](https://snwh.org/suru) theme.
 * a sound theme, vombining sounds from the [WoodenBeaver](https://github.com/madsrh/WoodenBeaver) and [Touch-Remix](https://github.com/madsrh/TouchRemix) sound themes with an emphasis on making sound a usability feature instead of an annoyance.

## Communitheme on Ubuntu 18.10

Communitheme theme will be the default in 18.10. Once you install it, you will get it by default as part of the distribution soon and will be automatically migrated to it.

You will receive there at regular intervals stable updates of the theme.

## Testing communitheme snap on Ubuntu 18.04 (bionic beaver)

We're currently still developing the theme, but you can try it out for yourself. Be warned though, this is a pre-release alpha state and not (yet) officially supported. These packages are mainly intended for the Communitheme designers to get a sense of what actually works in Ubuntu.

*Note that these steps only work on Ubuntu 18.04 (bionic beaver).*

Follow these steps in order to install and enable communitheme.

1. Install the communitheme snap on 18.04 by installing `communitheme` in the Ubuntu Software Application or running `snap install communitheme`.
2. Restart your computer. The login screen will now use Communitheme by default. Click on your user, click on the gear icon ans select the "Ubuntu with communitheme snap" session from the login screen, and login.
3. Now everything is using the communitheme including applications, icons, sound notifications and cursor. Any new update of communitheme will come directly to you on a regular basis thanks to the snap without having to run any command!

<!--  TODO: uncomment this when communitheme-set-default is in the store.
If this is not the case, it can be due to your settings not being the default. You can reset them by installing the **communitheme-set-default** snap, via: `snap install communitheme-set-default --classic`.

Then, just run `sudo communitheme-set-default` in a terminal to reset the session. It will as well set it as default in the login screen at next reboot.

If you want to reset default login screen theme, you can run `sudo communitheme-set-default remove`.
-->

The following video guides you through these steps.

[![Video guide](https://img.youtube.com/vi/azlreXxAigY/0.jpg)](https://www.youtube.com/watch?v=azlreXxAigY)

### Tracking latest of latest

By default, you track manually tested and curated releases of communitheme snap. you can use the latest, as a snap is built
and published to the snap store when any project related to communitheme has changed (being GNOME Shell theme, or icon or…).

For switching to it, you can switch to the **edge** channel, by running: `snap refresh communitheme --edge`.
If you want to follow the **edge** content for snap applications, you will need as well to switch `gtk-common-theme` snap
to the same channel: `snap refresh gtk-common-themes --edge`.

If you haven't install the snap yet but want to directly track the edge channel, you can run `snap install communitheme --edge`.

## Copying or Reusing

This project has mixed licencing. You are free to copy, redistribute and/or modify aspects of this work under the terms of each licence accordingly (unless otherwise specified).

The Suru icon assets (any and all source `.svg` files or rendered `.png` files) are licensed under the terms of the [Creative Commons Attribution-ShareAlike 4.0 License](https://creativecommons.org/licenses/by-sa/4.0/).

Included scripts are free software licensed under the terms of the [GNU General Public License, version 3](https://www.gnu.org/licenses/gpl-3.0.txt).

## I want to be part of it!

Great, we're looking forward to your PR!

Read [CONTRIBUTING.md](./CONTRIBUTING.md) to figure out how to get started.
