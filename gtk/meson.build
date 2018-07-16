theme_dir = join_paths(get_option('datadir'), 'themes', meson.project_name())

generate_theme = find_program('../meson-helpers/replace_theme_name.py')
custom_target('gtk-index.theme',
              input: 'src/index.theme.in',
              output: 'index.theme',
              command: [
                generate_theme, '@INPUT@', '@OUTPUT@', meson.project_name()
              ],
              build_by_default: true,
              install: true,
              install_dir: theme_dir)

sassc = find_program('sassc')

subdir('src')
