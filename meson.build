project('suru-icon-theme',
    version: '0.1',
    meson_version: '>= 0.40',
    license: 'GPL-3.0',
    default_options: ['prefix=/usr']
)

install_subdir('Suru',
    install_dir: join_paths(get_option('prefix'), 'share/icons')
)

meson.add_install_script('meson_post_install.py')
