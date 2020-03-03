sassc = find_program('sassc')

styles = [
  'gnome-shell',
  'gnome-shell-high-contrast',
]
variants = [
  'light',
  'dark',
]

theme_sources = files(
  run_command(
    'find', meson.current_source_dir(), '-name', '*.scss'
  ).stdout().strip().split('\n')
)
assert(theme_sources.length() > 0, 'No theme sources found')

foreach variant: variants
  is_variant = variant != 'light'
  variant_sufix = is_variant ? '-@0@'.format(variant)  : ''
  install_dir = join_paths(
    gnomeshell_default_theme_dir,
    meson.project_name() + variant_sufix)

  conf_data = configuration_data()
  conf_data.set('ThemeVariant', variant)
  theme_main_file = configure_file(
    input: 'gnome-shell.scss.in',
    output: 'gnome-shell@0@.scss'.format(variant_sufix),
    configuration: conf_data,
  )

  # generate .css files
  style_css = []
  output_styles = []

  foreach style: styles
    stylename = style + variant_sufix
    output_styles += '@0@.css'.format(style)

    style_css += custom_target(
      'style-@0@'.format(stylename),
      input: style == 'gnome-shell' ? theme_main_file : '@0@.scss'.format(style),
      output: '@0@.css'.format(stylename),
      command: [
        sassc, '-a', '@INPUT@', '@OUTPUT@',
        '-I', meson.current_source_dir(),
      ],
      install: not is_variant,
      install_dir: install_dir,
      depend_files: theme_sources,
    )
  endforeach

  # This is an hack we need to remove once meson fixes this issue:
  #  https://github.com/mesonbuild/meson/issues/2320
  # by just making the style_css to have an output in the 'variant' subdir
  if is_variant
    subdir(variant)
  endif

  ignore_variants = []
  if not is_variant
    foreach v: variants
      if v != variant
        ignore_variants += ['--filter', '*.@0@.svg'.format(v) ]
      endif
    endforeach
  endif

  gresource_xml = files('data/gnome-shell-theme.gresource.xml')[0]
  data_sources = run_command(
    gresources_xml_parser, [
      join_paths(meson.source_root(), '@0@'.format(gresource_xml)),
      '--filter', '*.css',
    ] + ignore_variants,
  ).stdout().strip().split('\n')

  assert(data_sources.length() > 0 and data_sources[0] != '', 'No data sources found')

  # static files to copy
  data_sources += files([
    'lockscreen-gradient.svg',
    'logged-in-indicator.svg',
    'noise-texture.png',
    'pad-osd.css',
    'running-indicator.svg',
    'source-button-border.svg',
    'summary-counter.svg',
    'toggle-off-intl.svg',
    'toggle-on-intl.svg',
    'ws-switch-arrow-down.svg',
    'ws-switch-arrow-up.svg',
  ])

  # install static data files
  install_data(data_sources, install_dir: install_dir)
endforeach

# Symlink default variant
meson.add_install_script('install-shell.sh', meson.project_name())
