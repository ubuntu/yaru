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
]

gtk3_assets = [
  'assets/bullet-symbolic.svg',
  'assets/bullet-symbolic.symbolic.png',
  'assets/checkbox-active-selectionmode@2.png',
  'assets/checkbox-active-selectionmode.png',
  'assets/checkbox-backdrop-selectionmode@2.png',
  'assets/checkbox-backdrop-selectionmode.png',
  'assets/checkbox-checked-active-selectionmode@2.png',
  'assets/checkbox-checked-active-selectionmode.png',
  'assets/checkbox-checked-backdrop-selectionmode@2.png',
  'assets/checkbox-checked-backdrop-selectionmode.png',
  'assets/checkbox-checked-hover-selectionmode@2.png',
  'assets/checkbox-checked-hover-selectionmode.png',
  'assets/checkbox-checked-selectionmode@2.png',
  'assets/checkbox-checked-selectionmode.png',
  'assets/checkbox-hover-selectionmode@2.png',
  'assets/checkbox-hover-selectionmode.png',
  'assets/checkbox-selectionmode@2.png',
  'assets/checkbox-selectionmode.png',
  'assets/check-symbolic.svg',
  'assets/check-symbolic.symbolic.png',
  'assets/dash-symbolic.svg',
  'assets/dash-symbolic.symbolic.png',
  'assets/slider-horz-scale-has-marks-above@2.png',
  'assets/slider-horz-scale-has-marks-above-active@2.png',
  'assets/slider-horz-scale-has-marks-above-active.png',
  'assets/slider-horz-scale-has-marks-above-backdrop@2.png',
  'assets/slider-horz-scale-has-marks-above-backdrop-insensitive@2.png',
  'assets/slider-horz-scale-has-marks-above-backdrop-insensitive.png',
  'assets/slider-horz-scale-has-marks-above-backdrop.png',
  'assets/slider-horz-scale-has-marks-above-hover@2.png',
  'assets/slider-horz-scale-has-marks-above-hover.png',
  'assets/slider-horz-scale-has-marks-above-insensitive@2.png',
  'assets/slider-horz-scale-has-marks-above-insensitive.png',
  'assets/slider-horz-scale-has-marks-above.png',
  'assets/slider-horz-scale-has-marks-below@2.png',
  'assets/slider-horz-scale-has-marks-below-active@2.png',
  'assets/slider-horz-scale-has-marks-below-active.png',
  'assets/slider-horz-scale-has-marks-below-backdrop@2.png',
  'assets/slider-horz-scale-has-marks-below-backdrop-insensitive@2.png',
  'assets/slider-horz-scale-has-marks-below-backdrop-insensitive.png',
  'assets/slider-horz-scale-has-marks-below-backdrop.png',
  'assets/slider-horz-scale-has-marks-below-hover@2.png',
  'assets/slider-horz-scale-has-marks-below-hover.png',
  'assets/slider-horz-scale-has-marks-below-insensitive@2.png',
  'assets/slider-horz-scale-has-marks-below-insensitive.png',
  'assets/slider-horz-scale-has-marks-below.png',
  'assets/slider-vert-scale-has-marks-above@2.png',
  'assets/slider-vert-scale-has-marks-above-active@2.png',
  'assets/slider-vert-scale-has-marks-above-active.png',
  'assets/slider-vert-scale-has-marks-above-backdrop@2.png',
  'assets/slider-vert-scale-has-marks-above-backdrop-insensitive@2.png',
  'assets/slider-vert-scale-has-marks-above-backdrop-insensitive.png',
  'assets/slider-vert-scale-has-marks-above-backdrop.png',
  'assets/slider-vert-scale-has-marks-above-hover@2.png',
  'assets/slider-vert-scale-has-marks-above-hover.png',
  'assets/slider-vert-scale-has-marks-above-insensitive@2.png',
  'assets/slider-vert-scale-has-marks-above-insensitive.png',
  'assets/slider-vert-scale-has-marks-above.png',
  'assets/slider-vert-scale-has-marks-below@2.png',
  'assets/slider-vert-scale-has-marks-below-active@2.png',
  'assets/slider-vert-scale-has-marks-below-active.png',
  'assets/slider-vert-scale-has-marks-below-backdrop@2.png',
  'assets/slider-vert-scale-has-marks-below-backdrop-insensitive@2.png',
  'assets/slider-vert-scale-has-marks-below-backdrop-insensitive.png',
  'assets/slider-vert-scale-has-marks-below-backdrop.png',
  'assets/slider-vert-scale-has-marks-below-hover@2.png',
  'assets/slider-vert-scale-has-marks-below-hover.png',
  'assets/slider-vert-scale-has-marks-below-insensitive@2.png',
  'assets/slider-vert-scale-has-marks-below-insensitive.png',
  'assets/slider-vert-scale-has-marks-below.png',
  'assets/text-select-end@2.png',
  'assets/text-select-end-active@2.png',
  'assets/text-select-end-active.png',
  'assets/text-select-end-hover@2.png',
  'assets/text-select-end-hover.png',
  'assets/text-select-end.png',
  'assets/text-select-start@2.png',
  'assets/text-select-start-active@2.png',
  'assets/text-select-start-active.png',
  'assets/text-select-start-hover@2.png',
  'assets/text-select-start-hover.png',
  'assets/text-select-start.png',
  'assets/titlebutton-hover.png',
  'assets/titlebutton-hover@2.png',
  'assets/titlebutton-active.png',
  'assets/titlebutton-active@2.png',
  'assets/titlebutton-selection-mode-hover.png',
  'assets/titlebutton-selection-mode-hover@2.png',
  'assets/titlebutton-selection-mode-active.png',
  'assets/titlebutton-selection-mode-active@2.png',
  'assets/close-button.png',
  'assets/close-button@2.png',
  'assets/close-button-hover.png',
  'assets/close-button-hover@2.png',
  'assets/close-button-active.png',
  'assets/close-button-active@2.png',
  'assets/close-button-backdrop.png',
  'assets/close-button-backdrop@2.png',
  'assets/close-button-selection-mode.png',
  'assets/close-button-selection-mode@2.png'
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
