sassc = find_program('sassc')

variants = [
  'light',
  'dark'
]

styles = ['cinnamon']

theme_sources = files(
  run_command(
    'find', meson.current_source_dir(), '-name', '*.scss'
  ).stdout().strip().split('\n')
)
assert(theme_sources.length() > 0, 'No theme sources find')

foreach variant: variants
  is_variant = variant != 'dark'
  variant_suffix = is_variant ? '-@0@'.format(variant)  : ''

  install_dir = join_paths(
    cinnamon_theme_dir,
    meson.project_name() + variant_suffix,
    'cinnamon'
  )

  style_css = []
  output_styles = []

  foreach style: styles
    stylename = style + variant_suffix
    output_styles += '@0@.css'.format(style)

    style_css += custom_target(
      'style-@0@'.format(stylename),
      input: style == 'cinnamon' ? theme_main_file : '@0@.scss'.format(style),
      output: '@0@.css'.format(stylename),
      command: [
        sassc, '-a', '@INPUT@', '@OUTPUT@',
        '-I', css_sources_path,
      ],
      install: not is_variant,
      install_dir: install_dir,
      depends: source_deps,
      depend_files: theme_sources,
    )
  endforeach

  theme_css += style_css

  ignore_variants = []
  if not is_variant
    foreach v: variants
      if v != variant
        ignore_variants += ['--filter', '*.@0@.svg'.format(v)]
      endif
    endforeach
  endif

  install_data(theme_sources, install_dir: install_dir)
endforeach
