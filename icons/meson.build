foreach flavour: ['default', 'dark', 'light']
  if not get_option(flavour)
    message('skip flavour ' + flavour)
    continue
  endif
  suffix = flavour == 'default' ? '' : '-@0@'.format(flavour)
  theme_name = meson.project_name() + suffix
  theme_dir = join_paths(get_option('prefix'), 'share/icons', theme_name)

  install_subdir('Suru',
      install_dir: theme_dir,
      strip_directory: true,
      exclude_files: ['index.theme', 'cursor.theme'],
  )

  themes_f = [
    'cursor.theme',
    'index.theme',
  ]

  conf_data = configuration_data()
  conf_data.set('ThemeName', theme_name)

  if flavour == 'dark'
    conf_data.set('InheritThemes', 'Ambiant-MATE,ubuntu-mono-dark,Humanity-Dark,gnome,hicolor,mate')
  elif flavour == 'light'
    conf_data.set('InheritThemes', 'Radiant-MATE,ubuntu-mono-light,Humanity,gnome,hicolor,mate')
  else
    conf_data.set('InheritThemes', 'Radiant-MATE,ubuntu-mono-light,Humanity,gnome,hicolor,mate')
  endif

  foreach theme: themes_f
    configure_file(input : 'Suru/@0@'.format(theme),
                  output: '@0@-@1@'.format(flavour, theme),
                  configuration : conf_data,
                  install_dir: theme_dir)
  endforeach
  meson.add_install_script('meson/post_install.py', get_option('datadir'), meson.project_name(), flavour)
endforeach
