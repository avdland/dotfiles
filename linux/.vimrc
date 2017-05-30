syntax enable

set number                   " show line numbers
set ruler                    " show ruler
set hlsearch                 " higlight search results
set background=dark          " set darkground
set cursorline               " set current horizontal row background
set laststatus=2             " enable statusbar

" Indentation
set shiftwidth=2             " Number of spaces to use in each autoindent step
set tabstop=2                " Two tab spaces
set softtabstop=2            " Number of spaces to skip or insert when <BS>ing or <Tab>ing
set expandtab                " Spaces instead of tabs for better cross-editor compatibility
set autoindent               " Keep the indent when creating a new line
set smarttab                 " Use shiftwidth and softtabstop to insert or delete (on <BS>) blanks
set cindent                  " Recommended seting for automatic C-style indentation
set autoindent               " Automatic indentation in non-C files

" Moving around / editing
set nostartofline            " Avoid moving cursor to BOL when jumping around
set scrolloff=3              " Keep 3 context lines above and below the cursor
set backspace=2              " Allow backspacing over autoindent, EOL, and BOL
set showmatch                " Briefly jump to a paren once it's balanced
set matchtime=2              " (for only .2 seconds).

set list!                    " show invisibles (tabs, trail)
set listchars=tab:>-,trail:- " ---> for tabs, and ---- for trailing spaces

noremap <F2> :split <CR>
noremap <F3> :vsplit <CR>
noremap <F4> :NERDTreeToggle <CR>

" only latest vim support termguicolors, use gruvbox 256 color script in .bashrc otherwise
if has("termguicolors")
  set termguicolors
endif

" enable italics because it's disabled by default
let g:gruvbox_italic=1

" fix NERDTree arrows
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '~'

" start NERDTree when no file is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

colorscheme gruvbox
