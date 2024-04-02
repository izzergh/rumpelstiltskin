if exists('g:loaded_rumpelstiltskin')
  finish
endif
" Start below this line

" Default command
command! Rumpel :call rumpelstiltskin#base()

" All unicode
" Normal mode
command! RumpelBase :call rumpelstiltskin#base()

" Insert mode
imap <expr> <C-X>u rumpelstiltskin#base_complete()

" Emoji
" Normal mode
command! RumpelEmoji :call rumpelstiltskin#emoji()

" Insert mode
imap <expr> <C-X>e rumpelstiltskin#emoji_complete()

" Single-character emoji only
" Normal mode
command! RumpelAtomicEmoji :call rumpelstiltskin#atomic_emoji()

" Insert mode
imap <expr> <C-X>a rumpelstiltskin#atomic_emoji_complete()

" Finish above this line
let g:loaded_rumpelstiltskin = 1
