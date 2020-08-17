---
name: Bug report
about: Report a bug to help us improve Yaru
title: ''
labels: ''
assignees: ''

---

<!--
Thank you for contributing to **Yaru**, the Ubuntu's default Theme made by the Community.

If you found a bug please consider to fill below information, this will help us to understand the problem and we don't bother you with other questions :)

Thanks a lot!

(NOTE: you can remove all the text outside the "ISSUE TEMPLATE" message, thanks!)

------ ISSUE TEMPLATE starts HERE ------>

**Expected Behavior**

(What you were trying to do)

**Actual Behavior**

(What happened instead)

**Steps to Reproduce the Problem**

  1.
  1.
  1.

**Software that presents the issue**

- Name:
- Version:


**Yaru version**

Please report the Yaru version in your system using one of the following commands

* If you installed Yaru from PPA

    `$ apt show communitheme`

* If you installed Yaru via Snap

    `$ snap info communitheme`

* I you installed from the sources, go the Yaru folder and copy the output of the following terminal command instead

    `$ git describe`

**Upstream check**

Please also check if the problem also occurs with the Adwaita upstream theme:

- If the bug is related to an application, change the Gtk theme by running the following command:

    `gsettings set org.gnome.desktop.interface gtk-theme Adwaita`

- If the bug is about the icon theme, switch to Adwaita icon theme with this one:

    `gsettings set org.gnome.desktop.interface icon-theme Adwaita`

- If the bug concerns Gnome-shell, log-out then reconnect you using the Gnome session (click on the gear for switch).

Then check if the problem is still there.
