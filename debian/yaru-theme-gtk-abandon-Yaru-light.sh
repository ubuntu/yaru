#!/bin/sh

yaru_light_name="'Yaru-light'"
yaru_new_name="'Yaru'"

if [ "$(gsettings get org.gnome.desktop.interface gtk-theme)" = "$yaru_light_name" ]; then
    gsettings set org.gnome.desktop.interface gtk-theme "$yaru_new_name"
fi

if [ "$(gsettings get org.gnome.gedit.preferences.editor scheme)" = "$yaru_light_name" ]; then
    gsettings set org.gnome.gedit.preferences.editor scheme "$yaru_new_name"
fi
