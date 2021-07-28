foreach flavour: flavours
  suffix = flavour == 'default' ? '' : '-@0@'.format(flavour)
  theme_name = meson.project_name() + suffix
  theme_dir = join_paths(get_option('datadir'), 'themes', theme_name)
  metacity_dir = join_paths(theme_dir, 'metacity-1')

  conf_data = configuration_data()
  conf_data.set('ThemeName', meson.project_name())
  conf_data.set('FlavourThemeName', theme_name)

  if flavour == 'dark'
    conf_data.set('titlebar', '#2c2c2c')
    conf_data.set('titlebar_unfocused', '#3e3e3e')
    conf_data.set('titlebar_border_focused', '#232323')
    conf_data.set('titlebar_border_unfocused', '#222222')
    conf_data.set('titlebar_highlight_focused', '#3a3a3a')
    conf_data.set('titlebar_highlight_unfocused', '#4b4b4b')
    conf_data.set('border_focused', '#232323')
    conf_data.set('border_unfocused', '#222222')
    conf_data.set('title_focused', '#f7f7f7')
    conf_data.set('title_unfocused', '#d2d2d2')
  elif flavour == 'default'
    conf_data.set('titlebar', '#dedede')
    conf_data.set('titlebar_unfocused', '#f7f7f7')
    conf_data.set('titlebar_border_focused', '#919191')
    conf_data.set('titlebar_border_unfocused', '#b8b8b8')
    conf_data.set('titlebar_highlight_focused', '#f8f8f8')
    conf_data.set('titlebar_highlight_unfocused', '#fdfdfd')
    conf_data.set('border_focused', '#919191')
    conf_data.set('border_unfocused', '#b8b8b8')
    conf_data.set('title_focused', '#3d3d3d')
    conf_data.set('title_unfocused', '#626262')
  endif

  configure_file(input: 'metacity-theme-1.xml.in',
    output: '@0@-metacity-theme-1.xml'.format(flavour),
    configuration: conf_data,
    install_dir: metacity_dir
  )

  # install metacity assets
  metacity_asset_dir = join_paths(flavour, 'metacity-1')
  metacity_svg_data = run_command(
    'find', metacity_asset_dir, '-name', '*.svg'
    ).stdout().strip().split('\n')

  metacity_assets_dest = join_paths(theme_dir, 'metacity-1')
  install_data(metacity_svg_data, install_dir: metacity_assets_dest)

  meson.add_install_script('post_install.py', get_option('datadir'), meson.project_name(), flavour)
endforeach
