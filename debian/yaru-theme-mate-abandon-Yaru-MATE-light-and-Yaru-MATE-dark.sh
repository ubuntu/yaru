#!/bin/sh

yaru_mate_light_name="'Yaru-MATE-light'"
yaru_mate_dark_name="'Yaru-MATE-dark'"
yaru_mate_new_name="'Yaru-mate'"
yaru_mate_dark_new_name="'Yaru-mate-dark'"
yaru_cursor_name="'Yaru'"

if [ "$(gsettings get org.mate.desktop.interface gtk-theme)" = "$yaru_mate_light_name" ]; then
    gsettings set org.mate.desktop.interface gtk-theme "$yaru_mate_new_name"
fi

if [ "$(gsettings get org.mate.desktop.interface gtk-theme)" = "$yaru_mate_dark_name" ]; then
    gsettings set org.mate.desktop.interface gtk-theme "$yaru_mate_dark_new_name"
fi

if [ "$(gsettings get org.mate.desktop.interface icon-theme)" = "$yaru_mate_light_name" ] || [ "$(gsettings get org.mate.desktop.interface icon-theme)" = "$yaru_mate_dark_name" ]; then
    gsettings set org.mate.desktop.interface icon-theme "$yaru_mate_new_name"
fi

if [ "$(gsettings get org.mate.desktop.peripherals.mouse cursor-theme)" = "$yaru_mate_light_name" ] || [ "$(gsettings get org.mate.desktop.peripherals.mouse cursor-theme)" = "$yaru_mate_dark_name" ]; then
    gsettings set org.mate.desktop.peripherals.mouse cursor-theme "$yaru_cursor_name"
fi

if [ "$(gsettings get org.mate.pluma color-scheme)" = "$yaru_mate_light_name" ]; then
    gsettings set org.mate.pluma color-scheme "$yaru_mate_new_name"
fi

if [ "$(gsettings get org.mate.pluma color-scheme)" = "$yaru_mate_dark_name" ]; then
    gsettings set org.mate.pluma color-scheme "$yaru_mate_dark_new_name"
fi
