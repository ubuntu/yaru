gnome = import('gnome')
sassc = find_program('sassc')

foreach flavour: flavours
  # default flavour theme_name is just Yaru
  if flavour == 'default'
    theme_name = meson.project_name()
  else
    theme_name = meson.project_name() + '-' + flavour
  endif

  theme_dir = join_paths(get_option('datadir'), 'themes', theme_name)

  conf_data = configuration_data()
  conf_data.set('ThemeName', theme_name)
  conf_data.set('FlavourThemeName', theme_name)
  configure_file(input: 'index.theme.in',
    output: theme_name + '-index.theme',
    configuration: conf_data,
    install_dir: theme_dir)

  # install unity assets
  if flavour == 'default' and get_option('ubuntu-unity')
    subdir(join_paths('default', 'unity'))
  endif

  # install gtk2 data
  subdir(join_paths(flavour, 'gtk-2.0'))

  # build and install gtk3 data
  foreach gtkver: ['3.0', '3.20']
    # load gtk3 scss and assets from subdirs
    gtk3_assets = []
    gtk3_scss_dependencies = []
    subdir(join_paths(flavour, 'gtk-' + gtkver))

    sources_relative_path = join_paths(flavour, 'gtk-' + gtkver)

    foreach variant : [ 'gtk', 'gtk-dark' ]
      target_name = '@0@-@1@-@2@-generated'.format(theme_name, variant, gtkver)
      gtk_sass_path = join_paths(sources_relative_path, variant)

      custom_target(target_name,
        input: gtk_sass_path + '.scss',
        output: target_name + '.css',
        depend_files: files(gtk3_scss_dependencies),
        command: [sassc, '-a', '@INPUT@', '@OUTPUT@'],
        install: true,
        install_dir: join_paths(theme_dir, 'gtk-' + gtkver))
    endforeach

    install_data(gtk3_assets, install_dir: join_paths(theme_dir, 'gtk-' + gtkver, 'assets'))

  endforeach
endforeach

meson.add_install_script('post_install.py', get_option('datadir'), meson.project_name(), flavours)
