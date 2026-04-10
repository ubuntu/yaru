PANEL_ONLY_ICONS_CATEGORIES = [
  'animations',
  'legacy',
  'panel',
]

icon_flavors = yaru_flavours

fullcolor_path = 'src' / 'fullcolor'
xvfb_run = find_program('xvfb-run', required: false)
dbus_run_session = find_program('dbus-run-session', required: false)
inkscape = find_program('inkscape', required: false)
gtk_update_icon_cache = find_program('gtk-update-icon-cache', required: false)
render_bitmaps = find_program(fullcolor_path / 'render-bitmaps.py', required: true)
generate_symlinks = find_program('src' / 'symlinks' / 'generate-symlinks.sh', required: true)
generate_index_theme = find_program('src' / 'generate-index-theme.py', required: true)
accent_color_gtk_version_reference = '3.0'
uses_panel_icons = get_option('ubuntu-unity') or get_option('mate')
dark_theme = meson.project_name() + '-dark'
index_theme = 'index.theme'
cursor_theme = 'cursor.theme'
render_targets = []
render_accented_targets = []
render_and_symlink_targets = []
render_and_symlink_accented_targets = []
symlink_targets = []
render_by_icon_targets = {}
cleanup_rendered_icons_targets = []
cleanup_rendered_icons_accented_targets = []
cleanup_symlinks_targets = []
cleanup_symlinks_accented_targets = []

svg_source_categories_excludes = ''
foreach c: PANEL_ONLY_ICONS_CATEGORIES
  svg_source_categories_excludes += ' ! -path "*/@0@/*"'.format(c)
endforeach

if not inkscape.found()
  warning('Inkscape not found, bitmap rendering not supported')
endif

render_wrappers = xvfb_run.found() ? [xvfb_run, '-a', '--'] : []
render_wrappers += dbus_run_session.found() ? [dbus_run_session, '--'] : []

accented_full_svgs = []
accented_full_relnames = []
accented_full_svgs_path = fullcolor_path / 'accented-full'
if icon_flavors.length() > 0 and fs.is_dir(accented_full_svgs_path)
  accented_full_svgs = files(
    run_command(
      'find',
      meson.current_source_dir() / accented_full_svgs_path,
      '-name', '*.svg',
      check: true,
    ).stdout().strip().split('\n')
  )
  foreach svg: accented_full_svgs
    accented_full_relnames += fs.name(fs.parent(svg)) / fs.name(svg)
  endforeach
endif

all_accented_svgs = accented_full_svgs
all_accented_relnames = accented_full_relnames
accented_svgs_path = fullcolor_path / 'accented'
if icon_flavors.length() > 0 and fs.is_dir(accented_svgs_path)
  foreach svg: files(
    run_command(
      'find',
      meson.current_source_dir() / accented_svgs_path,
      '-name', '*.svg',
      check: true,
    ).stdout().strip().split('\n')
  )
    relname = fs.name(fs.parent(svg)) / fs.name(svg)
    if relname in accented_full_relnames
      error('Icon @0@ exists in both accented and accented-full, accented one is ignored'.format(
        relname))
    endif
    all_accented_svgs += svg
    all_accented_relnames += relname
  endforeach
endif

foreach flavour: icon_flavors
  message('Icons: Configuring flavour ' + flavour)
  is_dark = flavour == 'dark'
  is_dark_flavour = not is_dark and flavour.endswith('-dark')
  is_accent = enabled_accent_colors.contains(flavour)
  base_flavour = is_dark_flavour ? flavour.split('-dark')[0] : ''
  is_dark_accent = is_dark_flavour and enabled_accent_colors.contains(base_flavour)

  if (is_accent or is_dark_accent) and not get_option('gtk')
    warning('GTK is not enabled, so we won\'t be able to generate accent colors')
    continue
  endif

  if (is_accent or is_dark_accent) or get_option(flavour)
    is_flavour = flavour != 'default'
    suffix = is_flavour ? '-@0@'.format(flavour) : ''
    icon_dir = 'Yaru' + suffix
    theme_name = meson.project_name() + suffix
    theme_install_dir = get_option('datadir') / 'icons' / theme_name

    rendering_deps = []
    rendering_args = [
      '--variant', flavour,
      '--dest-path', meson.current_source_dir(),
    ]
    rendering_source_path_args = []

    source_svgs = []
    specific_svg_count = 0

    accented_svgs    = (is_dark or is_dark_flavour) ? accented_full_svgs : all_accented_svgs
    accented_relnames = (is_dark or is_dark_flavour) ? accented_full_relnames : all_accented_relnames

    # For non-accent flavours: include all flavour-specific SVGs not covered
    # by an accented counterpart.
    if not is_accent
      flavour_svgs_path = fullcolor_path / flavour
      if fs.is_dir(flavour_svgs_path)
        foreach svg: files(
          run_command(
            'find',
            meson.current_source_dir() / flavour_svgs_path,
            '-name', '*.svg',
            check: true,
          ).stdout().strip().split('\n')
        )
          if fs.name(fs.parent(svg)) / fs.name(svg) not in accented_relnames
            source_svgs += svg
          endif
        endforeach
      endif
    endif

    # For each accented SVG: if the flavour has a specific override use it
    # directly; otherwise collect it for colorization and rendering.
    foreach svg: accented_svgs
      category = fs.name(fs.parent(svg))
      flavour_override = fullcolor_path / flavour / category / fs.name(svg)
      if not is_accent and fs.is_file(flavour_override)
        source_svgs += files(flavour_override)
      endif
    endforeach

    specific_svg_count = source_svgs.length()

    # Colorize every accented SVG that has no flavour-specific override.
    if accented_svgs.length() > 0
      colors_definitions = gtk_yaru_colors_defs['@0@-gtk-@1@'.format(
        icon_dir, accent_color_gtk_version_reference)]

      foreach svg: accented_svgs
        category = fs.name(fs.parent(svg))
        flavour_override = fullcolor_path / flavour / category / fs.name(svg)
        if is_accent or not fs.is_file(flavour_override)
          accented_svg = custom_target(
            '-'.join([icon_dir, fs.name(svg)]),
            input: svg,
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
          source_svgs += svg
        endif
      endforeach

      if rendering_deps.length() > 0
        rendering_source_path_args = [
          '--source-path', meson.current_build_dir(),
        ]
      endif
    endif

    render_flavour_targets = []
    foreach i: range(source_svgs.length())
      svg = source_svgs[i]
      basename = fs.stem(fs.name(svg))
      category = fs.name(fs.parent(svg))
      is_specific_svg = i < specific_svg_count
      render_bitmap_target = custom_target(
        'render-icon-' + '-'.join([category, basename, flavour]),
        input: svg,
        output: 'rendered-@0@-@BASENAME@-@1@.svg'.format(category, flavour),
        env: [
          'NO_AT_BRIDGE=1',
        ],
        command: [
          render_wrappers,
          render_bitmaps,
          rendering_args,
          is_specific_svg ? [] : rendering_source_path_args,
          '--categories', category,
          basename,
        ],
        depends: is_specific_svg ? [] : rendering_deps[i - specific_svg_count],
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
      rendering_source_path_args,
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
        'bash', '-xc',
          ';'.join([
            'ls -d "$0"/$1 >/dev/null 2>&1 || exit 0',
            'find "$0"/$1 -name "*.png" -print -delete',
            (rendering_deps.length() > 0 ?
            'find "$0"/$1 -name "*.svg" @0@ -print -delete'.format(svg_source_categories_excludes) :
            'true'),
            'find "$0"/$1 -type d -empty -print -delete'
          ]),
        meson.project_source_root() / meson.current_source_dir() / icon_dir,
        '[0-9]*x[0-9]*',
      ]
    )
    cleanup_rendered_icons_targets += cleanup_rendered_flavour

    cleanup_symlinks_flavour = run_target('cleanup-symlinks-' + flavour,
      command: [
        'bash', '-xc',
          ';'.join([
            'ls -d "$0"/$1 >/dev/null 2>&1 || exit 0',
            'find "$0"/$1 -type l -print -delete',
            'find "$0"/$1 -type d -empty -print -delete',
          ]),
        meson.project_source_root() / meson.current_source_dir() / icon_dir,
        '[0-9]*x[0-9]*',
      ]
    )
    cleanup_symlinks_targets += cleanup_symlinks_flavour

    if render_flavour_targets.length() > 0
      alias_target('render-icons-' + flavour, render_flavour_targets)
      alias_target('render+symlink-icons-' + flavour, render_and_symlink_flavour)
      alias_target('cleanup-rendered-icons-' + flavour, cleanup_rendered_flavour)
    endif

    if is_accent or rendering_deps.length() > 0
      render_accented_targets += render_flavour_targets
      render_and_symlink_accented_targets += render_and_symlink_flavour
      cleanup_rendered_icons_accented_targets += cleanup_rendered_flavour
      cleanup_symlinks_accented_targets += cleanup_symlinks_flavour

      if is_accent and not fs.is_dir(icon_dir)
        warning('@0@ does not exists, ensure you generated it with `ninja -C @1@ render-icons-@2@,`'.format(
          icon_dir, meson.project_build_root(), flavour))
        continue
      endif
    endif

    # The part above this line is meant to only contain "target definition"
    # not to install or generate things. Put them below!

    excluded_folders = []
    excluded_files = [
      index_theme,
      cursor_theme,
    ]

    if not uses_panel_icons
      included_names = []
      foreach i: range(PANEL_ONLY_ICONS_CATEGORIES.length())
        included_names += ['-name', PANEL_ONLY_ICONS_CATEGORIES[i]]
        if i < PANEL_ONLY_ICONS_CATEGORIES.length() - 1
          included_names += '-or'
        endif
      endforeach

      excluded_folders += run_command('find', icon_dir,
        '-type', 'd',
        included_names.length() > 0 ? ['('] + included_names + [')'] : [],
        '-printf', '%P\\n',
        check: false,
      ).stdout().strip().split('\n')

      if excluded_folders.length() == 1 and excluded_folders[0] == ''
        excluded_folders = []
      endif
    endif

    symlinks = []
    if fs.is_dir(icon_dir)
      message('Looking for symlinks in ' + icon_dir)

      find_args = []
      foreach f: excluded_folders
        find_args += ['(', '-not', '-path', icon_dir / f / '*', '-prune', ')' ]
      endforeach

      local_links = run_command(
        'find',
        icon_dir,
        '-type', 'l',
        find_args,
        check: true,
      ).stdout().strip().split('\n')

      if local_links.length() == 1 and local_links[0] == ''
        local_links = []
      endif

      if local_links.length() > 0
        relative_to = meson.current_source_dir() / icon_dir
        links_paths_getter = run_command(
          'realpath', '-e',
          '--relative-to=' + relative_to,
          local_links,
          check: false,
        )

        if links_paths_getter.returncode() != 0
          failed_links = []
          foreach link: local_links
            if run_command(
              'realpath', '-e',
              '--relative-to=' + relative_to,
              link,
              check: false,
            ).returncode() != 0
              failed_links += link
            endif
          endforeach

          error ('Symbolic links are pointing to invalid paths:\n  ' +
            '\n  '.join(failed_links))
        endif

        links_targets = links_paths_getter.stdout().strip().split('\n')
        assert(local_links.length() == links_targets.length())
      endif

      foreach i: range(local_links.length())
        link_paths = local_links[i].split('/')
        link_subdirs = []
        foreach j: range(link_paths.length() - 1)
          link_subdirs += link_paths[j+1]
        endforeach
        sub_link = '/'.join(link_subdirs)
        symlinks += sub_link
      endforeach

      excluded_files += symlinks
    endif

    install_subdir(icon_dir,
      install_dir: theme_install_dir,
      strip_directory: true,
      exclude_files: excluded_files,
      exclude_directories: excluded_folders,
    )

    foreach i: range(symlinks.length())
      link_path = fs.parent(symlinks[i])
      symlink_dir = theme_install_dir / link_path
      target = links_targets[i]

      if link_path == fs.parent(target)
        target = fs.name(target)
      else
        target = run_command(python, '-c',
          'import os, sys; print(os.path.relpath(sys.argv[1], sys.argv[2]))',
          target,
          link_path,
          check: true,
        ).stdout().strip()
      endif

      install_symlink(fs.name(symlinks[i]),
        install_dir: symlink_dir,
        pointing_to: target,
      )
    endforeach

    if is_dark_flavour
      assert(get_option('dark'), 'Dark flavour @0@ enabled, but we have no dark parent'.format(flavour))
      # Since we don't have a specific dark theme, we are just re-using
      # the default dark theme as fallback, while the base flavour theme
      # is still inherited as primary.
      dark_categories = run_command(
        'find',
        dark_theme,
        '!', '-path', dark_theme,
        '-type', 'd',
        '-mindepth', '2',
        '-maxdepth', '2',
        '-printf', '%P\\n',
        check: true,
      ).stdout().strip()
      dark_categories = dark_categories != '' ? dark_categories.split('\n') : []

      foreach c: dark_categories
        if fs.is_dir(icon_dir / c)
          continue
        endif

        category = fs.name(c)
        if not uses_panel_icons and PANEL_ONLY_ICONS_CATEGORIES.contains(category)
          continue
        endif

        target = run_command(python, '-c',
          'import os, sys; print(os.path.relpath(sys.argv[1], sys.argv[2]))',
          dark_theme / c,
          icon_dir / fs.parent(c),
          check: true,
        ).stdout().strip()

        install_symlink(category,
          install_dir: theme_install_dir / fs.parent(c),
          pointing_to: target,
        )
      endforeach
    endif

    # install cursor thumbnail (cinnamon only)
    if get_option('cinnamon-shell') and flavour == 'default'
      install_data(
        'src' / 'cursors' / 'thumbnail.png',
        install_dir: theme_install_dir / 'cursors',
      )
    endif

    generate_index_theme_args = []
    foreach ef: excluded_folders
      generate_index_theme_args += ['--exclude-directory', ef]
    endforeach

    if is_flavour
      if is_dark_flavour
        if not fs.is_dir(theme_dir)
          foreach c: uses_panel_icons ? [] : PANEL_ONLY_ICONS_CATEGORIES
            generate_index_theme_args += ['--exclude-context', c]
          endforeach
        endif

        generate_index_theme_args += [
          '--inherits', dark_theme,
          '--source-dir', meson.current_source_dir() / dark_theme,
        ]
      endif

      inherited_flavour = base_flavour != '' ? '-' + base_flavour : ''
        generate_index_theme_args += [
          '--inherits', meson.project_name() + inherited_flavour
        ]
    endif

    install_data(
      configure_file(
        output: flavour + '-@0@'.format(index_theme),
        command: [
          generate_index_theme,
          icon_dir,
          '--source-dir', meson.current_source_dir() / icon_dir,
          '--output-dir', '@OUTDIR@',
          '--output-name', '@OUTPUT@',
        ] + generate_index_theme_args,
      ),
      install_dir: theme_install_dir,
      rename: index_theme,
    )

    if fs.is_file(icon_dir / cursor_theme)
      install_data(
        configure_file(
          input: icon_dir / cursor_theme,
          output: flavour + '-@0@'.format(cursor_theme),
          configuration: {
            'ProjectName': meson.project_name(),
            'ThemeName': theme_name,
          },
        ),
        install_dir: theme_install_dir,
        rename: cursor_theme,
      )
    endif

    # Cleanup empty directories, as per excluded files
    meson.add_install_script('bash', '-c',
      'find "${MESON_INSTALL_DESTDIR_PREFIX}/@0@" -type d -empty -print -delete'.format(theme_install_dir))
    if gtk_update_icon_cache.found()
      meson.add_install_script(
        'bash', '-c',
        '"@0@" -qtf "${MESON_INSTALL_PREFIX}/@1@"'.format(
          gtk_update_icon_cache.full_path(),
          get_option('datadir') / 'icons' / theme_name),
        skip_if_destdir: true,
      )
    endif

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
alias_target('cleanup-symlink-icons', cleanup_symlinks_targets)
alias_target('cleanup-rendered-icons', cleanup_rendered_icons_targets)

if render_accented_targets.length() > 0
  alias_target('render-accented-icons', render_and_symlink_accented_targets)
  alias_target('render-icons-accented', render_accented_targets)
  alias_target('render+symlink-icons-accented', render_and_symlink_accented_targets)
  alias_target('cleanup-rendered-icons-accented', cleanup_rendered_icons_accented_targets)
  alias_target('cleanup-symlinks-accented', cleanup_symlinks_accented_targets)
endif

foreach icon, targets: render_by_icon_targets
  alias_target('icon-render-' + icon, targets)
endforeach
