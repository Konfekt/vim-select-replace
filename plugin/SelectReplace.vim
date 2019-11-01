if exists('g:loaded_SelectReplace')
  finish
endif
let g:loaded_SelectReplace = 1

let s:keepcpo         = &cpo
set cpo&vim
" ------------------------------------------------------------------------------

" *,#,g*/# in operator mode do NOT respect smartcase
"  1. Press c*/# to change the current word then <Esc>. Now either:
" (A) Press n/N to skip the next occurrence, or
" (B) Press . to repeat the previous move and change
silent! onoremap <expr> <plug>(vim-select-replace-star)   '<esc>/\C\V\<' . escape(expand('<cword>'), '\') . '\><cr>g``' .
      \ '"' . v:register . v:count . v:operator . 'gn'
silent! onoremap <expr> <plug>(vim-select-replace-g-star) '<esc>/\C\V'   . escape(expand('<cword>'), '\') .   '<cr>g``' .
      \ '"' . v:register . v:count .  v:operator . 'gn'
silent! onoremap <expr>  <plug>(vim-select-replace-hash)  '<esc>?\C\V\<' . escape(expand('<cword>'), '\') . '\><cr>g``' . 
      \ '"' . v:register . v:count .  v:operator . 'gN'
silent! onoremap <expr> <plug>(vim-select-replace-g-hash) '<esc>?\C\V'   . escape(expand('<cword>'), '\') .   '<cr>g``' . 
      \ '"' . v:register . v:count .  v:operator . 'gN'

" change/delete all occurences of visual selection
silent! xnoremap <expr> <plug>(vim-select-replace-s)
      \ '/\C' . SelectReplace#escape(SelectReplace#getVisualSelection()) . '<CR><ESC>' . '``cgn'
silent! xnoremap <expr> <plug>(vim-select-replace-x)
      \ '/\C' . SelectReplace#escape(SelectReplace#getVisualSelection()) . '<CR><ESC>' . '``dgn'

if !hasmapto('<Plug>(vim-select-replace-star)', 'o')
  silent! omap <unique> *  <plug>(vim-select-replace-star)
endif
if !hasmapto('<Plug>(vim-selshect-replace-g-star)', 'o')
  silent! omap <unique> g* <plug>(vim-select-replace-g-star)
endif
if !hasmapto('<Plug>(vim-select-replace-hash)', 'o')
  silent! omap <unique> #  <plug>(vim-select-replace-hash)
endif
if !hasmapto('<Plug>(vim-select-replace-g-hash)', 'o')
  silent! omap <unique> g# <plug>(vim-select-replace-g-hash)
endif

if !hasmapto('<Plug>(vim-select-replace-s)', 'x')
  silent! xmap <unique> s  <plug>(vim-select-replace-s)
endif
if !hasmapto('<Plug>(vim-select-replace-x)', 'x')
  silent! xmap <unique> x  <plug>(vim-select-replace-x)
endif

" silent! xnoremap <unique> <expr> *             '/' . SelectReplace#escape(SelectReplace#getVisualSelection()) . '<CR><ESC>'
" silent! xnoremap <unique> <expr> #             '?' . SelectReplace#escape(SelectReplace#getVisualSelection()) . '<CR><ESC>'

" ------------------------------------------------------------------------------
let &cpo= s:keepcpo
unlet s:keepcpo
