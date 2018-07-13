xfiles = [
    'ubuntu-communitheme-xorg.desktop',
]
waylandfiles = [
    'ubuntu-communitheme.desktop',
]
gnome_shell_modes = [
    'ubuntu-communitheme.json',
]

# install Xorg files with symlink
install_data(xfiles, install_dir: join_paths(get_option('datadir'), 'xsessions'))
meson.add_install_script('sh', '-c', 'cd ' + join_paths('$MESON_INSTALL_DESTDIR_PREFIX', get_option('datadir'), 'xsessions') +
                         ' && rm -f ' + waylandfiles[0] +
                         ' && ln -s ' + xfiles[0] + ' ' + waylandfiles[0])

# install Wayland files
install_data(waylandfiles, install_dir: join_paths(get_option('datadir'), 'wayland-sessions'))

# session mode
install_data(gnome_shell_modes, install_dir: gnomeshell_mode_dir)
