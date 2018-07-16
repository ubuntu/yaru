theme_dir = join_paths(get_option('prefix'), 'share', 'sounds', meson.project_name())

generate_theme = find_program('meson/generate_theme.py')
custom_target('sound-index.theme',
              input: 'src/index.theme.in',
              output: 'index.theme',
              command: [
                generate_theme, '@INPUT@', '@OUTPUT@', meson.project_name()
              ],
              build_by_default: true,
              install: true,
              install_dir: theme_dir)

install_subdir('src/stereo', install_dir: theme_dir)
