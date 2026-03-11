project('Yaru',
        version: '25.10.3',
        meson_version: '>= 0.60',
        license : ['GPL3', 'CC BY-SA 4.0'],
        default_options: ['prefix=/usr'])

fs = import('fs')
gnome = import('gnome')

python = find_program('python3')
sassc = find_program('sassc')

enabled_accent_colors = get_option('accent-colors')
subdir('common')

# gtk must be processed before icons (icons/meson.build consumes gtk_yaru_colors_defs)
gtk_yaru_colors_defs = {}
if get_option('gtk-2') or get_option('gtk-3') or get_option('gtk-4')
  message('build component gtk')
  subdir('gtk')
endif

components = [
  'metacity',
  'gnome-shell',
  'icons',
  'gtksourceview',
  'sounds',
  'sessions',
  'ubuntu-unity',
  'xfwm4',
  'cinnamon-shell',
]

foreach component: components
  if not get_option(component)
    message('skip component ' + component)
    continue
  endif

  message('build component ' + component)
  subdir(component)
endforeach
