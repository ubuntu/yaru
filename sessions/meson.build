gnomeshell_mode_dir = join_paths(get_option('datadir'), 'gnome-shell', 'modes')

conf_data = configuration_data()
conf_data.set('ThemeName', meson.project_name())
conf_data.set('LowerCaseThemeName', meson.project_name().to_lower())

resource_path = gnomeshell_use_gresource ? join_paths('theme', meson.project_name(), '') : ''
conf_data.set('ThemeResourcePath', resource_path)

# NOTE: GNOME Shell only accept lowercase mode names.
configure_file(input : 'mode.json.in',
              output : meson.project_name().to_lower()+'.json',
              configuration : conf_data,
              install_dir: gnomeshell_mode_dir)

configure_file(input : 'THEMENAME.desktop.in',
              output : meson.project_name()+'.desktop',
              configuration : conf_data,
              install_dir: join_paths(get_option('datadir'), 'xsessions'))

configure_file(input : 'THEMENAME-wayland.desktop.in',
              output : meson.project_name()+'-wayland.desktop',
              configuration : conf_data,
              install_dir: join_paths(get_option('datadir'), 'wayland-sessions'))

configure_file(input : 'THEMENAME.gschema.override.in',
              output : '99_'+meson.project_name()+'.gschema.override',
              configuration : conf_data,
              install_dir: join_paths(get_option('datadir'), 'glib-2.0', 'schemas'))

meson.add_install_script('meson/install-dock-override', meson.project_name().to_lower())
meson.add_install_script('meson/compile-schemas')
