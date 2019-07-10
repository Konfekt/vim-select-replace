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

Note that the operators `c` or `d` on a word are only exemplary;
other examples are:

-  the operators `gu`, `gU`, `g~`  or `g?` to make all letters lower respectively upper case, to toggle the cases of all letters, or to advance each letter by 13 positions in the Latin alphabet;
- the operator `gr` of Ingo Karkat's Vim plug-in [ReplaceWithRegister](https://github.com/vim-scripts/ReplaceWithRegister) to replace the word with the content of the unnamed register (or `"+gr` to replace the word with the content of the clipboard);
- the operator `yr` of Tim Pope's Vim plug-in [vim-surround](https://github.com/tpope/vim-surround) or the operator `sa` of Masaaki Nakamura's [vim-sandwich](https://github.com/machakann/vim-sandwich) to surround the word with delimiters to be specified.

Vim plug-ins such as [ctrlsf.vim](https://github.com/dyng/ctrlsf.vim) and [quickfix-reflector.vim](https://github.com/stefandtw/quickfix-reflector.vim) enable you to selectively operating on occurrences throughout the whole current work dir.

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

# Related Plug-ins

It seems that Ingo Karkat's recent Vim plug-in in [vim-ChangeGlobally](https://github.com/inkarkat/vim-ChangeGlobally) achieves something similar to this one.

# Credits

These ideas to make good use of `:help v_gn` have in essence been divulged by Romain Lafourcade and the function that returns the visual selection has been taken from @hayab14usa's [vim-asterik](https://github.com/haya14busa/vim-asterisk/)
