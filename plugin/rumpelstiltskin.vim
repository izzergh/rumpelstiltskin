if exists('g:loaded_rumpelstiltskin')
  finish
endif
" Start below this line

" CLDR (unicode with text-to-speech names)
" Normal mode
if exists('g:rumpelstiltskin#cldr_n')
  exec 'nmap ' . g:rumpelstiltskin#cldr_n . ' :rumpelstiltskin#cldr()l'
else
  nmap <Leader>: :call rumpelstiltskin#cldr()<CR>
endif

" Insert mode
if exists('g:rumpelstiltskin_cldr_i')
  exec 'imap <expr> ' . g:rumpelstiltskin_cldr_i . ' rumpelstiltskin#cldr_complete()'
else
  imap <expr> <C-X>: rumpelstiltskin#cldr_complete()
endif

" Finish above this line
let g:loaded_rumpelstiltskin = 1
