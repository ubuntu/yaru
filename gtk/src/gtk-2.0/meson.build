# GTK-2.0 Build Logic
# Generates themed GTK-2 assets and configuration

gtk_ver = '2.0'
gtk_dir = 'gtk-@0@'.format(gtk_ver)

foreach flavour: yaru_flavours
  message('Configuring flavour ' + flavour + ' for GTK-2.0')
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

  install_path = theme_dir / gtk_dir

  # GTK-2: Determine base directory for this flavour
  # mate variants use their own directories, others use default/dark
  if flavour.startswith('mate')
    gtk2_base_dir = flavour
  else
    gtk2_base_dir = is_dark ? 'dark' : 'default'
  endif

  gtk2_gtkrc_template = gtk2_base_dir / 'gtkrc.in'

  # Set the selected_bg_color: use accent color if specified, otherwise default orange
  gtk2_selected_bg_color = is_accent ? accent_color_code : '#E95420'

  # Generate gtkrc from template
  install_data(
    configure_file(
      input: gtk2_gtkrc_template,
      output: '@0@-gtkrc'.format(theme_name),
      configuration: {
        'selected_bg_color': gtk2_selected_bg_color,
      }
    ),
    install_dir: install_path,
    rename: 'gtkrc',
  )

  # Install static RC files from base directory
  install_data(
    gtk2_base_dir / 'main.rc',
    gtk2_base_dir / 'apps.rc',
    gtk2_base_dir / 'hacks.rc',
    install_dir: install_path
  )

  # For accent colors, recolor SVG assets; otherwise use original
  gtk2_assets_svg = gtk2_base_dir / 'assets.svg'
  gtk2_assets_txt = gtk2_base_dir / 'assets.txt'
  gtk2_render_script = 'render-all-assets.sh'

  if is_accent
    # Recolor SVG with accent color
    gtk2_recolored_svg = custom_target(
      '@0@-gtk2-assets-svg'.format(theme_name),
      input: gtk2_assets_svg,
      output: '@0@-assets.svg'.format(theme_name),
      command: [
        'sed',
        '-e', 's/#e55730/@0@/gi'.format(accent_color_code),
        '-e', 's/#c34113/@0@/gi'.format(accent_color_optimized_code),
        '-e', 's/#fea691/@0@/gi'.format(accent_color_optimized_code),
        '-e', 's/#f6b6a0/@0@/gi'.format(accent_color_optimized_code),
        '@INPUT@'
      ],
      capture: true,
    )
    gtk2_svg_to_use = gtk2_recolored_svg
  else
    gtk2_svg_to_use = gtk2_assets_svg
  endif

  # Generate PNG assets from SVG using render-all-assets.sh script
  gtk2_render_script_path = meson.current_source_dir() / gtk2_render_script

  # Create assets directory and run the render script directly
  gtk2_assets_target = custom_target(
    '@0@-gtk2-assets'.format(theme_name),
    input: [gtk2_svg_to_use, gtk2_assets_txt],
    output: '@0@-gtk2-assets.stamp'.format(theme_name),
    command: [
      'bash', gtk2_render_script_path,
      '@INPUT0@',                    # SVG file
      '@INPUT1@',                    # assets.txt
      '@PRIVATE_DIR@/assets',        # output directory
      '--clean'
    ],
    build_by_default: true,
  )

  # Install generated assets
  gtk2_assets_list = run_command(
    'cat', meson.current_source_dir() / gtk2_assets_txt
  ).stdout().strip().split('\n')

  foreach asset_name: gtk2_assets_list
    if asset_name != ''
      meson.add_install_script('sh', '-c',
        'install -Dm644 "$MESON_BUILD_ROOT/gtk/src/gtk-2.0/@0@-gtk2-assets.stamp.p/assets/@1@.png" "$MESON_INSTALL_DESTDIR_PREFIX/@2@/assets/@1@.png"'.format(theme_name, asset_name, install_path)
      )
    endif
  endforeach
endforeach
