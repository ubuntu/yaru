foreach flavour: flavours
  suffix = flavour == 'default' ? '' : '-@0@'.format(flavour)
  theme_name = meson.project_name() + suffix
  theme_dir = join_paths(get_option('datadir'), 'themes', theme_name)
  
  # install unity assets
  unity_asset_dir = join_paths(flavour, 'unity')
  unity_asset_data = run_command(
    'find', unity_asset_dir, '-name', '*.svg'
    ).stdout().strip().split('\n')

  unity_assets_dest = join_paths(theme_dir, 'unity')
  install_data(unity_asset_data, install_dir: unity_assets_dest)
endforeach
