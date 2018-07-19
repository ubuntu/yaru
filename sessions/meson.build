gnomeshell_mode_dir = join_paths(get_option('datadir'), 'gnome-shell', 'modes')

replace_name = find_program('../build-helpers/replace-name')
custom_target('shell-mode',
              input: 'mode.json.in',
              output: meson.project_name()+'.json',
              command: [
                replace_name, '@INPUT@', '@OUTPUT@', 'THEMENAME', meson.project_name()
              ],
              build_by_default: true,
              install: true,
              install_dir: gnomeshell_mode_dir)

custom_target('desktop-xsession',
              input: 'THEMENAME.desktop.in',
              output: meson.project_name()+'.desktop',
              command: [
                replace_name, '@INPUT@', '@OUTPUT@', 'THEMENAME', meson.project_name()
              ],
              build_by_default: true,
              install: true,
              install_dir: join_paths(get_option('datadir'), 'xsessions'))
custom_target('desktop-waylandsession',
              input: 'THEMENAME-wayland.desktop.in',
              output: meson.project_name()+'-wayland.desktop',
              command: [
                replace_name, '@INPUT@', '@OUTPUT@', 'THEMENAME', meson.project_name()
              ],
              build_by_default: true,
              install: true,
              install_dir: join_paths(get_option('datadir'), 'wayland-sessions'))

gsettings_override_dir = join_paths(get_option('datadir'), 'glib-2.0', 'schemas')
custom_target('gsettings-override',
              input: 'THEMENAME.gschema.override.in',
              output: '99_'+meson.project_name()+'.gschema.override',
              command: [
                replace_name, '@INPUT@', '@OUTPUT@', 'THEMENAME', meson.project_name()
              ],
              build_by_default: true,
              install: true,
              install_dir: gsettings_override_dir)

meson.add_install_script('meson/compile-schemas')
