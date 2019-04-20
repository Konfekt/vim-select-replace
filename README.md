*Vim-Select-Replace*
==================

A Vim plug-in to replace or delete a selection in multiple places.

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

# Credits

These ideas to make good use of `:help v_gn` have in essence been divulged by Romain Lafourcade.
