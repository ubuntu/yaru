theme_dir = join_paths(get_option('prefix'), 'share', 'sounds', meson.project_name())

replace_name = find_program('../build-helpers/replace-name')
custom_target('sound-index.theme',
              input: 'src/index.theme.in',
              output: 'index.theme',
              command: [
                replace_name, '@INPUT@', '@OUTPUT@', 'THEMENAME', meson.project_name()
              ],
              build_by_default: true,
              install: true,
              install_dir: theme_dir)

install_subdir('src/stereo', install_dir: theme_dir)
