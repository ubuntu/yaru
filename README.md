# communitheme-snap-helpers
Various build and run helper for communitheme snap

Snap build status: [![Build Status](https://travis-ci.org/ubuntu/communitheme-snap-helpers.svg?branch=master)](https://travis-ci.org/ubuntu/communitheme-snap-helpers)

## Testing communitheme snap

We're currently still developing the theme, but you can try it out for yourself. Be warned though, this is a pre-release alpha state. These packages are mainly intended for the Communitheme designers to get a sense of what actually works in Ubuntu. **Many icons are missing, some stuff is just a white squircle. You will find issues and stuff will break.**

You can install the **communitheme** snap and try it on Ubuntu 18.04 LTS by simply running: `snap install communitheme` or from the Ubuntu Software application.

Restart your computer, the login screen will use Communitheme by default. Select the "Ubuntu with communitheme snap" session from the login screen (click the gear) and login.

You should enter your normal user session with the GNOME Shell, application and icon themes applied, as well as a new set
of sound notifications and cursor.

Any new update of communitheme will come directly to you on a regular basis thanks to the snap without having to run any command!

If this is not the case, it can be due to your settings not being the default. You can reset them by installing the **communitheme-set-default** snap, via: `snap install communitheme-set-default --classic`.

Then, just run `sudo communitheme-set-default` in a terminal to reset the session. It will as well set it as default in the login screen at next reboot.

If you want to reset default login screen theme, you can run `sudo communitheme-set-default remove`.

### Tracking latest of latest

By default, you track manually tested and curated releases of communitheme snap. you can use the latest, as a snap is built
and published to the snap store when any project related to communitheme has changed (being GNOME Shell theme, or icon or…).

For switching to it, you can switch to the **edge** channel, by running: `snap refresh communitheme --edge`.
If you want to follow the **edge** content for snap applications, you will need as well to switch `gtk-common-theme` snap
to the same channel: `snap refresh gtk-common-themes --edge`.

If you haven't install the snap yet but want to directly track the edge channel, you can run `snap install communitheme --edge`.
