gnome = import('gnome')
sassc = find_program('sassc')

unity_dir = join_paths(theme_dir, 'unity')

unity_assets = [
  'close_focused_normal.svg',
  'close_focused_prelight.svg',
  'close_focused_pressed.svg',
  'close.svg',
  'close_unfocused_prelight.svg',
  'close_unfocused_pressed.svg',
  'close_unfocused.svg',
  'maximize_focused_normal.svg',
  'maximize_focused_prelight.svg',
  'maximize_focused_pressed.svg',
  'maximize.svg',
  'maximize_unfocused_prelight.svg',
  'maximize_unfocused_pressed.svg',
  'maximize_unfocused.svg',
  'minimize_focused_normal.svg',
  'minimize_focused_prelight.svg',
  'minimize_focused_pressed.svg',
  'minimize.svg',
  'minimize_unfocused_prelight.svg',
  'minimize_unfocused_pressed.svg',
  'minimize_unfocused.svg',
  'unmaximize_focused_normal.svg',
  'unmaximize_focused_prelight.svg',
  'unmaximize_focused_pressed.svg',
  'unmaximize.svg',
  'unmaximize_unfocused_prelight.svg',
  'unmaximize_unfocused_pressed.svg',
  'unmaximize_unfocused.svg',
]

# Install stub CSS files
install_data(unity_assets, install_dir: unity_dir)
