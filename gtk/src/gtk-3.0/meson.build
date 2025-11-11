# GTK-3.0 Build Logic
# Compiles SCSS to CSS and packages as gresource

gtk_ver = '3.0'
gtk_dir = 'gtk-@0@'.format(gtk_ver)

variants = [
  'gtk',
  'gtk-dark'
]

foreach flavour: yaru_flavours
  message('Configuring flavour ' + flavour + ' for GTK-3.0')
  suffix = flavour == 'default' ? '' : '-@0@'.format(flavour)
  theme_name = meson.project_name() + suffix
  is_dark = flavour == 'dark' or flavour.endswith('-dark')
  base_theme_name = is_dark ? flavour.split('-dark')[0] : flavour
  is_accent = enabled_accent_colors.contains(base_theme_name)
  theme_dir = join_paths(get_option('datadir'), 'themes', theme_name)
  accent = is_accent ? base_theme_name : ''

  if is_accent
    accent_configuration = {
      'yaru_dark_variant': is_dark ? 'true' : 'false',
      'yaru_accent_color': accent,
    }

    accent_info_css = configure_file(
      configuration: accent_configuration + {
        'yaru_theme_entry_point': '/dev/null',
      },
      input: accent_colors_definitions_scss,
      output: '@0@-@1@-accent-color-info.scss'.format(theme_name, accent),
    )

    accent_parser = run_command(sassc,
      yaru_sass_global_paths,
      accent_info_css).stderr().strip()

    accent_color_code = accent_parser.split(' Accent color is ')[1].split('\n')[0]
    assert(accent_color_code.startswith('#'), 'No accent color code found')

    accent_color_optimized_code = accent_parser.split(' Contrast optimized accent is ')[1].split('\n')[0]
    assert(accent_color_optimized_code.startswith('#'), 'No accent color code found')
    message('Accent color code is', accent_color_code)
    message('Accent optimized color code is', accent_color_optimized_code)
  endif

  # Determine paths based on flavour
  if flavour.startswith('mate')
    base_path = flavour
    dark_path = is_dark ? flavour : base_path
  else
    base_path = 'default'
    dark_path = is_dark ? 'dark' : base_path
  endif
  default_path = 'default'
  upstream_path = '../upstream' / gtk_dir / 'Default'
  install_path = theme_dir / gtk_dir

  # Sort by most relevant for the theme flavour
  # All flavour GTK files are now in this directory
  sources_priority = [
    flavour,
    dark_path,
    base_path,
    default_path,
    upstream_path,
  ]

  generated_css = []
  foreach variant : variants
    message('Configuring @0@ variant for @1@-@2@'.format(
      theme_name, variant, gtk_ver))
    target_name = '@0@-@1@-@2@'.format(theme_name, variant, gtk_ver)
    variant_file = is_dark ? variant.split('-dark')[0] + '-dark' : variant
    gtk_scss_path = flavour / variant_file + '.scss'

    if not fs.is_file(gtk_scss_path)
      gtk_scss_path = base_path / variant_file + '.scss'
    endif

    # Look for scss files in the variant dir first, otherwise fallback to
    # base, default or upstream paths, so using reversed order
    scss_paths = yaru_sass_global_paths
    gtk_scss_dependencies = []
    foreach src: sources_priority
      # upstream_path already contains '../', others don't
      if src.startswith('../')
        scss_paths += ['-I', meson.current_source_dir() / src ]
        find_path = src
      else
        scss_paths += ['-I', meson.current_source_dir() / src ]
        find_path = src
      endif

      scss_deps = run_command(
        'find', find_path, '-name', '_*.scss'
        ).stdout().strip().split('\n')
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
            command: [
              sassc, '-a',
              scss_paths,
              '@INPUT@', '@OUTPUT@',
            ],
            depend_files: [
              yaru_colors_defs_scss,
              gtk_scss_dependencies,
            ]
          )
        }
    endif

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
    install_data(
      configure_file(
        input: '@0@.css.in'.format(variant),
        output: '@0@.css'.format(target_name),
        configuration: conf_data
      ),
      install_dir: install_path,
      rename: '@0@.css'.format(variant),
    )
  endforeach

  foreach src: sources_priority
    # upstream_path already contains '../', others don't
    if src.startswith('../')
      assets_rel_dir = src / 'assets'
    else
      assets_rel_dir = src / 'assets'
    endif
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
    input: 'gtk.gresource.xml.in',
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

  # Rename gresource to gtk.gresource after install
  meson.add_install_script('sh', '-c',
    'cd "$MESON_INSTALL_DESTDIR_PREFIX/@0@" && mv "@1@-gtk-@2@.gresource" "gtk.gresource" 2>/dev/null || true'.format(
      install_path, theme_name, gtk_ver
    )
  )

  if get_option('cinnamon-shell') and fs.is_file(dark_path / 'thumbnail.png')
    # install thumbnail (cinnamon only)
    install_data(
      dark_path / 'thumbnail.png',
      install_dir: install_path,
    )
  endif
endforeach
