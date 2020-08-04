install_dir = join_paths(get_option('prefix'), 'share/libreoffice/share/config')
symlink_dir = join_paths(get_option('prefix'), 'lib/libreoffice/share/config')
file_name = 'images_' + meson.project_name().to_lower() + '.zip'

install_data('images_yaru.zip',
    install_dir: install_dir,
    rename: file_name
)

meson.add_install_script('meson/post_install.sh', install_dir + '/' + file_name, symlink_dir)
