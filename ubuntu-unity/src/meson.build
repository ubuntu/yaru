foreach flavour: flavours
  suffix = flavour == 'default' ? '' : '-@0@'.format(flavour)
  theme_name = meson.project_name() + suffix
  theme_dir = get_option('datadir') / 'themes' / theme_name

  # install unity assets
  unity_asset_dir = flavour / 'unity'
  unity_asset_data = run_command(
    'find', unity_asset_dir, '-name', '*.svg',
    check: true,
    ).stdout().strip().split('\n')

  install_data(unity_asset_data, install_dir: theme_dir / 'unity')
endforeach
