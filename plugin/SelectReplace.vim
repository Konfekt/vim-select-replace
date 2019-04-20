if exists('g:loaded_SelectReplace')
  finish
endif

" *,#,g*/# in operator mode do NOT respect smartcase
"  1. Press c*/# to change the current word then <Esc>. Now either:
" (A) Press n/N to skip the next occurrence, or
" (B) Press . to repeat the previous move and change
silent! onoremap <unique> <expr>  * 
      \ '<esc>/\C\V\<' .
      \ escape(expand('<cword>'), '\') . '\><cr>g``' .
      \ '"' . v:register . v:count . v:operator . 'gn'
silent! onoremap <unique> <expr> g* '<esc>/\C\V'   . escape(expand('<cword>'), '\') .   '<cr>g``' . '"' . v:register . v:count .  v:operator . 'gn'
silent! onoremap <unique> <expr>  # '<esc>?\C\V\<' . escape(expand('<cword>'), '\') . '\><cr>g``' . '"' . v:register . v:count .  v:operator . 'gN'
silent! onoremap <unique> <expr> g# '<esc>?\C\V'   . escape(expand('<cword>'), '\') .   '<cr>g``' . '"' . v:register . v:count .  v:operator . 'gN'

" change/delete all occurences of visual selection
silent! xnoremap <unique> <expr> s             '/\C' . SelectReplace#escape(SelectReplace#getVisualSelection()) . '<CR><ESC>' . '``cgn'
silent! xnoremap <unique> <expr> x             '/\C' . SelectReplace#escape(SelectReplace#getVisualSelection()) . '<CR><ESC>' . '``dgn'

" silent! xnoremap <unique> <expr> *             '/' . SelectReplace#escape(SelectReplace#getVisualSelection()) . '<CR><ESC>'
" silent! xnoremap <unique> <expr> #             '?' . SelectReplace#escape(SelectReplace#getVisualSelection()) . '<CR><ESC>'

let g:loaded_SelectReplace = 1
