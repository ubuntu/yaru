theme_dir = join_paths(get_option('datadir'), 'themes', meson.project_name())

replace_name = find_program('../build-helpers/replace-name')
custom_target('gtk-index.theme',
              input: 'src/index.theme.in',
              output: 'index.theme',
              command: [
                replace_name, '@INPUT@', '@OUTPUT@', 'THEMENAME', meson.project_name()
              ],
              build_by_default: true,
              install: true,
              install_dir: theme_dir)

sassc = find_program('sassc')

subdir('src')
