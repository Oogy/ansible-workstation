nnoremap <SPACE> <Nop>
let mapleader=" "
set timeoutlen=2000

set clipboard+=unnamedplus
set number relativenumber
set nu rnu

nnoremap <Leader>et :e `mktemp`<Enter>
nnoremap <Leader>ei :e ~/.config/nvim/init.vim <Enter>
nnoremap <Leader>ls :e . <Enter>
nnoremap <Leader>' :term <Enter>

lua require('plugins')
