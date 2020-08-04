project('Yaru-dev',
        version: '20.04',
        meson_version: '>= 0.51',
        license : ['GPL3', 'CC BY-SA 4.0'],
        default_options: ['prefix=/usr'])


components = ['libreoffice-icons', 'icons', 'gnome-shell', 'gtk', 'sounds', 'sessions']

foreach component: components
  if not get_option(component)
    message('skip component ' + component)
    continue
  endif

  message('build component ' + component)
  subdir(component)

endforeach

subdir('communitheme-compat')
