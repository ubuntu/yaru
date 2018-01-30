![Sounds](/banner.jpg)

This sound theme is an accompaniment for the [Ubuntu Communitheme](https://github.com/Ubuntu/gtk-communitheme/). It combines sounds from the [WoodenBeaver](https://github.com/madsrh/WoodenBeaver) and [Touch-Remix](https://github.com/madsrh/TouchRemix) sound themes with an emphasis on making sound a usability feature instead of an annoyance. We're clipping out things like 'button-pressed' and 'service-logout', and working towards shorter and less intrusive, more refined audio set.

 
The system notifications are played on a wooden percussion instrument to give the theme an african feeling. To make the theme feel light and responsive, the sounds are very short and there's no reverb or delay added.
The desktop-login sound is based on [Jouni Helminen's awesome work for Ubuntu Touch](https://youtu.be/XnyopqW3Af8?t=2m48s).

---

## How to test it

### Installation instruction

You can install communitheme-sounds from source using the Meson build system.

````
meson builddir --prefix=/usr
sudo ninja -C builddir install
````

### How to activate the theme

To change your current desktop sound theme, you can use `dconf-editor` to change the setting key `/org/gnome/desktop/sound/theme-name/` to `communitheme`

### Testing input feedback sounds

In `dconf-editor`, change the key `/org/gnome/desktop/sound/input-feedback-sound` to `true` and enjoy more sounds to test.

---

### Testing desktop-login sound

Type in a terminal `gnome-session-properties`. It'll give you the list of starting applications. Click on "add", and type the following informations in the dialog shown :

- **Name:** `GNOME Login Sound`

- **Command:** `/usr/bin/canberra-gtk-play --id="desktop-login" --description="GNOME Login"`

- **Comment:** `Plays a sound whenever you log in`

---

### Testing from the desktop

A quick and easy way to test if the sounds are installed correctly, is by triggering them from the desktop. Here's a few places that will trigger a notification:

- Open a texteditor (like Gedit or even the terminal) and press backspace or delete
- Open two tabs in Firefox and close the window
- Adding / removing a USB drive
- Clicking the volumeslider in the system menu in the top right corner

---

This project is licensed under CC-BY-SA 3.0.

The meson script, the build instruction and the banner icon are taken from the [Suru icon theme](https://github.com/snwh/suru-icon-theme)
