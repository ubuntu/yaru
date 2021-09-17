project('Yaru',
        version: '21.10.1',
        meson_version: '>= 0.51',
        license : ['GPL3', 'CC BY-SA 4.0'],
        default_options: ['prefix=/usr'])


components = ['icons', 'metacity', 'gnome-shell', 'gtk', 'gtksourceview', 'sounds', 'sessions', 'xfwm4']

foreach component: components
  if not get_option(component)
    message('skip component ' + component)
    continue
  endif

  message('build component ' + component)
  subdir(component)

endforeach

subdir('communitheme-compat')
