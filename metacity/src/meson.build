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
    conf_data.set('border_focused', '#232323')
    conf_data.set('border_unfocused', '#222222')
    conf_data.set('title_focused', '#f5f5f5')
    conf_data.set('title_unfocused', '#dedede')
    conf_data.set('wm_button_background', '#2c2c2c')
    conf_data.set('wm_button_foreground', '#2c2c2c')
    conf_data.set('wm_button_unfocused', '#3e3e3e')
    conf_data.set('close_button', '#787878')
    conf_data.set('maximize_button', '#787878')
    conf_data.set('restore_button', '#787878')
    conf_data.set('minimize_button', '#787878')
  elif flavour == 'light'
    conf_data.set('titlebar', '#dedede')
    conf_data.set('titlebar_unfocused', '#f7f7f7')
    conf_data.set('titlebar_border_focused', '#919191')
    conf_data.set('titlebar_border_unfocused', '#b8b8b8')
    conf_data.set('border_focused', '#919191')
    conf_data.set('border_unfocused', '#b8b8b8')
    conf_data.set('title_focused', '#000000')
    conf_data.set('title_unfocused', '#2c2c2c')
    conf_data.set('wm_button_background', '#dedede')
    conf_data.set('wm_button_foreground', '#dedede')
    conf_data.set('wm_button_unfocused', '#f7f7f7')
    conf_data.set('close_button', '#787878')
    conf_data.set('maximize_button', '#787878')
    conf_data.set('restore_button', '#787878')
    conf_data.set('minimize_button', '#787878')
  elif flavour == 'default'
    conf_data.set('titlebar', '#323030')
    conf_data.set('titlebar_unfocused', '#3f3c3c')
    conf_data.set('titlebar_border_focused', '#232323')
    conf_data.set('titlebar_border_unfocused', '#222222')
    conf_data.set('border_focused', '#919191')
    conf_data.set('border_unfocused', '#b8b8b8')
    conf_data.set('title_focused', '#f5f5f5')
    conf_data.set('title_unfocused', '#dedede')
    conf_data.set('wm_button_background', '#323030')
    conf_data.set('wm_button_foreground', '#323030')
    conf_data.set('wm_button_unfocused', '#3f3c3c')
    conf_data.set('close_button', '#787878')
    conf_data.set('maximize_button', '#787878')
    conf_data.set('restore_button', '#787878')
    conf_data.set('minimize_button', '#787878')
  endif

  configure_file(input: 'metacity-theme-1.xml.in',
    output: '@0@-metacity-theme-1.xml'.format(flavour),
    configuration: conf_data,
    install_dir: metacity_dir
  )

  # install metacity assets
  metacity_asset_dir = join_paths(flavour, 'metacity-1')
  metacity_png_data = run_command(
    'find', metacity_asset_dir, '-name', '*.png'
    ).stdout().strip().split('\n')

  metacity_assets_dest = join_paths(theme_dir, 'metacity-1')
  install_data(metacity_png_data, install_dir: metacity_assets_dest)

  meson.add_install_script('post_install.py', get_option('datadir'), meson.project_name(), flavour)
endforeach
