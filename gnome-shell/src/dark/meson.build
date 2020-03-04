# This is an hack we need to remove once meson fixes this issue:
#  https://github.com/mesonbuild/meson/issues/2320

custom_target('style-css-@0@'.format(variant),
  input: style_css,
  output: output_styles,
  command: [
    gnomeshell_copy_and_rename,
    '--input', '@INPUT@',
    '--output', '@OUTPUT@',
  ],
  install: true,
  install_dir: install_dir,
)
