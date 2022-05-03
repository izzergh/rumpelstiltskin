if exists('g:loaded_rumpelstiltskin')
  finish
endif
" Start below this line
let g:rumpelstiltskin_cldr_source = expand('<sfile>:p:h:h') . '/cldr_source.txt'

func! rumpelstiltskin#cldr_complete()
  call fzf#vim#complete(fzf#wrap({
        \ 'source': 'cat ' . g:rumpelstiltskin_cldr_source,
        \ 'reducer': { text -> split(text[0], ' ... ')[0] },
        \ 'window': { 'width': 0.6, 'height': 0.2, 'xoffset': 0.5 }
        \ }))
  " no return means it returns 0, which inserts the literal 0
  return ''
endfunc

if exists('g:cldr_keybind')
  exec 'inoremap <expr> ' . g:cldr_keybind . ' rumpelstiltskin#cldr_complete()'
else
  inoremap <expr> <C-X>: rumpelstiltskin#cldr_complete()
endif

" Finish above this line
let g:loaded_rumpelstiltskin = 1
