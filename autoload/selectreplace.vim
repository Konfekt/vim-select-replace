function! selectreplace#escape(string) abort
  let string = a:string

  " Escape special characters in Vim regex.
  let string = '\V' . escape(string, '\/')

  " remove final line ending
  let string = substitute(string, "\r\?\n\?$", '', '')
  " escape line endings
  let string = substitute(string, "\n", '\\n', 'g')
  let string = substitute(string, "\r", '\\r', 'g')

  return string
endfunction

if exists('*getregion') " v:version >= 901 || has('nvim-0.10.1')
    function! selectreplace#getVisualSelection() abort
        return join(getregion(getpos('v'), getpos('.'), #{ type: mode() }),"\n")
    endfunction
    finish
endif

" {{{ From https://github.com/haya14busa/vim-asterisk/blob/1a805e320aea9d671be129b4162ea905a8bc095e/autoload/asterisk.vim#L234
"
" MIT License:
" Permission is hereby granted, free of charge, to any person obtaining
" a copy of this software and associated documentation files (the
" "Software"), to deal in the Software without restriction, including
" without limitation the rights to use, copy, modify, merge, publish,
" distribute, sublicense, and/or sell copies of the Software, and to
" permit persons to whom the Software is furnished to do so, subject to
" the following conditions:
"
" The above copyright notice and this permission notice shall be included
" in all copies or substantial portions of the Software.

let s:INT = { 'MAX': 2147483647 }

" Assume the current mode is middle of visual mode.
" @return selected text
function! selectreplace#getVisualSelection() abort
    let mode = mode()
    let end_col = s:curswant() is s:INT.MAX ? s:INT.MAX : s:get_col_in_visual('.')
    let current_pos = [line('.'), end_col]
    let other_end_pos = [line('v'), s:get_col_in_visual('v')]
    let [begin, end] = s:sort_pos([current_pos, other_end_pos])
    if s:is_exclusive() && begin[1] !=# end[1]
        " Decrement column number for :set selection=exclusive
        let end[1] -= 1
    endif
    if mode !=# 'V' && begin ==# end
        let lines = [s:get_pos_char(begin)]
    elseif mode ==# "\<C-v>"
        let [min_c, max_c] = s:sort_num([begin[1], end[1]])
        let lines = map(range(begin[0], end[0]), '
        \   getline(v:val)[min_c - 1 : max_c - 1]
        \ ')
    elseif mode ==# 'V'
        let lines = getline(begin[0], end[0])
    else
        if begin[0] ==# end[0]
            let lines = [getline(begin[0])[begin[1]-1 : end[1]-1]]
        else
            let lines = [getline(begin[0])[begin[1]-1 :]]
            \         + (end[0] - begin[0] < 2 ? [] : getline(begin[0]+1, end[0]-1))
            \         + [getline(end[0])[: end[1]-1]]
        endif
    endif
    return join(lines, "\n") . (mode ==# 'V' ? "\n" : '')
endfunction

" @return Number: return multibyte aware column number in Visual mode to select
function! s:get_col_in_visual(pos) abort
    let [pos, other] = [a:pos, a:pos is# '.' ? 'v' : '.']
    let c = col(pos)
    let d = s:compare_pos(s:getcoord(pos), s:getcoord(other)) > 0
    \   ? len(s:get_pos_char([line(pos), c - (s:is_exclusive() ? 1 : 0)])) - 1
    \   : 0
    return c + d
endfunction

function! s:get_multi_col(pos) abort
    let c = col(a:pos)
    return c + len(s:get_pos_char([line(a:pos), c])) - 1
endfunction

" Helper:

function! s:is_visual(mode) abort
    return a:mode =~# "[vV\<C-v>]"
endfunction

" @return Boolean
function! s:is_exclusive() abort
    return &selection is# 'exclusive'
endfunction

function! s:curswant() abort
    return winsaveview().curswant
endfunction

" @return coordinate: [Number, Number]
function! s:getcoord(expr) abort
    return getpos(a:expr)[1:2]
endfunction

"" Return character at given position with multibyte handling
" @arg [Number, Number] as coordinate or expression for position :h line()
" @return String
function! s:get_pos_char(...) abort
    let pos = get(a:, 1, '.')
    let [line, col] = type(pos) is# type('') ? s:getcoord(pos) : pos
    return matchstr(getline(line), '.', col - 1)
endfunction

" @return int index of cursor in cword
function! s:get_pos_in_cword(cword, ...) abort
    return (s:is_visual(get(a:, 1, mode(1))) || s:get_pos_char() !~# '\k') ? 0
    \   : s:count_char(searchpos(a:cword, 'bcn')[1], s:get_multi_col('.'))
endfunction

" multibyte aware
function! s:count_char(from, to) abort
    let chars = getline('.')[a:from-1:a:to-1]
    return len(split(chars, '\zs')) - 1
endfunction

" 7.4.341
" http://ftp.vim.org/vim/patches/7.4/7.4.341
if v:version > 704 || v:version == 704 && has('patch341')
    function! s:sort_num(xs) abort
        return sort(a:xs, 'n')
    endfunction
else
    function! s:_sort_num_func(x, y) abort
        return a:x - a:y
    endfunction
    function! s:sort_num(xs) abort
        return sort(a:xs, 's:_sort_num_func')
    endfunction
endif

function! s:sort_pos(pos_list) abort
    " pos_list: [ [x1, y1], [x2, y2] ]
    return sort(a:pos_list, 's:compare_pos')
endfunction

function! s:compare_pos(x, y) abort
    return max([-1, min([1,(a:x[0] == a:y[0]) ? a:x[1] - a:y[1] : a:x[0] - a:y[0]])])
endfunction
" }}}
