let g:rumpelstiltskin_cldr_source = expand('<sfile>:p:h:h') . '/cldr_source.txt'
let g:rumpelstiltskin_full_source = expand('<sfile>:p:h:h') . '/full_source.txt'

" sink function
function! s:insert_sink(result)
  let l:char = a:result[0]->split(' ... ')[0]
  let l:line = getline('.')
  call setline(
        \ '.',
        \ strpart(
        \   l:line,
        \   0,
        \   col('.') - 1) . l:char . strpart(l:line, col('.') - 1)
        \ )
endfunction

" move the cursor right one
function! rumpelstiltskin#move_right()
  let l:cursor_pos = getpos('.')
  let l:new_pos = [
        \ l:cursor_pos[0],
        \ l:cursor_pos[1],
        \ l:cursor_pos[2] + 1,
        \ l:cursor_pos[3]
        \]
  call setpos('.', l:new_pos)
endfunction

" TODO: DRY the following once you're better at vimscript

" CLDR functions
" Insert mode completion
function! rumpelstiltskin#cldr_complete()
  call fzf#vim#complete(fzf#wrap({
        \ 'source': 'cat ' . g:rumpelstiltskin_cldr_source,
        \ 'reducer': { text -> split(text[0], ' ... ')[0] },
        \ 'window': { 'width': 0.6, 'height': 0.2, 'xoffset': 0.5 }
        \ }))
  " no return means it returns 0, which inserts the literal 0
  return ''
endfunction

" Normal mode search
function! rumpelstiltskin#cldr()
  call fzf#run(fzf#wrap({
        \ 'source': 'cat ' . g:rumpelstiltskin_cldr_source,
        \ 'sink*': function('<SID>insert_sink')
        \ }))
endfunction

" General ("Full") functions
" Insert mode completion
function! rumpelstiltskin#full_complete()
  call fzf#vim#complete(fzf#wrap({
        \ 'source': 'cat ' . g:rumpelstiltskin_full_source,
        \ 'reducer': { text -> split(text[0], ' ... ')[0] },
        \ 'window': { 'width': 0.6, 'height': 0.2, 'xoffset': 0.5 }
        \ }))
  return ''
endfunction

" Normal mode search
function! rumpelstiltskin#full()
  call fzf#run(fzf#wrap({
        \ 'source': 'cat ' . g:rumpelstiltskin_full_source,
        \ 'sink*': function('<SID>insert_sink')
        \ }))
endfunction
