icon_flavors = [
  'default',
  'mate',
]

icon_flavors += enabled_accent_colors

fullcolor_path = 'src' / 'fullcolor'
render_bitmaps = find_program(fullcolor_path / 'render-bitmaps.py', required: true)
generate_symlinks = find_program('src' / 'symlinks' / 'generate-symlinks.sh', required: true)
generate_index_theme = find_program('src' / 'generate-index-theme.py', required: true)
accent_color_gtk_version_reference = '3.0'
render_targets = []
render_accented_targets = []
render_and_symlink_targets = []
render_and_symlink_accented_targets = []
symlink_targets = []
render_by_icon_targets = {}
cleanup_rendered_icons_targets = []
cleanup_rendered_icons_accented_targets = []

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

    source_svgs = files(
      run_command(
        'find',
        meson.current_source_dir() / fullcolor_path / (is_accent ? 'accented' : flavour),
        '-name', '*.svg',
      ).stdout().strip().split('\n')
    )

    if is_accent
      colors_definitions = gtk_yaru_colors_defs['@0@-gtk-@1@'.format(
        icon_dir, accent_color_gtk_version_reference)]

      foreach accent_svg: source_svgs
        category = fs.name(fs.parent(accent_svg))
        accented_svg = custom_target(
          '-'.join([icon_dir, fs.name(accent_svg)]),
          input: accent_svg,
          output: '@BASENAME@-@0@.svg'.format(flavour),
          command: [
            colorize_dummy_svg,
            colors_definitions,
            '--input-file', '@INPUT@',
            '--output-folder', '@OUTDIR@' / flavour / category,
          ],
          depends: colors_definitions,
        )
        rendering_deps += accented_svg
      endforeach

      rendering_args += [
        '--source-path', meson.current_build_dir(),
      ]
    endif

    render_flavour_targets = []
    foreach i: range(source_svgs.length())
      svg = source_svgs[i]
      basename = fs.stem(fs.name(svg))
      category = fs.name(fs.parent(svg))
      render_bitmap_target = custom_target('render-icon-' + '-'.join([category, basename, flavour]),
        input: svg,
        output: 'rendered-@BASENAME@-' + '-'.join([category, flavour]) + '.svg',
        command: [
          render_bitmaps,
          rendering_args,
          '--categories', category,
          basename,
        ],
        depends: is_accent ? rendering_deps[i] : [],
      )
      render_flavour_targets += render_bitmap_target
      render_targets += render_bitmap_target

      icon_targets = render_by_icon_targets.get(basename, [])
      icon_targets += render_bitmap_target
      render_by_icon_targets += { basename: icon_targets }
    endforeach

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
    generate_symlinks_command = [
      generate_symlinks,
      '--variant', flavour,
    ]
    generate_symlinks_target = run_target('symlink-icons-' + flavour,
      command: generate_symlinks_command,
    )
    symlink_targets += generate_symlinks_target

    render_and_symlink_flavour = run_target('render+symlink-' + flavour,
      command: generate_symlinks_command,
      depends: render_flavour_targets,
    )
    render_and_symlink_targets += render_and_symlink_flavour

    cleanup_rendered_flavour = run_target('cleanup-rendered-' + flavour,
      command: [
        'bash', '-c', 'rm -rfv "$0"/$1',
        meson.project_source_root() / meson.current_source_dir() / icon_dir,
        '[0-9]*x[0-9]*',
      ]
    )
    cleanup_rendered_icons_targets += cleanup_rendered_flavour

    alias_target('render-icons-' + flavour, render_flavour_targets)
    alias_target('render+symlink-icons-' + flavour, render_and_symlink_flavour)
    alias_target('cleanup-rendered-icons-' + flavour, cleanup_rendered_flavour)

    if is_accent
      render_accented_targets += render_flavour_targets
      render_and_symlink_accented_targets += render_and_symlink_flavour
      cleanup_rendered_icons_accented_targets += cleanup_rendered_flavour

      if not fs.is_dir(icon_dir)
        warning('@0@ does not exists, ensure you generated it with `ninja -C @1@ render-icons-@2@,`'.format(
          icon_dir, meson.project_build_root(), flavour))
        continue
      endif
    endif

    # The part above this line is meant to only contain "target definition"
    # not to install or generate things. Put them below!

    install_subdir(icon_dir,
      install_dir: theme_install_dir,
      strip_directory: true,
      exclude_files: ['index.theme', 'cursor.theme'],
    )

    if flavour == 'default' and (get_option('ubuntu-unity') or get_option('mate'))
      # install unity and MATE panel-icons
      install_subdir('panel',
        install_dir: theme_install_dir,
        strip_directory: true,
      )
    endif

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


    test('generate-symlinks' + suffix,
      generate_symlinks,
      args: [
        '--variant', flavour,
        '--dry-run',
        '--verbose',
      ],
      suite: ['tools', 'generate-symlinks'],
      workdir: fs.parent(generate_symlinks.full_path()))
  endif
endforeach

alias_target('render-icons', render_targets)
alias_target('render+symlink-icons', render_and_symlink_targets)
alias_target('symlink-icons', symlink_targets)
alias_target('cleanup-rendered-icons', cleanup_rendered_icons_targets)

if render_accented_targets.length() > 0
  alias_target('render-accented-icons', render_and_symlink_accented_targets)
  alias_target('render-icons-accented', render_accented_targets)
  alias_target('render+symlink-icons-accented', render_and_symlink_accented_targets)
  alias_target('cleanup-rendered-icons-accented', cleanup_rendered_icons_accented_targets)
endif

foreach icon, targets: render_by_icon_targets
  alias_target('icon-render-' + icon, targets)
endforeach
