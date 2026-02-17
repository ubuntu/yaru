#!/usr/bin/env bash

set -eu

if [ -z "$(dconf read /org/gnome/desktop/interface/gtk-theme)" ]; then
    # User is using the default configuration, nothing to migrate.
    exit 0;
fi

current_theme=$(gsettings get org.gnome.desktop.interface gtk-theme)
if [[ "$current_theme" != "'Yaru"* ]]; then
    # No yaru in use, nothing to do.
    exit 0;
fi

accent_color=""

case "$current_theme" in
    "'Yaru-blue"*)
        accent_color="blue"
        ;;
    "'Yaru-prussiangreen"*)
        accent_color="teal"
        ;;
    "'Yaru-olive"*|"'Yaru-viridian"*)
        accent_color="green"
        ;;
    "'Yaru-bark"*)
        accent_color="brown"

        new_theme="Yaru-wartybrown"
        if [[ "$current_theme" == *"-dark'" ]]; then
            new_theme+="-dark"
        fi
        gsettings set org.gnome.desktop.interface gtk-theme "$new_theme"
        gsettings set org.gnome.desktop.interface icon-theme "$new_theme"

        echo "Goodbye bark, you're a lucky user of '$new_theme' now!"
        ;;
    "'Yaru-default"*)
        accent_color="orange"
        ;;
    "'Yaru-red"*)
        accent_color="red"
        ;;
    "'Yaru-magenta"*)
        accent_color="pink"
        ;;
    "'Yaru-purple"*)
        accent_color="purple"
        ;;
    "'Yaru-sage"*)
        accent_color="slate"
        ;;
    *)
        echo "Unknown yaru accent $current_theme"
        ;;
esac

if [ -n "$accent_color" ] &&
   [ -z "$(dconf read /org/gnome/desktop/interface/accent-color)" ]; then
    echo "Using accent color '$accent_color'"
    gsettings set org.gnome.desktop.interface accent-color "$accent_color"
fi

if [[ "$current_theme" == *"-dark'" ]]; then
    color_scheme="prefer-dark"
else
    color_scheme="prefer-light"
fi

if [ -z "$(dconf read /org/gnome/desktop/interface/color-scheme)" ]; then
    echo "Using color scheme '$color_scheme'"
    gsettings set org.gnome.desktop.interface color-scheme "$color_scheme"
fi
