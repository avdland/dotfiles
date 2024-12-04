set background=dark
autocmd vimenter * ++nested colorscheme gruvbox

au BufNewFile,BufRead Jenkinsfile setf groovy

set undodir=$HOME/.vim/tmp
set backupdir=$HOME/.vim/tmp
set directory=$HOME/.vim/tmp

syntax on
filetype plugin indent on

set autoindent
set smartindent
set si
set list
set listchars=tab:>-,trail:~,extends:>,precedes:<,nbsp:+
set visualbell
set noerrorbells
set history=1000
set undofile
set undolevels=500
set undoreload=500
set number
set shiftwidth=2
set tabstop=2
set autoindent
set smarttab
set expandtab
set cindent
set ruler
set cursorline
set laststatus=2
set scrolloff=3
set hlsearch
set backspace=indent,eol,start
