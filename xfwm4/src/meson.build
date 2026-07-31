foreach flavour: flavours
  foreach scale: ['', '-hdpi', '-xhdpi']
    suffix = flavour == 'default' ? '' : '-@0@'.format(flavour)
    theme_name = meson.project_name() + suffix + scale
    theme_dir = get_option('datadir') / 'themes' / theme_name

    # install xfwm4 assets and themerc
    xfwm4_sources_dir = flavour / 'xfwm4'
    xfwm4_sources_data = run_command(
      'find', xfwm4_sources_dir, '-name', '*rc',
      check: false,
      ).stdout().strip().split('\n')

    xfwm4_sources_dest = theme_dir / 'xfwm4'
    install_data(xfwm4_sources_data, install_dir: xfwm4_sources_dest)

    install_subdir(
      xfwm4_sources_dir / ('assets' + scale),
      install_dir: xfwm4_sources_dest,
      strip_directory: true,
    )
  endforeach
endforeach
