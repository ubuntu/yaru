foreach flavour: flavours
  suffix = flavour == 'default' ? '' : '-@0@'.format(flavour)
  theme_name = meson.project_name() + suffix
  foreach version: ['2.0', '3.0', '4']
    gtksourceview_dir = 'gtksourceview-' + version
    style_dir = join_paths(get_option('datadir'), gtksourceview_dir, 'styles')

    conf_data = configuration_data()
    conf_data.set('ThemeName', meson.project_name())
    conf_data.set('FlavourThemeName', theme_name)
    conf_data.set('PrimaryAccent', '#E95420')

    configure_file(input: flavour + '.xml.in',
      output: theme_name + '.xml',
      configuration: conf_data,
      install_dir: style_dir
    )
  endforeach
endforeach
