project('Yaru',
        version: '24.10.4',
        meson_version: '>= 0.60',
        license : ['GPL3', 'CC BY-SA 4.0'],
        default_options: ['prefix=/usr'])

fs = import('fs')
gnome = import('gnome')

python = find_program('python3')
sassc = find_program('sassc')

subdir('common')

components = [
  'metacity',
  'gnome-shell',
  'gtk',
  'icons',
  'gtksourceview',
  'sounds',
  'sessions',
  'ubuntu-unity',
  'xfwm4',
  'cinnamon-shell',
]

enabled_accent_colors = get_option('accent-colors')

foreach component: components
  if not get_option(component)
    message('skip component ' + component)
    continue
  endif

  message('build component ' + component)
  subdir(component)

endforeach
