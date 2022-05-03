let g:rumpelstiltskin_cldr_source = expand('<sfile>:p:h:h') . '/cldr_source.txt'

" func! rumpelstiltskin#cldr_complete()
"   call fzf#vim#complete(fzf#wrap({
"         \ 'source': 'cat ' . g:rumpelstiltskin_cldr_source,
"         \ 'reducer': { text -> split(text[0], ' ... ')[0] },
"         \ 'window': { 'width': 0.6, 'height': 0.2, 'xoffset': 0.5 }
"         \ }))
" endfunc
