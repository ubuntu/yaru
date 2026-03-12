variants = [
  'gtk',
  'gtk-dark'
]
gtk_versions = [
  '2.0',
  '3.0',
  '4.0'
]

gtk_yaru_colors_defs = {}
assets_renderers = {}
render_assets_gtk_ver_deps = {}
cleanup_assets_gtk_ver_deps = {}

foreach flavour: yaru_flavours
  message('GTK: Configuring flavour ' + flavour)
  suffix = flavour == 'default' ? '' : '-@0@'.format(flavour)
  theme_name = meson.project_name() + suffix
  is_dark = flavour == 'dark' or flavour.endswith('-dark')
  base_theme_name = is_dark ? flavour.split('-dark')[0] : flavour
  is_mate = flavour.startswith('mate')
  is_accent = enabled_accent_colors.contains(base_theme_name) or is_mate
  theme_dir = join_paths(get_option('datadir'), 'themes', theme_name)
  default_accent = is_mate ? 'mate' : 'default'
  accent = is_accent ? base_theme_name : default_accent

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
    accent_info_css,
    check: true,
  ).stderr().strip()

  accent_color_code = accent_parser.split(' Accent color is ')[1].split('\n')[0]
  assert(accent_color_code.startswith('#'), 'No accent color code found')

  accent_color_optimized_code = accent_parser.split(' Contrast optimized accent is ')[1].split('\n')[0]
  assert(accent_color_optimized_code.startswith('#'), 'No accent color code found')
  message('Accent color code is', accent_color_code)
  message('Accent optimized color code is', accent_color_optimized_code)

  conf_data = configuration_data()
  conf_data.set('ThemeName', meson.project_name())
  conf_data.set('FlavourThemeName', theme_name)
  conf_data.set('IconThemeName', theme_name)
  conf_data.set('MetacityThemeName', is_dark ? '-'.join(meson.project_name(), 'dark') : meson.project_name())
  conf_data.set('DarkTheme', is_dark ? 'true' : 'false')
  conf_data.set('AccentName', is_accent ? base_theme_name : 'default')
  conf_data.set('AccentColor', is_accent ? accent_color_code : '')
  conf_data.set('AccentColorOptimized', is_accent ? accent_color_optimized_code : '')
  install_data(
    configure_file(input: 'index.theme.in',
      output: '@0@-index.theme'.format(theme_name),
      configuration: conf_data,
    ),
    install_dir: theme_dir,
    rename: 'index.theme',
  )

  # build and install gtk data
  foreach gtk_ver: gtk_versions
    gtk_dir = 'gtk-@0@'.format(gtk_ver)
    base_path = (is_mate ? base_theme_name : 'default') / gtk_dir
    dark_path = is_dark ? 'dark' : base_path
    default_path = 'default' / gtk_dir
    upstream_path = '..' / 'upstream' / gtk_dir / 'Default'
    flavour_path = join_paths(flavour, gtk_dir)
    install_path = theme_dir / gtk_dir

    if not assets_renderers.has_key(gtk_ver)
      render_assets = find_program(default_path / 'render-assets.sh', required: false)
      if render_assets.found()
        assets_renderers += {
          gtk_ver: custom_target('yaru-render-assets-@0@'.format(gtk_ver),
            input: render_assets.full_path(),
            output: '@BASENAME@-@0@.sh'.format(gtk_ver),
            capture: true,
            command: [ 'sed', 's,assets[.],assets-yaru.,g', '@INPUT@']
          )
        }
      endif
    endif

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
        '-name', '*rc',
        check: false,
        ).stdout().strip().split('\n')

      install_data(gtk2_sources_data, install_dir: install_path)

      assets_paths = []
      foreach src: sources_priority
        assets_paths = [ src / 'assets' ] + assets_paths
      endforeach

      gtk2_asset_data = run_command(
        'find', assets_paths, '-name', '*.png',
        check: false,
        ).stdout().strip().split('\n')

      install_data(gtk2_asset_data, install_dir: install_path / 'assets')

      continue
    endif

    generated_css = []
    foreach variant : variants
      is_dark_variant = variant.endswith('-dark')
      target_name = '@0@-@1@-@2@'.format(theme_name, variant, gtk_ver)
      variant_file = is_dark ? variant.split('-dark')[0] + '-dark' : variant
      gtk_scss_path = flavour_path / variant_file + '.scss'

      if not fs.is_file(gtk_scss_path)
        gtk_scss_path = base_path / variant_file + '.scss'
      endif

      # Look for scss files in the variant dir first, otherwise fallback to
      # base, default or upstream paths, so using reversed order
      scss_paths = yaru_sass_global_paths
      gtk_scss_dependencies = []
      foreach src: sources_priority
        scss_paths += ['-I', meson.current_source_dir() / src ]

        scss_deps = run_command(
          'find', src, '-name', '_*.scss',
          check: false,
          ).stdout().strip().split('\n')
        if scss_deps.length() > 0 and scss_deps[0] != ''
          gtk_scss_dependencies += scss_deps
        endif
      endforeach

      gtk_accents_css = configure_file(
        configuration: accent_configuration + {
          'yaru_theme_entry_point': meson.current_source_dir() / gtk_scss_path,
        },
        input: accent_colors_definitions_scss,
        output: '@0@-accent-colors.scss'.format(target_name),
      )

      gtk_yaru_colors_defs_scss = configure_file(
        configuration: accent_configuration + {
          'yaru_theme_entry_point': yaru_colors_defs_scss,
        },
        input: accent_colors_definitions_scss,
        output: '@0@-yaru-colors-defs.scss'.format(target_name),
      )

      colors_definitions = custom_target(
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

      gtk_yaru_colors_defs += { target_name: colors_definitions }

      if is_accent
          gtk_scss_path = gtk_accents_css
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
          input: 'data/@0@.css.in'.format(variant),
          output: '@0@.css'.format(target_name),
          configuration: conf_data
        ),
        install_dir: install_path,
        rename: '@0@.css'.format(variant),
      )

      if is_dark_variant == is_dark and assets_renderers.has_key(gtk_ver)
        accent_svg = flavour_path / 'assets.svg'
        if not fs.is_file(accent_svg)
          accent_svg = files(default_path / 'assets.svg')
        endif

        dummy_svg = configure_file(
          input: accent_svg,
          output: '@BASENAME@-dummy-@0@.svg'.format(target_name),
          command: [
            'sed',
            # bg-color
            '-e', 's/@0@/#ffff00/g'.format(
              is_dark ? '#33393b' : '#eeeeec'),
            # light-bg-color
            '-e', 's/#e8e6e3/#fffff1/g',
            # light-bg-color
            '-e', 's/#343434/#fffff1/g',
            # light-bg-color
            '-e', 's/#393939/#fffff1/g',
            # accent-bg-color
            '-e', 's/#e95420/#00ff01/g',
            # accent-bg-color
            '-e', 's/#2265b5/#00ff01/g',
            # accent-bg-color
            '-e', 's/#040c18/#00ff01/g',
            # accent-bg-color-hc
            '-e', 's/#1b4f8d/#00ff05/g',
            # accent-bg-color-hc
            '-e', 's/#07182f/#00ff05/g',
            # accent-color
            '-e', 's/#3465a4/#00ff03/g',
            '@INPUT@',
          ],
          capture: true,
        )

        accented_svg = custom_target(
          '-'.join([target_name, fs.name(accent_svg)]),
          input: dummy_svg,
          output: 'accented-@BASENAME@.svg'.format(target_name),
          command: [
            colorize_dummy_svg,
            colors_definitions,
            '--input-file', '@INPUT@',
            '--output-name', '@OUTPUT@',
          ],
          depends: colors_definitions,
        )

        source_flavour_path = meson.current_source_dir() / flavour_path
        assets_path = source_flavour_path / 'assets'
        render_assets = assets_renderers[gtk_ver]
        render_assets_target = run_target('render-assets-@0@'.format(target_name),
          command: [
            'bash', '-exc', 'cd @0@ && bash @1@'.format(
              source_flavour_path,
              render_assets.full_path(),
            ),
          ],
          depends: [
            render_assets,
            custom_target(
              'assets-@0@.txt'.format(target_name),
              output: '@BASENAME@-@0@.txt'.format(target_name),
              input: default_path / 'assets.txt',
              command: [
                'bash', '-xec', ';'.join([
                  'mkdir -p "@3@"',
                  'ln -sf "$(realpath --relative-to="@1@" "@INPUT@")" "@1@/assets-yaru.txt"',
                  'cd "@3@" && for f in "@0@/assets/"*.svg; do ln -sf "$(realpath --relative-to="@3@" "$f")" "$(basename "$f")"; done || true',
                  'cp -v "@2@" "@1@/assets-yaru.svg"',
                ]).format(
                  meson.current_source_dir() / default_path,
                  source_flavour_path,
                  accented_svg.full_path(),
                  meson.current_source_dir() / assets_path,
                  render_assets.full_path(),
                ),
              ],
              depends: accented_svg,
            )
          ],
        )

        cleanup_assets_target = run_target('cleanup-rendered-assets-@0@'.format(target_name),
          command: [
            'bash', '-xc', 'rm -f @0@/assets-yaru.svg; rm -f "@1@/"*.png'.format(
              source_flavour_path, assets_path),
          ]
        )

        regenerate_assets_target = alias_target('regenerate-assets-@0@'.format(target_name),
          cleanup_assets_target,
          render_assets_target,
        )

        render_assets_gtk_ver_deps += {
          gtk_ver: [regenerate_assets_target] + render_assets_gtk_ver_deps.get(gtk_ver, [])
        }
        cleanup_assets_gtk_ver_deps += {
          gtk_ver: [cleanup_assets_target] + cleanup_assets_gtk_ver_deps.get(gtk_ver, [])
        }
      endif
    endforeach

    foreach src: sources_priority
      assets_rel_dir = src / 'assets'
      if fs.is_dir(assets_rel_dir)
        break
      endif
    endforeach

    assets = run_command(
      'ls', '-1', assets_rel_dir,
      check: true,
    ).stdout().strip().split('\n')

    assets_xml = []
    foreach asset: assets
      assets_xml += '    <file alias="assets/@0@">@1@</file>'.format(
          asset,
          files(assets_rel_dir / asset)[0].full_path(),
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

    if get_option('cinnamon-shell') and fs.is_file(flavour_path / 'thumbnail.png')
      # install thumbnail (cinnamon only)
      install_data(
        flavour_path / 'thumbnail.png',
        install_dir: install_path,
      )
    endif
  endforeach
endforeach

render_assets_deps = []
foreach gtk_ver, deps: render_assets_gtk_ver_deps
  alias_target('regenerate-gtk-assets-@0@'.format(gtk_ver), deps)
  alias_target('cleanup-gtk-assets-@0@'.format(gtk_ver),
    cleanup_assets_gtk_ver_deps.get(gtk_ver, []))
  render_assets_deps += deps
endforeach

alias_target('regenerate-gtk-assets', render_assets_deps)

meson.add_install_script('post_install.py', get_option('datadir'), meson.project_name(), yaru_flavours)
