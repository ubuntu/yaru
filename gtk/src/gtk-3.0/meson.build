# gtk-3.0

gtk_dir = 'gtk-3.0'

foreach flavour: yaru_flavours
  suffix = flavour == 'default' ? '' : '-@0@'.format(flavour)
  theme_name = meson.project_name() + suffix
  is_dark = flavour == 'dark' or flavour.endswith('-dark')
  base_theme_name = is_dark ? flavour.split('-dark')[0] : flavour
  is_accent = enabled_accent_colors.contains(base_theme_name)
  install_path = join_paths(get_option('datadir'), 'themes', theme_name, gtk_dir)

  if is_accent
    accent_configuration = get_variable('gtk_accent_config_' + flavour.underscorify())
  endif

  # Path priority: flavour-specific → dark base → default base
  flavour_path = flavour
  base_path    = flavour.startswith('mate') ? base_theme_name : 'default'
  dark_path    = is_dark ? 'dark' : base_path

  sources_priority = [
    flavour_path,
    dark_path,
    base_path,
    'default',
  ]

  generated_css = []
  foreach variant: gtk_variants
    target_name  = '@0@-@1@-3.0'.format(theme_name, variant)
    variant_file = is_dark ? variant.split('-dark')[0] + '-dark' : variant
    gtk_scss_path = flavour_path / variant_file + '.scss'

    if not fs.is_file(gtk_scss_path)
      gtk_scss_path = base_path / variant_file + '.scss'
    endif

    scss_paths = yaru_sass_global_paths
    gtk_scss_dependencies = []
    foreach src: sources_priority
      scss_paths += ['-I', meson.current_source_dir() / src]

      scss_deps = run_command('find', src, '-name', '_*.scss').stdout().strip().split('\n')
      if scss_deps.length() > 0 and scss_deps[0] != ''
        gtk_scss_dependencies += scss_deps
      endif
    endforeach

    if is_accent
      gtk_accents_css = configure_file(
        configuration: accent_configuration + {
          'yaru_theme_entry_point': meson.current_source_dir() / gtk_scss_path,
        },
        input: accent_colors_definitions_scss,
        output: '@0@-accent-colors.scss'.format(target_name),
      )

      gtk_scss_path = gtk_accents_css

      gtk_yaru_colors_defs_scss = configure_file(
        configuration: accent_configuration + {
          'yaru_theme_entry_point': yaru_colors_defs_scss,
        },
        input: accent_colors_definitions_scss,
        output: '@0@-yaru-colors-defs.scss'.format(target_name),
      )

      gtk_yaru_colors_defs += {
        target_name: custom_target(
          '@0@-yaru-colors-definitions'.format(target_name),
          input: gtk_yaru_colors_defs_scss,
          output: '@BASENAME@.css',
          command: [sassc, '-a', scss_paths, '@INPUT@', '@OUTPUT@'],
          depend_files: [yaru_colors_defs_scss, gtk_scss_dependencies],
        )
      }
    endif

    generated_css += custom_target(target_name,
      input: gtk_scss_path,
      output: '@0@-generated.css'.format(target_name),
      depend_files: files(gtk_scss_dependencies),
      command: [sassc, '-a', scss_paths, '@INPUT@', '@OUTPUT@'],
    )

    conf_data = configuration_data()
    conf_data.set('THEME_NAME', theme_name)
    conf_data.set('GTK_VER', '3.0')
    install_data(
      configure_file(
        input: gtk_src_dir / 'data/@0@.css.in'.format(variant),
        output: '@0@.css'.format(target_name),
        configuration: conf_data,
      ),
      install_dir: install_path,
      rename: '@0@.css'.format(variant),
    )
  endforeach

  foreach src: sources_priority
    assets_rel_dir = src / 'assets'
    if fs.is_dir(assets_rel_dir)
      break
    endif
  endforeach

  assets = run_command('ls', '-1', assets_rel_dir).stdout().strip().split('\n')

  assets_xml = []
  foreach asset: assets
    assets_xml += '    <file alias="assets/@0@">@1@</file>'.format(
      asset, join_paths(assets_rel_dir, asset))
  endforeach

  conf_data = configuration_data()
  conf_data.set('THEME_NAME', theme_name)
  conf_data.set('GTK_VER', '3.0')
  conf_data.set('ASSETS', '\n'.join(assets_xml))
  gresource_xml = configure_file(
    input: gtk_src_dir / 'data/gtk.gresource.xml.in',
    output: '@0@-3.0-gtk.gresource.xml'.format(theme_name),
    configuration: conf_data,
  )

  gnome.compile_resources(
    '@0@-@1@'.format(theme_name, gtk_dir),
    gresource_xml,
    dependencies: generated_css,
    gresource_bundle: true,
    install: true,
    install_dir: install_path,
  )

  if get_option('cinnamon-shell') and fs.is_file(flavour_path / 'thumbnail.png')
    install_data(
      flavour_path / 'thumbnail.png',
      install_dir: install_path,
    )
  endif
endforeach
