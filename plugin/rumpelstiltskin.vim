if exists('g:loaded_rumpelstiltskin')
  finish
endif
" Start below this line

" All unicode
" Normal mode
command! RumpelBase :call rumpelstiltskin#base()

" Insert mode (current requires restart to configure)
if exists('g:rumpelstiltskin_base_i')
  exec 'imap <expr> ' . g:rumpelstiltskin_base_i . ' rumpelstiltskin#base_complete()'
else
  imap <expr> <C-X>u rumpelstiltskin#base_complete()
endif

" Emoji
" Normal mode
command! RumpelEmoji :call rumpelstiltskin#emoji()

" Insert mode (current requires restart to configure)
if exists('g:rumpelstiltskin_emoji_i')
  exec 'imap <expr> ' . g:rumpelstiltskin_emoji_i . ' rumpelstiltskin#emoji_complete()'
else
  imap <expr> <C-X>e rumpelstiltskin#emoji_complete()
endif

" Finish above this line
let g:loaded_rumpelstiltskin = 1
