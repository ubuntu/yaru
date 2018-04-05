# communitheme-snap-helpers
Various build and run helper for communitheme snap

Snap build status: [![Build Status](https://travis-ci.org/ubuntu/communitheme-snap-helpers.svg?branch=master)](https://travis-ci.org/ubuntu/communitheme-snap-helpers)

## Testing communitheme snap

You can install the **communitheme** snap and try it on Ubuntu 18.04 LTS by simply running: `snap install communitheme`.
After rebooting, a new "communitheme" entry will be available in the login screen, select it.

You should enter your normal user session with the GNOME Shell, application and icon themes applied, as well as a new set
of sound notifications and cursor.

Any new update of communitheme will come directly to you on a regular basis thanks to the snap without having to run any command!

If this is not the case, it can be due to your settings not being the default. You can reset them by running
`communitheme.reset` in a terminal.

### Tracking latest of latest

By default, you track manually tested and curated releases of communitheme snap. you can use the latest, as a snap is built
and published to the snap store when any project related to communitheme has changed (being GNOME Shell theme, or icon or…).

For switching to it, you can switch to the **edge** channel, by running: `snap refresh communitheme --edge`.

If you haven't install the snap yet but want to directly track the edge channel, you can run `snap install communitheme --edge`.
