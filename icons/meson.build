icon_flavors = [
  'default',
  'mate',
]

icon_flavors += enabled_accent_colors

fullcolor_path = 'src' / 'fullcolor'
render_bitmaps = find_program(fullcolor_path / 'render-bitmaps.py')
generate_symlinks = find_program('src' / 'symlinks' / 'generate-symlinks.sh')
generate_index_theme = find_program('src' / 'generate-index-theme.py')
accent_color_gtk_version_reference = '3.0'
render_targets = []
render_accented_targets = []
render_and_symlink_targets = []
symlink_targets = []

foreach flavour: icon_flavors
  is_accent = enabled_accent_colors.contains(flavour)
  if is_accent and not get_option('gtk')
    warning('GTK is not enabled, so we won\'t be able to generate accent colors')
    continue
  endif

  if is_accent or get_option(flavour)
    is_flavour = flavour != 'default'
    suffix = is_flavour ? '-@0@'.format(flavour) : ''
    icon_dir = 'Yaru' + suffix
    theme_name = meson.project_name() + suffix
    theme_install_dir = join_paths(get_option('prefix'), 'share/icons', theme_name)

    rendering_deps = []
    rendering_args = [
      '--variant', flavour,
      '--dest-path', meson.current_source_dir(),
    ]

    if is_accent
      accent_svgs = files(
        run_command(
          'find', meson.current_source_dir() / fullcolor_path / 'accented',
          '-name', '*.svg',
        ).stdout().strip().split('\n')
      )

      colors_definitions = gtk_yaru_colors_defs['@0@-gtk-@1@'.format(
        icon_dir, accent_color_gtk_version_reference)]

      foreach accent_svg: accent_svgs
        path = '@0@'.format(accent_svg)
        basename = path.split('/')[-1]
        category = path.split('/')[-2]
        accented_svg = custom_target(
          '-'.join([icon_dir, basename]),
          input: accent_svg,
          output: '@BASENAME@-@0@.svg'.format(flavour),
          command: [
            colorize_dummy_svg,
            colors_definitions,
            '--input-file', '@INPUT@',
            '--output-folder', '@OUTDIR@' / flavour / category,
            '--variant', flavour,
          ],
          depends: colors_definitions,
        )
        rendering_deps += accented_svg
      endforeach

      rendering_args += [
        '--source-path', meson.current_build_dir(),
      ]
    endif

    render_bitmaps_command = [
      render_bitmaps,
      rendering_args,
    ]
    render_bitmaps_target = custom_target(icon_dir + '-render',
      output: icon_dir + '-render',
      command: render_bitmaps_command,
      depends: rendering_deps,
    )

    # Sadly we can't use a run target as dependncy, thus the duplication
    render_bitmaps_run_target = run_target('render-icons-' + flavour,
      command: render_bitmaps_command,
      depends: rendering_deps,
    )
    render_targets += render_bitmaps_run_target

    if is_accent
      render_accented_targets += render_bitmaps_target
    endif

    generate_symlinks_command = [
      generate_symlinks,
      '--variant', flavour,
    ]
    generate_symlinks_target = run_target('symlink-icons-' + flavour,
      command: generate_symlinks_command,
    )
    symlink_targets += generate_symlinks_target

    render_and_symlinks_target = run_target('render+symlink-' + flavour,
      command: generate_symlinks_command,
      depends: render_bitmaps_target,
    )
    render_and_symlink_targets += render_and_symlinks_target

    alias_target('render+symlink-icons-' + flavour, render_and_symlinks_target)

    if is_accent
      render_accented_targets += render_and_symlinks_target

      if not fs.is_dir(icon_dir)
        warning('@0@ does not exists, ensure you generated it with `ninja -C @1@ render-icons-@2@,`'.format(
          icon_dir, meson.project_build_root(), flavour))
        continue
      endif
    endif

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
      have_file = false
      tmp_name = flavour + '-@0@'.format(theme)
      if fs.is_file(join_paths(icon_dir, theme))
        file = configure_file(
          input : join_paths(icon_dir, theme),
          output : tmp_name,
          configuration : conf_data
        )
        have_file = true
      elif theme == 'index.theme'
        file = configure_file(
          output: tmp_name,
          command: [
            generate_index_theme,
            icon_dir,
            '--source-dir', meson.current_source_dir() / icon_dir,
            '--output-dir', '@OUTDIR@',
            '--output-name', '@OUTPUT@',
            is_flavour ? ['--inherits', meson.project_name()] : [],
          ],
        )
        have_file = true
      endif

      if have_file
        install_data(file, install_dir: theme_install_dir, rename: theme)
      endif
    endforeach
    meson.add_install_script('meson/post_install.py', theme_name)
  endif
endforeach

alias_target('render-icons', render_targets)
alias_target('render+symlink-icons', render_and_symlink_targets)
alias_target('symlink-icons', symlink_targets)

if render_accented_targets.length() > 0
  alias_target('render-accented-icons', render_accented_targets)
endif
