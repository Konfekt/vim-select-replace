*Vim-Select-Replace*
==================

A Vim plug-in to replace or delete a word or selection in multiple places.

# Usage

By this Vim plug-in, you can:

- Hit `c` or `d` followed by `*`, `#`, `g*` or `g#` to replace respectively delete the current word.
    Now either:
    - Press `n/N` to skip the next occurrence of this word, or
    - Press `.` to repeat the previous move and change or deletion.

- Hit `s` or `x` in visual mode to replace respectively delete the selection under the cursor.
    Now either:
    - Press `n/N` to skip the next occurrence of this selection, or
    - Press `.` to repeat the previous move and change or deletion.

# Configuration

To change the default mappings, add your modifications of

```vim
omap  *  <plug>(vim-select-replace-star)
omap  g* <plug>(vim-select-replace-g-star)
omap  #  <plug>(vim-select-replace-hash)
omap  g# <plug>(vim-select-replace-g-hash)

xmap  s  <plug>(vim-select-replace-s)
xmap  x  <plug>(vim-select-replace-x)
```

to your `vimrc`.

# Credits

These ideas to make good use of `:help v_gn` have in essence been divulged by Romain Lafourcade.
