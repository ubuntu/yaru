foreach flavour: flavours
  suffix = flavour == 'default' ? '' : '-@0@'.format(flavour)
  theme_name = meson.project_name() + suffix
  theme_file = configure_file(input: flavour + '.xml.in',
    output: theme_name + '.xml',
    configuration: {
      'ThemeName': meson.project_name(),
      'FlavourThemeName': theme_name,
    })

  gtksourceview_dir = 'gtksourceview-5'
  style_dir = join_paths(get_option('datadir'), gtksourceview_dir, 'styles')
  install_data(theme_file, install_dir: style_dir)
endforeach
