# destination directory
install_dir = join_paths(gnomeshell_alt_themes_dir, meson.project_name() + '-dark', 'gnome-shell')

# generate .css files
theme_sources = files([
	'gnome-shell-high-contrast.scss',
  'gnome-shell.scss',
  'gnome-shell-sass/_colors.scss',
'gnome-shell-sass/_ubuntu-colors.scss',
  'gnome-shell-sass/_common.scss',
  'gnome-shell-sass/_drawing.scss',
  'gnome-shell-sass/_high-contrast-colors.scss',
  'gnome-shell-sass/_widgets.scss',
  'gnome-shell-sass/widgets/_a11y.scss',
  'gnome-shell-sass/widgets/_app-grid.scss',
  'gnome-shell-sass/widgets/_base.scss',
  'gnome-shell-sass/widgets/_buttons.scss',
  'gnome-shell-sass/widgets/_calendar.scss',
  'gnome-shell-sass/widgets/_check-box.scss',
  'gnome-shell-sass/widgets/_corner-ripple.scss',
  'gnome-shell-sass/widgets/_dash.scss',
  'gnome-shell-sass/widgets/_dialogs.scss',
  'gnome-shell-sass/widgets/_entries.scss',
  'gnome-shell-sass/widgets/_hotplug.scss',
  'gnome-shell-sass/widgets/_ibus-popup.scss',
  'gnome-shell-sass/widgets/_keyboard.scss',
  'gnome-shell-sass/widgets/_login-dialog.scss',
  'gnome-shell-sass/widgets/_looking-glass.scss',
  'gnome-shell-sass/widgets/_message-list.scss',
  'gnome-shell-sass/widgets/_misc.scss',
  'gnome-shell-sass/widgets/_network-dialog.scss',
  'gnome-shell-sass/widgets/_notifications.scss',
  'gnome-shell-sass/widgets/_osd.scss',
  'gnome-shell-sass/widgets/_overview.scss',
  'gnome-shell-sass/widgets/_panel.scss',
  'gnome-shell-sass/widgets/_popovers.scss',
  'gnome-shell-sass/widgets/_screen-shield.scss',
  'gnome-shell-sass/widgets/_scrollbars.scss',
  'gnome-shell-sass/widgets/_search-entry.scss',
  'gnome-shell-sass/widgets/_search-results.scss',
  'gnome-shell-sass/widgets/_slider.scss',
  'gnome-shell-sass/widgets/_switcher-popup.scss',
  'gnome-shell-sass/widgets/_switches.scss',
  'gnome-shell-sass/widgets/_tiled-previews.scss',
  'gnome-shell-sass/widgets/_window-picker.scss',
  'gnome-shell-sass/widgets/_workspace-switcher.scss',
  'gnome-shell-sass/widgets/_workspace-thumbnails.scss'
])

styles = [
  'gnome-shell-high-contrast',
  'gnome-shell'
]

theme_deps = []

sassc = find_program('sassc')
foreach style: styles
  theme_deps += custom_target('style-' + style + 'dark',
                              input: '@0@.scss'.format(style),
                              output: '@0@.css'.format(style),
                              command: [
                                sassc, '-a', '@INPUT@', '@OUTPUT@'
                              ],
                              install: true,
                              install_dir: install_dir,
                              depend_files: theme_sources)
endforeach

gresource_xml = files('data/gnome-shell-theme.gresource.xml')[0]
gresource_files_path = '../'
data_sources = run_command(
  gresources_xml_parser, [
    join_paths(meson.source_root(), '@0@'.format(gresource_xml)),
    '--path',
      gresource_files_path,
    '--filter', '*.css',
  ],
).stdout().strip().split('\n')

assert(data_sources.length() > 0 and data_sources[0] != '', 'No data sources found')

# static files to copy
data_sources += [
  '../checkbox-focused-dark.svg',
  '../checkbox-off-focused-dark.svg',
  '../checkbox-off-dark.svg',
  '../checkbox-dark.svg',
  '../key-hide-dark.svg',
  '../key-layout-dark.svg',
  '../key-shift-dark.svg',
  '../lockscreen-gradient.svg',
  '../logged-in-indicator.svg',
  '../noise-texture.png',
  '../pad-osd.css',
  '../running-indicator.svg',
  '../source-button-border.svg',
  '../summary-counter.svg',
  '../toggle-off-intl.svg',
  '../toggle-on-intl.svg',
  '../ws-switch-arrow-down.svg',
  '../ws-switch-arrow-up.svg',
]

# install static data files
install_data(data_sources, install_dir: install_dir)
