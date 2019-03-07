# destination directory
install_dir = join_paths(gnomeshell_theme_dir, meson.project_name())

# generate .css files
theme_sources = files([
  'gnome-shell-high-contrast.scss',
  'gnome-shell.scss',
  'gnome-shell-sass/_colors.scss',
  'gnome-shell-sass/_common.scss',
  'gnome-shell-sass/_dock.scss',
  'gnome-shell-sass/_drawing.scss',
  'gnome-shell-sass/_high-contrast-colors.scss',
  'gnome-shell-sass/_ubuntu-colors.scss',
])

styles = [
  'gnome-shell-high-contrast',
  'gnome-shell'
]

theme_deps = []

sassc = find_program('sassc')
foreach style: styles
  theme_deps += custom_target('style-' + style,
                              input: '@0@.scss'.format(style),
                              output: '@0@.css'.format(style),
                              command: [
                                sassc, '-a', '@INPUT@', '@OUTPUT@'
                              ],
                              install: true,
                              install_dir: install_dir,
                              depend_files: theme_sources)
endforeach

# static files to copy
data_sources = [
  'calendar-today.svg',
  'checkbox-focused.svg',
  'checkbox-off-focused.svg',
  'checkbox-off.svg',
  'checkbox.svg',
  'close.svg',
  'dash-placeholder.svg',
  'dots.svg',
  'filter-selected-ltr.svg',
  'filter-selected-rtl.svg',
  'logged-in-indicator.svg',
  'lockscreen-gradient.svg',
  'message-indicator-symbolic.svg',
  'no-events.svg',
  'noise-texture.png',
  'no-notifications.svg',
  'pad-osd.css',
  'process-working.svg',
  'running-indicator.svg',
  'source-button-border.svg',
  'summary-counter.svg',
  'toggle-off-hc.svg',
  'toggle-off.svg',
  'toggle-on-hc.svg',
  'toggle-on.svg',
  'ubuntu-logo-icon.svg',
  'ws-switch-arrow-down.svg',
  'ws-switch-arrow-up.svg',
  'ubuntu-appgrid-icon.svg',
  'key-enter.svg',
  'key-hide.svg',
  'key-layout.svg',
  'key-shift.svg',
  'key-shift-latched-uppercase.svg',
  'key-shift-uppercase.svg'
]

# install static data files
install_data(data_sources, install_dir: install_dir)
