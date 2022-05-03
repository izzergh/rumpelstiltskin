if exists('g:loaded_rumpelstiltskin')
  finish
endif
" Start below this line
if exists('g:rumpelstiltskin_cldr_keybind')
  exec 'imap <expr> ' . g:rumpelstiltskin_cldr_keybind . ' rumpelstiltskin#cldr_complete()'
else
  imap <expr> <C-X>: rumpelstiltskin#cldr_complete()
endif

" Finish above this line
let g:loaded_rumpelstiltskin = 1
