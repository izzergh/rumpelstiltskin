if exists('g:loaded_rumpelstiltskin')
  finish
endif
" Start below this line

func! rumpelstiltskin#cldr_complete()
  call fzf#vim#complete(fzf#wrap({
        \ 'source': 'cat ' . g:rumpelstiltskin_cldr_source,
        \ 'reducer': { text -> split(text[0], ' ... ')[0] },
        \ 'window': { 'width': 0.6, 'height': 0.2, 'xoffset': 0.5 }
        \ }))
  " no return means it returns 0, which inserts the literal 0
  return ''
endfunc

inoremap <expr> : rumpelstiltskin#cldr_complete()

" Finish above this line
let g:loaded_rumpelstiltskin = 1
