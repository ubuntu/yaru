gnome = import('gnome')
sassc = find_program('sassc')

variants = [
  'gtk',
  'gtk-dark'
]
gtkversions = [
  '3.0',
  '3.20'
]

foreach flavour: flavours
  suffix = flavour == 'default' ? '' : '-@0@'.format(flavour)
  theme_name = meson.project_name() + suffix

  theme_dir = join_paths(get_option('datadir'), 'themes', theme_name)

  conf_data = configuration_data()
  conf_data.set('ThemeName', theme_name)
  conf_data.set('FlavourThemeName', theme_name)
  configure_file(input: 'index.theme.in',
    output: '@0@-index.theme'.format(theme_name),
    configuration: conf_data,
    install_dir: theme_dir)

  # install unity assets
  if flavour == 'default' and get_option('ubuntu-unity')
    subdir(join_paths('default', 'unity'))
  endif

  # install gtk2 data
  subdir(join_paths(flavour, 'gtk-2.0'))

  # build and install gtk3 data
  foreach gtkver: gtkversions
    # load gtk3 scss and assets from subdirs
    gtk_dir = 'gtk-@0@'.format(gtkver)
    sources_relative_path = join_paths(flavour, gtk_dir)

    # let the subdirs define assets and dependencies
    gtk3_assets = []
    gtk3_scss_dependencies = []
    subdir(sources_relative_path)

    foreach variant : variants
      target_name = '@0@-@1@-@2@-generated'.format(theme_name, variant, gtkver)
      gtk_sass_path = join_paths(sources_relative_path, variant)

      custom_target(target_name,
        input: '@0@.scss'.format(gtk_sass_path),
        output: '@0@.css'.format(target_name),
        depend_files: files(gtk3_scss_dependencies),
        command: [sassc, '-a', '@INPUT@', '@OUTPUT@'],
        install: true,
        install_dir: join_paths(theme_dir, gtk_dir))
    endforeach

    install_data(gtk3_assets, install_dir: join_paths(theme_dir, gtk_dir, 'assets'))

  endforeach
endforeach

meson.add_install_script('post_install.py', get_option('datadir'), meson.project_name(), flavours)
