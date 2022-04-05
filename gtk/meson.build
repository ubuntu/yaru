flavours = []

available_flavours = [
  'default',
  'dark',
  'mate',
  'mate-dark',
]

foreach flavour: available_flavours
  if not get_option(flavour)
    message('skip flavour ' + flavour)
    continue
  endif
  flavours += flavour
endforeach

foreach accent: enabled_accent_colors
  if enabled_accent_colors.contains(accent)
    flavours += (get_option('default') ? [accent] : [])
    flavours += (get_option('dark') ? [ accent + '-dark' ] : [])
  endif
endforeach


subdir('src')
