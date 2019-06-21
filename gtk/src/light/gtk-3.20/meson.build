gnome = import('gnome')
sassc = find_program('sassc')

gtk3_dir = join_paths(theme_dir, 'gtk-3.20')

# theme sources .scss files
gtk3_scss_sources = [
  'gtk-dark',   # applications requesting dark theme when using the light one.
  'gtk',
]


# Dependencies of the files that need to be compiled
gtk3_scss_dependencies = [
  '_colors-public.scss',
  '_ubuntu-colors.scss',
  '_colors.scss',
  '_common.scss',
  '_apps.scss',
  '_drawing.scss',
  '_headerbar.scss',
]

gtk3_assets = [
  'assets/bullet-symbolic.svg',
  'assets/bullet-symbolic.symbolic.png',
  'assets/check-symbolic.svg',
  'assets/check-symbolic.symbolic.png',
  'assets/dash-symbolic.svg',
  'assets/dash-symbolic.symbolic.png',
  'assets/slider-horz-scale-has-marks-above@2.png',
  'assets/slider-horz-scale-has-marks-above-active@2.png',
  'assets/slider-horz-scale-has-marks-above-active-dark@2.png',
  'assets/slider-horz-scale-has-marks-above-active-dark.png',
  'assets/slider-horz-scale-has-marks-above-active.png',
  'assets/slider-horz-scale-has-marks-above-backdrop@2.png',
  'assets/slider-horz-scale-has-marks-above-backdrop-dark@2.png',
  'assets/slider-horz-scale-has-marks-above-backdrop-dark.png',
  'assets/slider-horz-scale-has-marks-above-backdrop-insensitive@2.png',
  'assets/slider-horz-scale-has-marks-above-backdrop-insensitive-dark@2.png',
  'assets/slider-horz-scale-has-marks-above-backdrop-insensitive-dark.png',
  'assets/slider-horz-scale-has-marks-above-backdrop-insensitive.png',
  'assets/slider-horz-scale-has-marks-above-backdrop.png',
  'assets/slider-horz-scale-has-marks-above-dark@2.png',
  'assets/slider-horz-scale-has-marks-above-dark.png',
  'assets/slider-horz-scale-has-marks-above-hover@2.png',
  'assets/slider-horz-scale-has-marks-above-hover-dark@2.png',
  'assets/slider-horz-scale-has-marks-above-hover-dark.png',
  'assets/slider-horz-scale-has-marks-above-hover.png',
  'assets/slider-horz-scale-has-marks-above-insensitive@2.png',
  'assets/slider-horz-scale-has-marks-above-insensitive-dark@2.png',
  'assets/slider-horz-scale-has-marks-above-insensitive-dark.png',
  'assets/slider-horz-scale-has-marks-above-insensitive.png',
  'assets/slider-horz-scale-has-marks-above.png',
  'assets/slider-horz-scale-has-marks-below@2.png',
  'assets/slider-horz-scale-has-marks-below-active@2.png',
  'assets/slider-horz-scale-has-marks-below-active-dark@2.png',
  'assets/slider-horz-scale-has-marks-below-active-dark.png',
  'assets/slider-horz-scale-has-marks-below-active.png',
  'assets/slider-horz-scale-has-marks-below-backdrop@2.png',
  'assets/slider-horz-scale-has-marks-below-backdrop-dark@2.png',
  'assets/slider-horz-scale-has-marks-below-backdrop-dark.png',
  'assets/slider-horz-scale-has-marks-below-backdrop-insensitive@2.png',
  'assets/slider-horz-scale-has-marks-below-backdrop-insensitive-dark@2.png',
  'assets/slider-horz-scale-has-marks-below-backdrop-insensitive-dark.png',
  'assets/slider-horz-scale-has-marks-below-backdrop-insensitive.png',
  'assets/slider-horz-scale-has-marks-below-backdrop.png',
  'assets/slider-horz-scale-has-marks-below-dark@2.png',
  'assets/slider-horz-scale-has-marks-below-dark.png',
  'assets/slider-horz-scale-has-marks-below-hover@2.png',
  'assets/slider-horz-scale-has-marks-below-hover-dark@2.png',
  'assets/slider-horz-scale-has-marks-below-hover-dark.png',
  'assets/slider-horz-scale-has-marks-below-hover.png',
  'assets/slider-horz-scale-has-marks-below-insensitive@2.png',
  'assets/slider-horz-scale-has-marks-below-insensitive-dark@2.png',
  'assets/slider-horz-scale-has-marks-below-insensitive-dark.png',
  'assets/slider-horz-scale-has-marks-below-insensitive.png',
  'assets/slider-horz-scale-has-marks-below.png',
  'assets/slider-vert-scale-has-marks-above@2.png',
  'assets/slider-vert-scale-has-marks-above-active@2.png',
  'assets/slider-vert-scale-has-marks-above-active-dark@2.png',
  'assets/slider-vert-scale-has-marks-above-active-dark.png',
  'assets/slider-vert-scale-has-marks-above-active.png',
  'assets/slider-vert-scale-has-marks-above-backdrop@2.png',
  'assets/slider-vert-scale-has-marks-above-backdrop-dark@2.png',
  'assets/slider-vert-scale-has-marks-above-backdrop-dark.png',
  'assets/slider-vert-scale-has-marks-above-backdrop-insensitive@2.png',
  'assets/slider-vert-scale-has-marks-above-backdrop-insensitive-dark@2.png',
  'assets/slider-vert-scale-has-marks-above-backdrop-insensitive-dark.png',
  'assets/slider-vert-scale-has-marks-above-backdrop-insensitive.png',
  'assets/slider-vert-scale-has-marks-above-backdrop.png',
  'assets/slider-vert-scale-has-marks-above-dark@2.png',
  'assets/slider-vert-scale-has-marks-above-dark.png',
  'assets/slider-vert-scale-has-marks-above-hover@2.png',
  'assets/slider-vert-scale-has-marks-above-hover-dark@2.png',
  'assets/slider-vert-scale-has-marks-above-hover-dark.png',
  'assets/slider-vert-scale-has-marks-above-hover.png',
  'assets/slider-vert-scale-has-marks-above-insensitive@2.png',
  'assets/slider-vert-scale-has-marks-above-insensitive-dark@2.png',
  'assets/slider-vert-scale-has-marks-above-insensitive-dark.png',
  'assets/slider-vert-scale-has-marks-above-insensitive.png',
  'assets/slider-vert-scale-has-marks-above.png',
  'assets/slider-vert-scale-has-marks-below@2.png',
  'assets/slider-vert-scale-has-marks-below-active@2.png',
  'assets/slider-vert-scale-has-marks-below-active-dark@2.png',
  'assets/slider-vert-scale-has-marks-below-active-dark.png',
  'assets/slider-vert-scale-has-marks-below-active.png',
  'assets/slider-vert-scale-has-marks-below-backdrop@2.png',
  'assets/slider-vert-scale-has-marks-below-backdrop-dark@2.png',
  'assets/slider-vert-scale-has-marks-below-backdrop-dark.png',
  'assets/slider-vert-scale-has-marks-below-backdrop-insensitive@2.png',
  'assets/slider-vert-scale-has-marks-below-backdrop-insensitive-dark@2.png',
  'assets/slider-vert-scale-has-marks-below-backdrop-insensitive-dark.png',
  'assets/slider-vert-scale-has-marks-below-backdrop-insensitive.png',
  'assets/slider-vert-scale-has-marks-below-backdrop.png',
  'assets/slider-vert-scale-has-marks-below-dark@2.png',
  'assets/slider-vert-scale-has-marks-below-dark.png',
  'assets/slider-vert-scale-has-marks-below-hover@2.png',
  'assets/slider-vert-scale-has-marks-below-hover-dark@2.png',
  'assets/slider-vert-scale-has-marks-below-hover-dark.png',
  'assets/slider-vert-scale-has-marks-below-hover.png',
  'assets/slider-vert-scale-has-marks-below-insensitive@2.png',
  'assets/slider-vert-scale-has-marks-below-insensitive-dark@2.png',
  'assets/slider-vert-scale-has-marks-below-insensitive-dark.png',
  'assets/slider-vert-scale-has-marks-below-insensitive.png',
  'assets/slider-vert-scale-has-marks-below.png',
  'assets/text-select-end@2.png',
  'assets/text-select-end-active@2.png',
  'assets/text-select-end-active-dark@2.png',
  'assets/text-select-end-active-dark.png',
  'assets/text-select-end-active.png',
  'assets/text-select-end-dark@2.png',
  'assets/text-select-end-dark.png',
  'assets/text-select-end-hover@2.png',
  'assets/text-select-end-hover-dark@2.png',
  'assets/text-select-end-hover-dark.png',
  'assets/text-select-end-hover.png',
  'assets/text-select-end.png',
  'assets/text-select-start@2.png',
  'assets/text-select-start-active@2.png',
  'assets/text-select-start-active-dark@2.png',
  'assets/text-select-start-active-dark.png',
  'assets/text-select-start-active.png',
  'assets/text-select-start-dark@2.png',
  'assets/text-select-start-dark.png',
  'assets/text-select-start-hover@2.png',
  'assets/text-select-start-hover-dark@2.png',
  'assets/text-select-start-hover-dark.png',
  'assets/text-select-start-hover.png',
  'assets/text-select-start.png',
]

# generate .css files
# and install to themes/THEMENAME/gtk-3.20
generated_css = []
foreach f : gtk3_scss_sources
  generated_css += custom_target('light-gtk-3.20-' + f + '-generated.css',
      input: f + '.scss',
      output: f + '-generated.css',
      depend_files: files(gtk3_scss_dependencies),
      command: [sassc, '-a', '@INPUT@', '@OUTPUT@'],
  )
endforeach

# Bundle CSS and assets into gtk.gresource
asset_xml = []
foreach f : gtk3_assets
  asset_xml += '<file>@0@</file>'.format(f)
endforeach
conf_data = configuration_data()
conf_data.set('ASSETS', '\n'.join(asset_xml))
gresource_xml = configure_file(
  input: 'gtk.gresource.xml.in',
  output: 'gtk.gresource.xml',
  configuration: conf_data)

gnome.compile_resources('gtk', gresource_xml,
  gresource_bundle: true,
  dependencies: generated_css,
  install: true,
  install_dir: gtk3_dir,
)

# Install stub CSS files
install_data(['gtk.css', 'gtk-dark.css'], install_dir: gtk3_dir)
