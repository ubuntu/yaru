foreach flavour: flavours
  suffix = flavour == 'default' ? '' : '-@0@'.format(flavour)
  theme_name = meson.project_name() + suffix
  theme_file = configure_file(input: flavour + '.xml.in',
    output: theme_name + '.xml',
    configuration: {
      'ThemeName': meson.project_name(),
      'FlavourThemeName': theme_name,
    })

  foreach version: ['gtksourceview-2.0',
                    'gtksourceview-3.0',
                    'gtksourceview-4',
                    'libgedit-gtksourceview-300']
    style_dir = get_option('datadir') / version / 'styles'
    install_data(theme_file, install_dir: style_dir)
  endforeach
endforeach
