foreach flavour: flavours
  suffix = flavour == 'default' ? '' : '-@0@'.format(flavour)
  theme_name = meson.project_name() + suffix
  theme_dir = join_paths(get_option('datadir'), 'themes', theme_name, 'cinnamon')

  # Install CSS
  scss_dependencies = run_command(
    'find', flavour, '-name', '_*.scss'
  ).stdout().strip().split('\n')

  custom_target(theme_name,
    input: join_paths(flavour, 'cinnamon.scss'),
    output: '@0@.css'.format(theme_name),
    depend_files: files(scss_dependencies),
    command: [sassc, '-a', '@INPUT@', '@OUTPUT@'],
    install: true,
    install_dir: theme_dir,
  )

  # Install assets
  assets_folders = [
    'common-assets',
    'light-assets',
    'dark-assets'
  ]
  foreach asset_folder: assets_folders
    if fs.is_dir(join_paths(flavour, asset_folder))
      install_subdir(join_paths(flavour, asset_folder),
        install_dir: join_paths(theme_dir, asset_folder),
        strip_directory: true,
      )
    endif
  endforeach

  # Install thumbnail image
  install_data(join_paths(flavour, 'thumbnail.png'),
    install_dir: theme_dir
  )
endforeach

meson.add_install_script('post_install.py', get_option('datadir'), meson.project_name(), flavours)
