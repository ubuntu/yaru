sassc = find_program('sassc')

styles = [
  'gnome-shell',
  'gnome-shell-high-contrast',
]
variants = [
  'light',
  'dark',
]

foreach variant: variants
  is_variant = variant != 'light'
  variant_sufix = is_variant ? '-@0@'.format(variant)  : ''
  install_dir = join_paths(
    gnomeshell_default_theme_dir,
    meson.project_name() + variant_sufix)

  theme_sources = []

  conf_data = configuration_data()
  conf_data.set('ThemeVariant', variant)
  theme_main_file = configure_file(
    input: 'gnome-shell.scss.in',
    output: 'gnome-shell@0@.scss'.format(variant_sufix),
    configuration: conf_data,
  )

  # generate .css files
  theme_sources += files([
    'gnome-shell-high-contrast.scss',
    'gnome-shell-sass/_colors.scss',
    'gnome-shell-sass/_ubuntu-colors.scss',
    'gnome-shell-sass/_common.scss',
    'gnome-shell-sass/_drawing.scss',
    'gnome-shell-sass/_high-contrast-colors.scss',
    'gnome-shell-sass/_widgets.scss',
    'gnome-shell-sass/widgets/_a11y.scss',
    'gnome-shell-sass/widgets/_app-grid.scss',
    'gnome-shell-sass/widgets/_base.scss',
    'gnome-shell-sass/widgets/_buttons.scss',
    'gnome-shell-sass/widgets/_calendar.scss',
    'gnome-shell-sass/widgets/_check-box.scss',
    'gnome-shell-sass/widgets/_corner-ripple.scss',
    'gnome-shell-sass/widgets/_dash.scss',
    'gnome-shell-sass/widgets/_dialogs.scss',
    'gnome-shell-sass/widgets/_entries.scss',
    'gnome-shell-sass/widgets/_hotplug.scss',
    'gnome-shell-sass/widgets/_ibus-popup.scss',
    'gnome-shell-sass/widgets/_keyboard.scss',
    'gnome-shell-sass/widgets/_login-dialog.scss',
    'gnome-shell-sass/widgets/_looking-glass.scss',
    'gnome-shell-sass/widgets/_message-list.scss',
    'gnome-shell-sass/widgets/_misc.scss',
    'gnome-shell-sass/widgets/_network-dialog.scss',
    'gnome-shell-sass/widgets/_notifications.scss',
    'gnome-shell-sass/widgets/_osd.scss',
    'gnome-shell-sass/widgets/_overview.scss',
    'gnome-shell-sass/widgets/_panel.scss',
    'gnome-shell-sass/widgets/_popovers.scss',
    'gnome-shell-sass/widgets/_screen-shield.scss',
    'gnome-shell-sass/widgets/_scrollbars.scss',
    'gnome-shell-sass/widgets/_search-entry.scss',
    'gnome-shell-sass/widgets/_search-results.scss',
    'gnome-shell-sass/widgets/_slider.scss',
    'gnome-shell-sass/widgets/_switcher-popup.scss',
    'gnome-shell-sass/widgets/_switches.scss',
    'gnome-shell-sass/widgets/_tiled-previews.scss',
    'gnome-shell-sass/widgets/_window-picker.scss',
    'gnome-shell-sass/widgets/_workspace-switcher.scss',
    'gnome-shell-sass/widgets/_workspace-thumbnails.scss',
  ])

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
