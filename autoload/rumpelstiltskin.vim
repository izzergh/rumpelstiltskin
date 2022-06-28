let g:rumpelstiltskin_base_source = expand('<sfile>:p:h:h') . '/base_source.txt'
let g:rumpelstiltskin_emoji_source = expand('<sfile>:p:h:h') . '/emoji_source.txt'

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

" General ("Base") functions
" Insert mode completion
function! rumpelstiltskin#base_complete()
  call fzf#vim#complete(fzf#wrap({
        \ 'source': 'cat ' . g:rumpelstiltskin_base_source,
        \ 'reducer': { text -> split(text[0], ' ... ')[0] },
        \ 'window': { 'width': 0.6, 'height': 0.2, 'xoffset': 0.5 }
        \ }))
  return ''
endfunction

" Normal mode search
function! rumpelstiltskin#base()
  call fzf#run(fzf#wrap({
        \ 'source': 'cat ' . g:rumpelstiltskin_base_source,
        \ 'sink*': function('<SID>insert_sink')
        \ }))
endfunction

" Emoji functions
" Insert mode completion
function! rumpelstiltskin#emoji_complete()
  call fzf#vim#complete(fzf#wrap({
        \ 'source': 'cat ' . g:rumpelstiltskin_emoji_source,
        \ 'reducer': { text -> split(text[0], ' ... ')[0] },
        \ 'window': { 'width': 0.6, 'height': 0.2, 'xoffset': 0.5 }
        \ }))
  return ''
endfunction

" Normal mode search
function! rumpelstiltskin#emoji()
  call fzf#run(fzf#wrap({
        \ 'source': 'cat ' . g:rumpelstiltskin_emoji_source,
        \ 'sink*': function('<SID>insert_sink')
        \ }))
endfunction
