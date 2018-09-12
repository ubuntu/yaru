sassc = find_program('sassc')

gtk3_dir = join_paths(theme_dir, 'gtk-3.0')
gtk3_asset_dir = join_paths(gtk3_dir, 'assets')

# Dependencies of the files that need to be compiled
gtk3_scss_dependencies = [
  '../../light/gtk-3.0/_colors-public.scss',
  '../../light/gtk-3.0/_ubuntu-colors.scss',
  '../../light/gtk-3.0/_colors.scss',
  '../../light/gtk-3.0/_common.scss',
  '../../light/gtk-3.0/_apps.scss',
  '../../light/gtk-3.0/_drawing.scss',
]

# generate .css files
# and install to themes/THEMENAME-dark/gtk-3.0
custom_target('gtk3_dark',
    input: '../../light/gtk-3.0/gtk-dark.scss',
    output: 'gtk.css',
    depend_files: files(gtk3_scss_dependencies),
    command: [sassc, '-a', '@INPUT@', '@OUTPUT@'],
    build_by_default: true,
    install: true,
    install_dir: gtk3_dir,
)

# assets are just a symlink to the light themes as they are not modified
meson.add_install_script('sh', '-c', 'ln -sf ../../'+meson.project_name()+'/gtk-3.0/assets $MESON_INSTALL_DESTDIR_PREFIX/'+gtk3_asset_dir)
