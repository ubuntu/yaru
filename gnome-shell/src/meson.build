sassc = find_program('sassc')

gnomeshell_theme_dir = join_paths(gnomeshell_default_theme_dir,
  meson.project_name())

styles = [
  'gnome-shell',
  'gnome-shell-high-contrast',
]

variants = [
  'light',
  'dark',
]

DEFAULT_VARIANT = 'dark'

theme_css = []
theme_sources = files(
  run_command(
    'find', meson.current_source_dir(), '-name', '*.scss'
  ).stdout().strip().split('\n')
)
assert(theme_sources.length() > 0, 'No theme sources found')

theme_assets = files(
  run_command(
    'find', meson.current_source_dir(), '-maxdepth', '1',
    '-name', '*.svg',
    '-or',
    '-name', '*.css'
  ).stdout().strip().split('\n')
)

colorable_theme_assets = files(
  run_command(
    'find', meson.current_source_dir() / 'colorable-assets', '-maxdepth', '1', '-name', '*.svg'
  ).stdout().strip().split('\n')
)

theme_gresource_files = theme_assets
theme_gresource_deps = []

source_deps = []
css_sources_path = meson.current_source_dir()
if not gnomeshell_use_gresource
  css_sources_path = meson.current_build_dir()
  foreach src: theme_sources
    out_name = '___'.join('@0@'.format(src).split('/'))
    source_deps += custom_target(out_name,
      input: src,
      output: out_name,
      command: [
        'bash', '-c',
        ';'.join([
          'output="$1/$(realpath --relative-to="'+ meson.current_source_dir() + '" $0)"',
          'mkdir -p "$(dirname "$output")"',
          # Can't use proper regex ("s,\(\b\)url\(\s*(\),\1yaru-url-handler\2,g") as per
          # https://github.com/mesonbuild/meson/issues/1564
          'sed "s,[[:space:]]*url[[:space:]]*(, yaru_url_handler(,g;" "$0" > "$output"',
        ]),
        '@INPUT@',
        '@OUTDIR@',
      ],
      install: false,
    )
  endforeach
endif

theme_gresource_xml = files('data/gnome-shell-theme.gresource.xml')[0]
icons_gresource_xml = files('data/gnome-shell-icons.gresource.xml')[0]

foreach variant: variants
  is_variant = variant != DEFAULT_VARIANT
  variant_suffix = is_variant ? '-@0@'.format(variant)  : ''

  if gnomeshell_use_gresource
    install_dir = join_paths(
      gnomeshell_alt_themes_dir,
      meson.project_name() + variant_suffix,
      'gnome-shell')
  else
    install_dir = gnomeshell_theme_dir + variant_suffix
  endif

  conf_data = configuration_data()
  conf_data.set('ThemeVariant', variant)
  conf_data.set('UseGResource', gnomeshell_use_gresource ? 'true' : 'false')
  theme_main_file = configure_file(
    input: 'gnome-shell.scss.in',
    output: 'gnome-shell@0@.scss'.format(variant_suffix),
    configuration: conf_data,
  )

  # Prepare colorable assets
  shell_yaru_colors_defs_scss = configure_file(
    configuration: {
      'yaru_dark_variant': variant == 'dark' ? 'true' : 'false',
      'yaru_accent_color': 'default',
      'yaru_theme_entry_point': yaru_colors_defs_scss,
    },
    input: accent_colors_definitions_scss,
    output: 'gnome-shell-yaru-colors-defs-@0@.scss'.format(variant),
  )

  shell_yaru_colors_defs = custom_target(
    'gnome-shell-yaru-color-definitions-@0@'.format(variant),
    input: shell_yaru_colors_defs_scss,
    output: '@BASENAME@.css'.format(variant),
    command: [
      sassc, '-a', '@INPUT@', '@OUTPUT@',
      '-I', css_sources_path / 'gnome-shell-sass',
    ],
    depends: source_deps,
    depend_files: [
      yaru_colors_defs_scss,
      theme_sources,
    ]
  )

  foreach colorable_asset: colorable_theme_assets
    basename = '@0@'.format(colorable_asset).split('/')[-1]

    if is_variant and basename.endswith('-hc.svg')
      continue
    endif

    asset_target = custom_target(
      basename + variant_suffix,
      input: colorable_asset,
      output: '@BASENAME@@0@.svg'.format(variant_suffix),
      command: [
        colorize_dummy_svg,
        shell_yaru_colors_defs,
        '--input-file', '@INPUT@',
        '--output-folder', '@OUTDIR@',
        is_variant ? ['--variant', variant] : [],
      ],
      depends: shell_yaru_colors_defs,
    )
    theme_assets += asset_target.full_path()
    theme_gresource_files += asset_target.full_path()
    theme_gresource_deps += asset_target
  endforeach

  # generate .css files
  style_css = []
  output_styles = []

  foreach style: styles
    stylename = style + variant_suffix
    output_styles += '@0@.css'.format(style)

    style_css += custom_target(
      'style-@0@'.format(stylename),
      input: style == 'gnome-shell' ? theme_main_file : '@0@.scss'.format(style),
      output: '@0@.css'.format(stylename),
      command: [
        sassc, '-a', '@INPUT@', '@OUTPUT@',
        '-I', css_sources_path,
      ],
      install: not is_variant and not gnomeshell_use_gresource,
      install_dir: install_dir,
      depends: source_deps,
      depend_files: theme_sources,
    )

    theme_gresource_files += style_css[-1].full_path()
    theme_gresource_deps += style_css[-1]
  endforeach

  # This is an hack we need to remove once meson fixes this issue:
  #  https://github.com/mesonbuild/meson/issues/2320
  # by just making the style_css to have an output in the 'variant' subdir
  if is_variant
    subdir(variant)
  endif

  # static files to copy
  data_sources = gnomeshell_use_gresource ? [] : theme_assets

  # install static data files
  install_data(data_sources, install_dir: install_dir)
endforeach

if gnomeshell_use_gresource
  theme_gresource_files_xml = []

  foreach gfile: theme_gresource_files
    filepath = '@0@'.format(gfile)
    alias = filepath[0] == '/' ? '@0@'.format(gfile).split('/')[-1] : filepath
    if alias == 'gnome-shell.css'
      # Use Yaru files for ubuntu's special gdm
      theme_gresource_files_xml += '<file alias="gdm.css">@0@</file>'.format(gfile)
    endif

    if alias.endswith('.css') and filepath.contains(meson.current_build_dir())
      # This is kept for compatibility reasons, but we may drop it once shell is updated too
      alias = 'Yaru' / alias
    endif

    theme_gresource_files_xml += '<file alias="@0@">@1@</file>'.format(alias, gfile)
  endforeach

  gnome.compile_resources(
    'gnome-shell-theme',
    configure_file(
      input: theme_gresource_xml,
      output: '@PLAINNAME@',
      configuration: {
        'YARU_SHELL_THEME_RESOURCES': '\n    '.join(theme_gresource_files_xml),
      },
    ),
    dependencies: theme_gresource_deps,
    gresource_bundle: true,
    install: true,
    install_dir: gnomeshell_theme_dir,
  )

  gnome.compile_resources(
    'gnome-shell-icons',
    icons_gresource_xml,
    source_dir: 'data/icons',
    gresource_bundle: true,
    install: true,
    install_dir: gnomeshell_theme_dir,
  )
else
  # Symlink variants
  foreach variant: variants
    variant_suffix = (variant != DEFAULT_VARIANT) ? '-@0@'.format(variant)  : ''
    meson.add_install_script('install-shell.sh', meson.project_name() + variant_suffix)
  endforeach
endif
