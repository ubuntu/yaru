gnome = import('gnome')
sassc = find_program('sassc')

variants = [
  'gtk',
  'gtk-dark'
]
gtk_versions = [
  '3.0',
  '3.20'
]

foreach flavour: flavours
  suffix = flavour == 'default' ? '' : '-@0@'.format(flavour)
  theme_name = meson.project_name() + suffix
  theme_dir = join_paths(get_option('datadir'), 'themes', theme_name)

  conf_data = configuration_data()
  conf_data.set('ThemeName', theme_name)
  conf_data.set('FlavourThemeName', theme_name)
  configure_file(input: 'index.theme.in',
    output: '@0@-index.theme'.format(theme_name),
    configuration: conf_data,
    install_dir: theme_dir
  )

  # install unity assets
  if flavour == 'default' and get_option('ubuntu-unity')
    unity_asset_dir = join_paths('default', 'unity')
    unity_asset_data = run_command(
      'find', unity_asset_dir, '-name', '*.svg'
      ).stdout().strip().split('\n')

    unity_assets_dest = join_paths(theme_dir, 'unity')
    install_data(unity_asset_data, install_dir: unity_assets_dest)
  endif

  # install gtk2 data
  gtk2_sources_dir = join_paths(flavour, 'gtk-2.0')
  gtk2_sources_data = run_command(
    'find', gtk2_sources_dir, '-name', '*rc'
    ).stdout().strip().split('\n')

  gtk2_sources_dest = join_paths(theme_dir, 'gtk-2.0')
  install_data(gtk2_sources_data, install_dir: gtk2_sources_dest)

  gtk2_asset_dir = join_paths(gtk2_sources_dir, 'assets')
  gtk2_asset_data = run_command(
    'find', gtk2_asset_dir, '-name', '*.png'
    ).stdout().strip().split('\n')

  gtk2_assets_dest = join_paths(gtk2_sources_dest, 'assets')
  install_data(gtk2_asset_data, install_dir: gtk2_assets_dest)

  # build and install gtk3 data
  foreach gtk_ver: gtk_versions
    gtk_dir = 'gtk-@0@'.format(gtk_ver)
    sources_relative_path = join_paths(flavour, gtk_dir)

    gtk3_scss_dependencies = run_command(
        'find', sources_relative_path, '-name', '_*.scss'
        ).stdout().strip().split('\n')

    gtk_css = []
    generated_css = []
    foreach variant : variants
      target_name = '@0@-@1@-@2@'.format(theme_name, variant, gtk_ver)
      gtk_scss_path = join_paths(sources_relative_path, variant)

      generated_css += custom_target(target_name,
        input: '@0@.scss'.format(gtk_scss_path),
        output: '@0@-generated.css'.format(target_name),
        depend_files: files(gtk3_scss_dependencies),
        command: [sassc, '-a', '@INPUT@', '@OUTPUT@'],
      )

      conf_data = configuration_data()
      conf_data.set('THEME_NAME', theme_name)
      conf_data.set('GTK_VER', gtk_ver)
      gtk_css += configure_file(
        input: 'data/@0@.css.in'.format(variant),
        output: '@0@.css'.format(target_name),
        configuration: conf_data
      )
    endforeach
    install_data(gtk_css, install_dir: join_paths(theme_dir, gtk_dir))

    assets_rel_dir = join_paths(sources_relative_path, 'assets')
    assets = run_command(
      'ls', assets_rel_dir
    ).stdout().strip().split('\n')

    assets_xml = []
    foreach asset: assets
      assets_xml += '    <file alias="assets/@0@">@1@</file>'.format(
          asset,
          join_paths(assets_rel_dir, asset)
        )
    endforeach

    conf_data = configuration_data()
    conf_data.set('THEME_NAME', theme_name)
    conf_data.set('GTK_VER', gtk_ver)
    conf_data.set('ASSETS', '\n'.join(assets_xml))
    gresource_xml = configure_file(
      input: 'data/gtk.gresource.xml.in',
      output: '@0@-@1@-gtk.gresource.xml'.format(theme_name, gtk_ver),
      configuration: conf_data)

    gresource_name = '@0@-@1@'.format(theme_name, gtk_dir)
    gnome.compile_resources(
      gresource_name,
      gresource_xml,
      dependencies: generated_css,
      gresource_bundle: true,
      install: true,
      install_dir: join_paths(theme_dir, gtk_dir),
    )

  endforeach
endforeach

meson.add_install_script('post_install.py', get_option('datadir'), meson.project_name(), flavours)
