sassc = find_program('sassc')

variants = [
  'gtk',
  'gtk-dark'
]
gtk_versions = [
  '2.0',
  '3.0',
  '4.0'
]

foreach flavour: flavours
  message('Configuring flavour ' + flavour)
  suffix = flavour == 'default' ? '' : '-@0@'.format(flavour)
  theme_name = meson.project_name() + suffix
  theme_dir = join_paths(get_option('datadir'), 'themes', theme_name)

  conf_data = configuration_data()
  conf_data.set('ThemeName', meson.project_name())
  conf_data.set('FlavourThemeName', theme_name)
  configure_file(input: 'index.theme.in',
    output: '@0@-index.theme'.format(theme_name),
    configuration: conf_data,
    install_dir: theme_dir
  )

  # build and install gtk data
  foreach gtk_ver: gtk_versions
    gtk_dir = 'gtk-@0@'.format(gtk_ver)
    base_path = (flavour.startswith('mate') ? 'mate' : 'default') / gtk_dir
    dark_path = flavour.endswith('-dark') ? 'dark' : base_path
    default_path = 'default' / gtk_dir
    upstream_path = '..' / 'upstream' / gtk_dir / 'Adwaita'
    flavour_path = join_paths(flavour, gtk_dir)
    install_path = theme_dir / gtk_dir

    # Sort by most relevant for the theme flavour
    sources_priority = [
      flavour_path,
      dark_path,
      base_path,
      default_path,
      upstream_path,
    ]

    if gtk_ver == '2.0'
      rc_paths = []
      foreach src: sources_priority
        rc_paths = [ src ] + rc_paths
      endforeach

      gtk2_sources_data = run_command(
        'find',
        rc_paths,
        '-name', '*rc'
        ).stdout().strip().split('\n')

      install_data(gtk2_sources_data, install_dir: install_path)

      assets_paths = []
      foreach src: sources_priority
        assets_paths = [ src / 'assets' ] + assets_paths
      endforeach

      gtk2_asset_data = run_command(
        'find', assets_paths, '-name', '*.png'
        ).stdout().strip().split('\n')

      install_data(gtk2_asset_data, install_dir: install_path / 'assets')

      continue
    endif

    gtk_scss_dependencies = run_command(
        'find', flavour_path, '-name', '_*.scss'
        ).stdout().strip().split('\n')

    if gtk_scss_dependencies.length() == 1 and gtk_scss_dependencies[0] == ''
      gtk_scss_dependencies = []
    endif

    gtk_css = []
    generated_css = []
    foreach variant : variants
      message('Configuring @0@ variant for @1@-@2@'.format(
        theme_name, variant, gtk_ver))
      is_dark = variant.endswith('-dark')
      target_name = '@0@-@1@-@2@'.format(theme_name, variant, gtk_ver)
      gtk_scss_path = flavour_path / variant + '.scss'

      if not fs.is_file(gtk_scss_path)
        gtk_scss_path = base_path / variant + '.scss'
      endif

      if enabled_accent_colors.contains(flavour)
          accent = flavour
          gtk_accents_css = configure_file(
            configuration: {
              'yaru_dark_variant': is_dark ? 'true' : 'false',
              'yaru_accent_color': accent,
              'yaru_theme_entry_point': meson.current_source_dir() / gtk_scss_path,
            },
            input: project_source_root / 'common' / 'accent-colors.scss.in',
            output: '@0@-@1@-@2@-accent-colors.scss'.format(theme_name, variant, gtk_ver),
          )

          gtk_scss_path = gtk_accents_css
      endif

      # Look for scss files in the variant dir first, otherwise fallback to
      # base, default or upstream paths, so using reversed order
      scss_paths = []
      foreach src: sources_priority
        scss_paths += ['-I', meson.current_source_dir() / src ]
      endforeach

      generated_css += custom_target(target_name,
        input: gtk_scss_path,
        output: '@0@-generated.css'.format(target_name),
        depend_files: files(gtk_scss_dependencies),
        command: [
          sassc, '-a',
          scss_paths,
          '@INPUT@', '@OUTPUT@'],
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
    install_data(gtk_css, install_dir: install_path)

    foreach src: sources_priority
      assets_rel_dir = src / 'assets'
      if fs.is_dir(assets_rel_dir)
        break
      endif
    endforeach

    assets = run_command(
      'ls', '-1', assets_rel_dir
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
      install_dir: install_path,
    )

    # install thumbnail (cinnamon only)
    if fs.is_file(join_paths(flavour_path, 'thumbnail.png'))
      install_data(
        flavour_path / 'thumbnail.png',
        install_dir: install_path,
      )
    endif
  endforeach
endforeach

meson.add_install_script('post_install.py', get_option('datadir'), meson.project_name(), flavours)
