fs = import('fs')

stylesheet_deps = []

# For git checkouts, but not for tarballs...
if not fs.exists('Adwaita-light.css')
  sassc = find_program('sassc', required: false)
  if not sassc.found()
    subproject('sassc')
    sassc = find_program('sassc')
  endif

  if sassc.found()
    sassc_opts = [ '-a', '-M', '-t', 'compact' ]

    scss_files = files([
      '_colors-public.scss',
      '_colors.scss',
      '_common.scss',
      '_drawing.scss',
    ])

    theme_variants = [
      'light',
      'dark',
      'hc',
      'hc-dark',
    ]

    foreach variant: theme_variants
      stylesheet_deps += custom_target('Stylesheet variant: ' + variant,
        input: 'Adwaita-@0@.scss'.format(variant),
        output: 'Adwaita-@0@.css'.format(variant),
        command: [
          sassc, sassc_opts, '@INPUT@', '@OUTPUT@',
        ],
        depend_files: scss_files,
      )
    endforeach
  endif
endif

libadwaita_stylesheet_resources = gnome.compile_resources(
  'adwaita-stylesheet-resources',
  'adwaita-stylesheet.gresources.xml',

  source_dir: [
    # List in order of preference
    meson.current_build_dir(),
    meson.current_source_dir(),
  ],
  dependencies: stylesheet_deps,
  c_name: 'adw_stylesheet',
)

