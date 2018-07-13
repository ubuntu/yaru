theme_dir = join_paths(gtk_theme_dir, meson.project_name())

generate_theme = find_program('meson/generate_theme.py')
custom_target('gtk-index.theme',
              input: 'index.theme.in',
              output: 'index.theme',
              command: [
                generate_theme, '@INPUT@', '@OUTPUT@', meson.project_name()
              ],
              build_by_default: true,
              install: true,
              install_dir: theme_dir)

subdir('gtk-2.0')
subdir('gtk-3.0')
