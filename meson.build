project('Yaru',
        version: '22.04.1',
        meson_version: '>= 0.53',
        license : ['GPL3', 'CC BY-SA 4.0'],
        default_options: ['prefix=/usr'])

fs = import('fs')
gnome = import('gnome')

if meson.version().version_compare('>= 0.56')
  project_source_root = meson.project_source_root()
else
  project_source_root = meson.current_source_dir()
endif

components = [
  'icons',
  'metacity',
  'gnome-shell',
  'gtk',
  'gtksourceview',
  'sounds',
  'sessions',
  'ubuntu-unity',
  'xfwm4',
  'cinnamon-shell',
]

enabled_accent_colors = get_option('accent-colors')

accent_colors = {
  'default': {
    'accent': '#E95420',
  },
  'aqua': {
    'accent': '#28bca3',
  },
  'blue': {
    'accent': '#19B6EE',
  },
  'green': {
    'accent': '#0e8420',
  },
  'pink': {
    'accent': '#de3e80',
  },
  'purple': {
    'accent': '#a56de2',
  },
  'red': {
    'accent': '#c6262e',
  },
  'yellow': {
    'accent': '#f9c440',
  },
}

foreach component: components
  if not get_option(component)
    message('skip component ' + component)
    continue
  endif

  message('build component ' + component)
  subdir(component)

endforeach
