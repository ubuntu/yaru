flavours = []
foreach flavour: ['default', 'dark']
  if not get_option(flavour)
    message('skip flavour ' + flavour)
    continue
  endif
  flavours += flavour
endforeach


subdir('gtksourceview')
subdir('gtksourceview-5')
