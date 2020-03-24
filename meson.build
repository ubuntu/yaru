project('Yaru',
        version: '19.10',
        meson_version: '>= 0.45',
        license : ['GPL3', 'CC BY-SA 4.0'],
        default_options: ['prefix=/usr'])


components = ['icons', 'gnome-shell', 'gtk', 'sounds', 'sessions']

foreach component: components
  if get_option(component)
    subdir(component)
  endif
endforeach

subdir('communitheme-compat')
meson.add_install_script('debug-snap-build.sh')
