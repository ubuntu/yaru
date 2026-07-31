gnomeshell_mode_dir = get_option('datadir') / 'gnome-shell' / 'modes'

conf_data = configuration_data()
conf_data.set('ThemeName', meson.project_name())
conf_data.set('LowerCaseThemeName', meson.project_name().to_lower())
conf_data.set('ThemeResourcePath', gnomeshell_use_gresource ? 'theme' / meson.project_name() / '' : '')

# NOTE: GNOME Shell only accepts lowercase mode names.
configure_file(
  input: 'mode.json.in',
  output: meson.project_name().to_lower() + '.json',
  configuration: conf_data,
  install_dir: gnomeshell_mode_dir,
)

configure_file(
  input: 'THEMENAME.desktop.in',
  output: meson.project_name() + '.desktop',
  configuration: conf_data,
  install_dir: get_option('datadir') / 'wayland-sessions',
)

configure_file(
  input: 'THEMENAME.gschema.override.in',
  output: '99_' + meson.project_name() + '.gschema.override',
  configuration: conf_data,
  install_dir: get_option('datadir') / 'glib-2.0' / 'schemas',
)

# Empty CSS placeholder so ubuntu-dock defers styling to the shell theme CSS.
configure_file(
  output: meson.project_name().to_lower() + '.css',
  configuration: configuration_data(),
  install_dir: get_option('datadir') / 'gnome-shell' / 'extensions' / 'ubuntu-dock@ubuntu.com',
)
