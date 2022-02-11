project('Yaru',
        version: '22.04.1',
        meson_version: '>= 0.53',
        license : ['GPL3', 'CC BY-SA 4.0'],
        default_options: ['prefix=/usr'])

project_source_root = meson.current_source_dir()

components = ['icons', 'metacity', 'gnome-shell', 'gtk', 'gtksourceview', 'sounds', 'sessions', 'xfwm4', 'cinnamon']

foreach component: components
  if not get_option(component)
    message('skip component ' + component)
    continue
  endif

  message('build component ' + component)
  subdir(component)

endforeach
