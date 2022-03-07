fs = import('fs')

foreach flavour: flavours
  suffix = flavour == 'default' ? '' : '-@0@'.format(flavour)
  theme_name = meson.project_name() + suffix
  theme_dir = join_paths(get_option('datadir'), 'themes', theme_name)
  metacity_dir = join_paths(theme_dir, 'metacity-1')

  conf_data = configuration_data()
  conf_data.set('ThemeName', meson.project_name())
  conf_data.set('FlavourThemeName', theme_name)

  configure_file(
    input: join_paths(flavour, 'metacity-theme-1.xml.in'),
    output: '@0@-metacity-theme-1.xml'.format(flavour),
    configuration: conf_data,
    install_dir: metacity_dir
  )

  # install thumbnail (cinnamon only)
  if get_option('cinnamon-shell')
    if fs.is_file(join_paths(flavour, 'thumbnail.png'))
      install_data(
        join_paths(flavour, 'thumbnail.png'),
        install_dir: metacity_dir
      )
    endif
  endif

  # install metacity assets
  metacity_asset_dir = join_paths(flavour, 'metacity-1')
  metacity_svg_data = run_command(
    'find', metacity_asset_dir, '-name', '*.svg'
    ).stdout().strip().split('\n')

  metacity_assets_dest = join_paths(theme_dir, 'metacity-1')
  install_data(metacity_svg_data, install_dir: metacity_assets_dest)

  meson.add_install_script('post_install.py', get_option('datadir'), meson.project_name(), flavour)
endforeach
