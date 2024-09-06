gnomeshell_theme_dir = join_paths(gnomeshell_default_theme_dir,
  meson.project_name())

styles = [
  'gnome-shell',
  'gnome-shell-high-contrast',
]

DEFAULT_GDM_VARIANT = get_option('gdm-default-variant')
DEFAULT_HIGH_CONTRAST_VARIANT = get_option('gnome-shell-default-high-contrast-variant')

variants = [
  'light',
  'dark',
]

if not variants.contains(DEFAULT_GDM_VARIANT)
  error('Invalid default gdm variant selected: @0@'.format(
    DEFAULT_GDM_VARIANT))
endif

if not variants.contains(DEFAULT_HIGH_CONTRAST_VARIANT)
  error('Invalid gnome-shell default high-contrast variant selected: @0@'.format(
    DEFAULT_HIGH_CONTRAST_VARIANT))
endif

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
    '(',
      '-name', '*.svg',
      '-or',
      '-name', '*.css',
    ')',
  ).stdout().strip().split('\n')
)

theme_gresource_files = theme_assets
theme_gresource_deps = []

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

theme_gresource_xml = files('data/gnome-shell-theme.gresource.xml')[0]
icons_gresource_xml = files('data/gnome-shell-icons.gresource.xml')[0]

foreach variant: variants
  is_dark = variant == 'dark' or variant.endswith('-dark')
  is_variant = is_dark
  variant_suffix = is_variant ? '-@0@'.format(variant)  : ''
  theme_full_name = meson.project_name() + variant_suffix

  install_theme_sources = not gnomeshell_user_themes_suport.disabled()
  install_dir = gnomeshell_theme_dir + variant_suffix

  # generate .css files
  style_css = []
  variant_styles = []
  output_styles = []

  foreach style: styles
    stylename = style + variant_suffix
    high_contrast = style.endswith('high-contrast')

    if high_contrast
      if variant == DEFAULT_HIGH_CONTRAST_VARIANT
        stylename = style
      else
        continue
      endif
    endif

    variant_styles += '@0@.css'.format(stylename)
    output_styles += '@0@.css'.format(style)

    theme_main_file = configure_file(
      input: 'gnome-shell.scss.in',
      output: '@0@.scss'.format(stylename),
      configuration: {
        'Variant': variant,
        'YaruVariant': variant,
        'UseGResource': gnomeshell_use_gresource ? 'true' : 'false',
        'Contrast': high_contrast ? 'high' : 'normal',
        'Colors': (high_contrast ? 'high-contrast-' : '') + 'colors',
      },
    )

    style_css += custom_target(
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

    theme_gresource_files += style_css[-1].full_path()
    theme_gresource_deps += style_css[-1]
  endforeach

  # This is an hack we need to remove once meson fixes this issue:
  #  https://github.com/mesonbuild/meson/issues/2320
  # by just making the style_css to have an output in the 'variant' subdir
  if install_theme_sources and is_variant
    assert(output_styles.length() == variant_styles.length(), 'Output styles length mismatch')
    foreach i: range(output_styles.length())
      if variant_styles[i] == output_styles[i]
        continue
      endif
      meson.add_install_script('bash', '-c',
        'mv -v ${MESON_INSTALL_DESTDIR_PREFIX}/@0@ ${MESON_INSTALL_DESTDIR_PREFIX}/@1@'.format(
          install_dir / variant_styles[i], install_dir / output_styles[i]))
    endforeach
  endif

  # static files to copy
  data_sources = install_theme_sources ? theme_assets : []

  # install static data files
  install_data(data_sources, install_dir: install_dir)

  if install_theme_sources
    if meson.version().version_compare('>= 0.61')
      install_symlink('gnome-shell',
        install_dir: gnomeshell_alt_themes_dir / theme_full_name,
        # We could use a simpler definition, but that breaks $DESTDIR usage
        # https://github.com/mesonbuild/meson/pull/10176
        #pointing_to: get_option('prefix') / install_dir`
        pointing_to: run_command(python, '-c',
          'import os, sys; print(os.path.relpath(sys.argv[1], sys.argv[2]))',
          install_dir,
          gnomeshell_alt_themes_dir / theme_full_name
        ).stdout().strip(),
      )
    else
      meson.add_install_script('install-shell.sh', theme_full_name)
    endif
  endif
endforeach

if gnomeshell_use_gresource
  theme_gresource_files_xml = []

  foreach gfile: theme_gresource_files
    filepath = '@0@'.format(gfile)
    preprocess = ''
    alias = filepath[0] == '/' ? '@0@'.format(gfile).split('/')[-1] : filepath
    if alias == 'gnome-shell@0@.css'.format(DEFAULT_GDM_VARIANT != '' ? '-' + DEFAULT_GDM_VARIANT : '')
      # Use Yaru files for ubuntu's special gdm
      theme_gresource_files_xml += '<file alias="gdm.css">@0@</file>'.format(gfile)
    endif

    if alias.endswith('.css') and filepath.contains(meson.current_build_dir())
      # This is kept for compatibility reasons, but we may drop it once shell is updated too
      alias = 'Yaru' / alias
    endif

    if alias.endswith('.svg')
      preprocess = 'xml-stripblanks'
    endif

    theme_gresource_files_xml += '<file preprocess="@2@" alias="@0@">@1@</file>'.format(alias, gfile, preprocess)
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
endif
