theme_dir = join_paths(get_option('prefix'), 'share/icons', meson.project_name())

install_subdir('Suru',
    install_dir: theme_dir,
    strip_directory: true,
    exclude_files: ['index.theme', 'cursor.theme'],
)

themes_f = [
  'cursor.theme',
  'index.theme',
]
conf_data = configuration_data()
conf_data.set('ThemeName', meson.project_name())
foreach theme: themes_f
  configure_file(input : 'Suru/@0@'.format(theme),
                 output : '@0@'.format(theme),
                 configuration : conf_data,
                 install_dir: theme_dir)
endforeach

meson.add_install_script('meson/post_install.py', meson.project_name())
