syntax enable                                                                                                                                                                                        

set number
set ruler
set hlsearch
set background=dark
set cursorline
set backspace=2
set laststatus=2

" only latest vim support termguicolors, use gruvbox 256 color script in .bashrc otherwise
if has("termguicolors")
  set termguicolors
endif

noremap <F2> :split <CR>
noremap <F3> :vsplit <CR>
noremap <F4> :NERDTreeToggle <CR>

" enable italics because it's disabled by default
let g:gruvbox_italic=1

" fix NERDTree arrows
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '~'

" start NERDTree when no file is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

colorscheme gruvbox
