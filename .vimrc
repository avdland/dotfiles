syntax enable
set number
set ruler
set hlsearch
set background=dark
set cursorline
set backspace=2
" enable vim-airline by default
set laststatus=2
" only latest vim support termguicolors, used for gruvbox colorscheme
if has("termguicolors")
  set termguicolors
endif
let g:gruvbox_italic=1
colorscheme gruvbox
