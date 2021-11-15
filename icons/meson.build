fs = import('fs')

foreach flavour: ['default', 'mate']
  if get_option(flavour)
    suffix = flavour == 'default' ? '' : '-@0@'.format(flavour)
    theme_name = meson.project_name() + suffix
    theme_dir = join_paths(get_option('prefix'), 'share/icons', theme_name)

    install_subdir(theme_name,
      install_dir: theme_dir,
      strip_directory: true,
      exclude_files: ['index.theme', 'cursor.theme'],
    )

    # install unity-panel icons
    if get_option('ubuntu-unity') and flavour == 'default'
      install_subdir('unity-panel',
        install_dir: theme_dir,
        strip_directory: true,
      )
    endif

    themes_f = [
      'cursor.theme',
      'index.theme',
    ]
    conf_data = configuration_data()
    conf_data.set('ProjectName', meson.project_name())
    conf_data.set('ThemeName', theme_name)
    foreach theme: themes_f
      if fs.is_file(join_paths(theme_name, theme))
        configure_file(input : theme_name + '/@0@'.format(theme),
                      output : '@0@'.format(theme),
                      configuration : conf_data,
                      install_dir: theme_dir)
      endif
    endforeach

    meson.add_install_script('meson/post_install.py', theme_name)
  endif
endforeach
