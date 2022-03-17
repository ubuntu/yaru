fullcolor_path = 'src' / 'fullcolor'
render_bitmaps = find_program(fullcolor_path / 'render-bitmaps.py')
render_targets = []

foreach flavour: ['default', 'mate']
  if get_option(flavour)
    suffix = flavour == 'default' ? '' : '-@0@'.format(flavour)
    icon_dir = 'Yaru' + suffix
    theme_name = meson.project_name() + suffix
    theme_install_dir = join_paths(get_option('prefix'), 'share/icons', theme_name)

    rendering_deps = []
    rendering_args = [
      '--variant', flavour,
      '--dest-path', meson.current_source_dir(),
    ]

    render_bitmaps_target = run_target(icon_dir,
      command: [
        render_bitmaps,
        rendering_args,
      ],
      depends: rendering_deps,
    )

    alias_target('render-icons-' + flavour, render_bitmaps_target)
    render_targets += render_bitmaps_target

    install_subdir(icon_dir,
      install_dir: theme_install_dir,
      strip_directory: true,
      exclude_files: ['index.theme', 'cursor.theme'],
    )

    # install unity and MATE panel-icons
    install_subdir('panel',
      install_dir: theme_install_dir,
      strip_directory: true,
    )

    # install cursor thumbnail (cinnamon only)
    if get_option('cinnamon-shell') and flavour == 'default'
      install_data(
        join_paths('src', 'cursors', 'thumbnail.png'),
        install_dir: join_paths(theme_install_dir, 'cursors')
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
      if fs.is_file(join_paths(icon_dir, theme))
        file = configure_file(
          input : join_paths(icon_dir, theme),
          output : flavour + '-@0@'.format(theme),
          configuration : conf_data
        )
        install_data(file, install_dir: theme_install_dir, rename: theme)
      endif
    endforeach

    meson.add_install_script('meson/post_install.py', theme_name)
  endif
endforeach

alias_target('render-icons', render_targets)
