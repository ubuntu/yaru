flavours = []
foreach flavour: ['default', 'dark', 'aqua', 'aqua-dark', 'blue', 'blue-dark', 'green', 'green-dark', 'mate', 'mate-dark', 'pink', 'pink-dark', 'purple', 'purple-dark', 'red', 'red-dark', 'yellow', 'yellow-dark']
  if not get_option(flavour)
    message('skip flavour ' + flavour)
    continue
  endif
  flavours += flavour
endforeach


subdir('src')
