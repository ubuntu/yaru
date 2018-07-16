install_subdir('Suru',
    install_dir: join_paths(get_option('prefix'), 'share/icons', meson.project_name()),
    strip_directory: true,
)

meson.add_install_script('meson/post_install.py', meson.project_name())
