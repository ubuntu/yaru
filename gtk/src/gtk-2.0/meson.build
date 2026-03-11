# gtk-2.0

gtk_dir = 'gtk-2.0'

foreach flavour: yaru_flavours
  suffix = flavour == 'default' ? '' : '-@0@'.format(flavour)
  theme_name = meson.project_name() + suffix
  install_path = join_paths(get_option('datadir'), 'themes', theme_name, gtk_dir)

  # Fall back to dark or default if this flavour has no pre-rendered dir
  is_dark = flavour == 'dark' or flavour.endswith('-dark')
  if fs.is_dir(meson.current_source_dir() / flavour)
    flavour_dir = meson.current_source_dir() / flavour
  elif is_dark
    flavour_dir = meson.current_source_dir() / 'dark'
  else
    flavour_dir = meson.current_source_dir() / 'default'
  endif

  install_data(
    flavour_dir / 'gtkrc',
    flavour_dir / 'main.rc',
    flavour_dir / 'apps.rc',
    flavour_dir / 'hacks.rc',
    install_dir: install_path,
  )

  install_subdir(
    flavour_dir / 'assets',
    install_dir: install_path,
  )
endforeach
