if exists('g:loaded_rumpelstiltskin')
  finish
endif
" Start below this line

" CLDR (unicode with text-to-speech names)
" Normal mode
command! RumpelCLDR :call rumpelstiltskin#cldr()

" Insert mode (currently requires restart to configure)
if exists('g:rumpelstiltskin_cldr_i')
  exec 'imap <expr> ' . g:rumpelstiltskin_cldr_i . ' rumpelstiltskin#cldr_complete()'
else
  imap <expr> <C-X>: rumpelstiltskin#cldr_complete()
endif

" Finish above this line
let g:loaded_rumpelstiltskin = 1
