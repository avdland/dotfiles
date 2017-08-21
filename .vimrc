execute pathogen#infect()
syntax enable

" presistent undo
set undofile
set undolevels=500
set undoreload=500
set undodir=~/.vim/tmp

" GUI
set number                   " show line numbers
set ruler                    " show ruler
set hlsearch                 " higlight search results
set incsearch                " show search matches as you type
set background=dark          " set darkground
set cursorline               " set current horizontal row background
set laststatus=2             " enable statusbar

" Indentation
set shiftwidth=4             " Number of spaces to use in each autoindent step
set tabstop=4                " Two tab spaces
set softtabstop=4            " Number of spaces to skip or insert when <BS>ing or <Tab>ing
set expandtab                " Spaces instead of tabs for better cross-editor compatibility
set smarttab                 " Use shiftwidth and softtabstop to insert or delete (on <BS>) blanks
set autoindent               " Keep the indent when creating a new line
set cindent                  " Recommended seting for automatic C-style indentation

" Moving around / editing
set nostartofline            " Avoid moving cursor to BOL when jumping around
set scrolloff=3              " Keep 3 context lines above and below the cursor
set backspace=2              " Allow backspacing over autoindent, EOL, and BOL
set showmatch                " Briefly jump to a paren once it's balanced
set matchtime=2              " (for only .2 seconds).

" temporary files directory
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp

" show invisibles
set list
set listchars=tab:>-,trail:~,extends:>,precedes:<

set wildignore=*.o,*.obj,*.bak,*.exe,*.class,*.so,*.tar,*.tgz,*.zip,*.pdf,*.svn
set wildmode=full

set visualbell   " dont beep
set noerrorbells " dont beep

" Disable annoying auto line break
fu! DisableBr()
    set wrap
    set linebreak
    set nolist
    set textwidth=0
    set wrapmargin=0
    set fo-=t
endfu

" Disable line breaks for all file types
:au BufNewFile,BufRead *.* call DisableBr()

" Easy window navigation
map <C-left> <C-w>h
map <C-down> <C-w>j
map <C-up> <C-w>k
map <C-right> <C-w>l

" Splitting screen, F2/F3
noremap <F2> :split <CR>
noremap <F3> :vsplit <CR>

" Start NERDTree by pressing F4
noremap <F4> :NERDTreeToggle <CR>

" Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR> 

" Pressing Home will move cursor to first word, not beginning of line
noremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
imap <silent> <Home> <C-O><Home>

" clear search highlights by pressing ,/
nmap <silent> ,/ :nohlsearch<CR>

" :W sudo saves file
command W w !sudo tee % > /dev/null

" Fixes broken NERDTree arrows
"let g:NERDTreeDirArrowExpandable = '+'
"let g:NERDTreeDirArrowCollapsible = '~'

" start NERDTree when no file is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"colorscheme solarized
"let g:airline_theme='solarized'

colorscheme gruvbox
let g:gruvbox_italic=1
let g:airline_theme='gruvbox'
