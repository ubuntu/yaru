variants = [
  'gtk',
  'gtk-dark'
]

# Determine which GTK versions to build based on options
build_gtk2 = get_option('gtk-2')
build_gtk3 = get_option('gtk-3')
build_gtk4 = get_option('gtk-4')

gtk_yaru_colors_defs = {}

# Install index.theme for each flavour
foreach flavour: yaru_flavours
  message('Configuring flavour ' + flavour)
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
endforeach

# Build GTK versions by including their subdirectories
if build_gtk2
  subdir('gtk-2.0')
endif

if build_gtk3
  subdir('gtk-3.0')
endif

if build_gtk4
  subdir('gtk-4.0')
endif
