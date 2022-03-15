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

subdir('common')

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

foreach component: components
  if not get_option(component)
    message('skip component ' + component)
    continue
  endif

  message('build component ' + component)
  subdir(component)

endforeach
