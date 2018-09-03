theme_dir = join_paths(get_option('prefix'), 'share/icons', meson.project_name())

install_subdir('Suru',
    install_dir: theme_dir,
    strip_directory: true,
    exclude_files: ['index.theme', 'cursor.theme'],
)

replace_name = find_program('../build-helpers/replace-name')
themes_f = [
  'cursor.theme',
  'index.theme',
]

theme_deps = []

foreach theme: themes_f
  theme_deps += custom_target(theme,
                              input: 'Suru/@0@'.format(theme),
                              output: '@0@'.format(theme),
                              command: [
                                replace_name, '@INPUT@', '@OUTPUT@', 'Suru', meson.project_name()
                              ],
                              build_by_default: true,
                              install: true,
                              install_dir: theme_dir)
endforeach

meson.add_install_script('meson/post_install.py', meson.project_name())
