cinnamonshell_theme_dir = join_paths(cinnamonshell_default_theme_dir,
  meson.project_name())

message()

variants = [
  'light',
  'dark',
]

DEFAULT_VARIANT = 'light'
message(meson.project_build_root())

foreach accent: enabled_accent_colors
  if enabled_accent_colors.contains(accent)
    variants += (get_option('default') ? [accent] : [])
    variants += (get_option('dark') ? [ accent + '-dark' ] : [])
  endif
endforeach

theme_css = []
theme_sources = files(
  run_command(
    'find', meson.current_source_dir(), '-name', '*.scss', check: true
  ).stdout().strip().split('\n')
)
assert(theme_sources.length() > 0, 'No theme sources found')

common_asset_dir = meson.current_source_dir() + '/assets/common-assets'
common_theme_assets = files(
  run_command(
    'find', common_asset_dir, '-name', '*.svg', '-o', '-name', '*.png', check: true
  ).stdout().strip().split('\n')
)

colorable_asset_dir = meson.current_source_dir() + '/assets/colorable-assets'
colorable_asset_file = meson.current_source_dir() + '/colorable-assets.txt'
colorable_assets = run_command(
    'cat', colorable_asset_file, check: true
  ).stdout().strip().split('\n')

colorable_assets_list = []
foreach asset: colorable_assets
  colorable_assets_list += meson.current_source_dir() + '/assets' + asset
endforeach
colorable_theme_assets = files(colorable_assets_list)

colorable_assets_names = []
foreach asset: colorable_theme_assets
  # message(fs.parent(asset))
  basename = fs.name(asset)
  colorable_assets_names += basename
endforeach

# theme_gresource_files = theme_assets
# theme_gresource_deps = []

source_deps = []

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
        'sed "s,[[:space:]]*url[[:space:]]*(, url(,g;" "$0" > "$output"',
      ]),
      '@INPUT@',
      '@OUTDIR@',
    ],
    install: false,
  )
endforeach


# theme_gresource_xml = files('data/cinnamon-shell-theme.gresource.xml')[0]
# icons_gresource_xml = files('data/cinnamon-shell-icons.gresource.xml')[0]

foreach variant: variants
  is_dark = variant == 'dark' or variant.endswith('-dark')
  is_variant = variant != DEFAULT_VARIANT
  variant_base_name = is_dark ? variant.split('-dark')[0] : variant
  variant_suffix = is_variant ? '-@0@'.format(variant)  : ''
  theme_full_name = meson.project_name() + variant_suffix
  is_custom_accent = enabled_accent_colors.contains(variant_base_name)

  install_theme_sources = true
  install_dir = cinnamonshell_theme_dir + variant_suffix + '/cinnamon'

  accent_configuration = {
    'yaru_dark_variant': is_dark ? 'true' : 'false',
    'yaru_accent_color': is_custom_accent ? variant_base_name : 'default',
  }

  # Prepare colorable assets
  shell_yaru_colors_defs_scss = configure_file(
    configuration: accent_configuration + {
      'yaru_theme_entry_point': yaru_colors_defs_scss
    },
    input: accent_colors_definitions_scss,
    output: 'cinnamon-shell-yaru-colors-defs-@0@.scss'.format(variant),
  )

  shell_yaru_colors_defs = custom_target(
    'cinnamon-shell-yaru-color-definitions-@0@'.format(variant),
    input: shell_yaru_colors_defs_scss,
    output: '@BASENAME@.css'.format(variant),
    command: [
      sassc, '-a', '@INPUT@', '@OUTPUT@',
      '-I', css_sources_path / 'sass',
      '-I', meson.project_source_root() / 'common',
    ],
    depends: source_deps,
    depend_files: [
      yaru_colors_defs_scss,
      theme_sources,
    ]
  )

  # generate .css files
  variant_styles = []
  output_styles = []

  stylename = 'cinnamon' + variant_suffix
  message('style: '+stylename)

  variant_styles += '@0@.css'.format(stylename)
  output_styles += 'cinnamon.css'

  theme_main_file = configure_file(
    input: 'cinnamon-shell.scss.in',
    output: '@0@.scss'.format(stylename),
    configuration: {
      'DarkVariant': is_dark ? 'true' : 'false',
      'YaruVariant': variant,
      'VariantDir': 'sass',
      # 'UseGResource': cinnamonshell_use_gresource ? 'true' : 'false',
      'Colors': 'colors',
      'ColorableAssets': '@0@'.format(colorable_assets_names),
    },
  )

  if is_custom_accent
    theme_sources += theme_main_file
    theme_main_file = configure_file(
      configuration: accent_configuration + {
        'yaru_theme_entry_point': meson.project_build_root() / '@0@'.format(theme_main_file),
      },
      input: accent_colors_definitions_scss,
      output: '@0@-accent-colors.scss'.format(stylename),
    )
  endif

  css_file = custom_target(
    'style-@0@'.format(stylename),
    input: theme_main_file,
    output: '@0@.css'.format(stylename),
    command: [
      sassc, '-a', '@INPUT@', '@OUTPUT@',
      '-I', css_sources_path,
      '-I', meson.project_source_root() / 'common',
    ],
    install: install_theme_sources,
    install_dir: install_dir,
    depends: source_deps,
    depend_files: theme_sources + sass_utils_scss,
  )

  # theme_gresource_files += css_file[-1].full_path()
  # theme_gresource_deps += css_file[-1]

  # This is an hack we need to remove once meson fixes this issue:
  #  https://github.com/mesonbuild/meson/issues/2320
  # by just making the style_css to have an output in the 'variant' subdir
  if is_variant
    assert(output_styles.length() == variant_styles.length(), 'Output styles length mismatch')
    foreach i: range(output_styles.length())
      meson.add_install_script('bash', '-c',
        'mv -uv ${DESTDIR}${MESON_INSTALL_PREFIX}/@0@ ${DESTDIR}${MESON_INSTALL_PREFIX}/@1@'.format(
          install_dir / variant_styles[i], install_dir / output_styles[i]))
    endforeach
  endif
  
  # install common assets
  foreach common_asset: common_theme_assets
    asset_dir = '@0@'.format(common_asset).replace(common_asset_dir, '').replace(fs.name(common_asset), '')
    basename = join_paths(asset_dir, fs.name(common_asset))
    
    install_data(common_asset, install_dir: install_dir+'/common-assets'+asset_dir)
  endforeach
  
  # install colorable assets
  foreach colorable_asset: colorable_theme_assets
    if '@0@'.format(colorable_asset).contains('common-assets')
      asset_rel_dir = '@0@'.format(colorable_asset).replace(common_asset_dir, '').replace(fs.name(colorable_asset), '')
      asset_rel_dir = '/common-assets'+asset_rel_dir
    else
      if is_dark
        asset_rel_dir = '@0@'.format(colorable_asset).replace(colorable_asset_dir, '').replace(fs.name(colorable_asset), '')
        asset_rel_dir = '/dark-assets'+asset_rel_dir
      else
        asset_rel_dir = '@0@'.format(colorable_asset).replace(colorable_asset_dir, '').replace(fs.name(colorable_asset), '')
        asset_rel_dir = '/light-assets'+asset_rel_dir
      endif
    endif
    basename = join_paths(asset_rel_dir, fs.name(colorable_asset))
    target_name = fs.stem(basename) + '-' + variant + '.svg'

    asset_target = custom_target(
      '___'.join('@0@'.format(target_name).split('/')),
      input: colorable_asset,
      output: '@BASENAME@-@0@.svg'.format(variant),
      command: [
        colorize_dummy_svg,
        shell_yaru_colors_defs,
        '--input-file', '@INPUT@',
        '--output-folder', '@OUTDIR@'+'/@0@@1@'.format(variant, asset_rel_dir),
        '--variant', variant,
      ],
      depends: shell_yaru_colors_defs,
      build_by_default: true,
    )

    asset_src = meson.current_build_dir() + '/' + variant + asset_rel_dir + fs.stem(basename) + '-' + variant + '.svg'
    asset_dir = install_dir+asset_rel_dir
    asset_tgt = install_dir+basename
    meson.add_install_script(
      'rename-cinnamon-assets.sh', asset_src, asset_dir, asset_tgt
    )

    # theme_gresource_files += asset_target.full_path()
    # theme_gresource_deps += asset_target
  endforeach

  # # Install thumbnail image
  # install_data(join_paths(flavour, 'thumbnail.png'),
  #   install_dir: theme_dir
  # )
endforeach
