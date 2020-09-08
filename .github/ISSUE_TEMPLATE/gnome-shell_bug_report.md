---
name: Gnome-shell bug report
about: Report a bug related to our Gnome-shell theme to help us improve Yaru
title: ''
labels: 'Area: GNOME-shell'
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

**Screenshots**

(Insert here some screenshots to help explain your problem)

**Steps to Reproduce the Problem**

1. Go to '...'
2. Click on '....'
3. Scroll down to '....'
4. See problem

**System information**

- Shell version: (run `$ gnome-shell --version`) [e.g. 3.36.3]
- OS version: (run `$ lsb_release -a`) [e.g. Ubuntu 20.04.1]

**Yaru version**

Please report the Yaru version in your system using one of the following commands

* If you just use the default Ubuntu session (since Ubuntu 18.10)

    `$ apt show yaru-theme-gnome-shell`

* If you installed Yaru via Snap (Ubuntu 18.04 only)

    `$ snap info communitheme`

* If you installed from the sources, go the Yaru folder and copy the output of the following terminal command instead

    `$ git describe`

**Upstream check**

Please also check if the problem also occurs with the Adwaita upstream theme. To do that, firstly install Gnome session:

    `$ sudo apt install gnome-session`

Then log-out, reconnect you using the Gnome session (click on the gear for switch), and check if the problem is still there.
