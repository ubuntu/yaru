foreach flavour: flavours
  foreach scale: ['', '-hdpi', '-xhdpi']
    suffix = flavour == 'default' ? '' : '-@0@'.format(flavour)
    theme_name = meson.project_name() + suffix + scale
    theme_dir = join_paths(get_option('datadir'), 'themes', theme_name)

    # install xfwm4 assets and themerc
    xfwm4_sources_dir = join_paths(flavour, 'xfwm4')
    xfwm4_sources_data = run_command(
      'find', xfwm4_sources_dir, '-name', '*rc'
      ).stdout().strip().split('\n')

    xfwm4_sources_dest = join_paths(theme_dir, 'xfwm4')
    install_data(xfwm4_sources_data, install_dir: xfwm4_sources_dest)

    xfwm4_asset_dir = join_paths(xfwm4_sources_dir, 'assets' + scale)
    install_subdir(xfwm4_asset_dir, install_dir: xfwm4_sources_dest, strip_directory: true,)
  endforeach
endforeach
