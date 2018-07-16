gnomeshell_dir = join_paths(get_option('datadir'), 'gnome-shell')
gnomeshell_mode_dir = join_paths(gnomeshell_dir, 'modes')
gnomeshell_theme_dir = join_paths(gnomeshell_dir, 'theme')
sassc = find_program('sassc')

replace_name = find_program('../build-helpers/replace_name.py')
custom_target('shell-mode',
              input: 'mode.json.in',
              output: meson.project_name()+'.json',
              command: [
                replace_name, '@INPUT@', '@OUTPUT@', 'THEMENAME', meson.project_name()
              ],
              build_by_default: true,
              install: true,
              install_dir: gnomeshell_mode_dir)

subdir('src')
