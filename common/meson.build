colorize_dummy_svg = find_program('colorize-dummy-svg.py')
accent_colors_definitions_scss = meson.project_source_root() / '@0@'.format(files('accent-colors.scss.in')[0])
yaru_colors_defs_scss = meson.project_source_root() / '@0@'.format(files('yaru-colors-defs.scss')[0])

sass_utils_scss = files([
    'sass-utils.scss',
])

test('sass-utils',
    sassc,
    args: [
        files('test-sass-utils.scss'),
        '/dev/null',
    ])

yaru_sass_global_paths = ['-I', meson.current_source_dir()]

yaru_flavours = []

available_flavours = [
  'default',
  'dark',
  'mate',
  'mate-dark',
]

foreach flavour: available_flavours
  if not get_option(flavour)
    message('skip flavour ' + flavour)
    continue
  endif
  yaru_flavours += flavour
endforeach

foreach accent: enabled_accent_colors
  if enabled_accent_colors.contains(accent)
    yaru_flavours += (get_option('default') ? [accent] : [])
    yaru_flavours += (get_option('dark') ? [ accent + '-dark' ] : [])
  endif
endforeach
