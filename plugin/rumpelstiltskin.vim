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

" All unicode
" Normal mode
command! RumpelFull :call rumpelstiltskin#full()

" Insert mode (current requires restart to configure)
if exists('g:rumpelstiltskin_full_i')
  exec 'imap <expr> ' . g:rumpelstiltskin_full_i . ' rumpelstiltskin#full_complete()'
else
  imap <expr> <C-X>u rumpelstiltskin#full_complete()
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
