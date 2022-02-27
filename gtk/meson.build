flavours = []
foreach flavour: ['default', 'dark', 'mate', 'mate-dark']
  if not get_option(flavour)
    message('skip flavour ' + flavour)
    continue
  endif
  flavours += flavour
endforeach


subdir('src')
