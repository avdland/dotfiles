#!/bin/sh

which git > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo 'git not installed!'
  exit 1
fi

which svn > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo 'svn not installed!'
  exit 1
fi

install_plugin() {
  local name="${1#*/}"
  if [ ! -e ~/.vim/bundle/$name ]; then
    cd ~/.vim/bundle
    git clone git://github.com/$1.git
    cd -
  else
    echo "Skippping $name"
  fi
}

mkdir -p ~/.vim/autoload ~/.vim/bundle ~/.vim/tmp

if [ ! -e ~/.vim/autoload/pathogen.vim ]; then
  cd ~/.vim/autoload
  wget https://tpo.pe/pathogen.vim
  cd -
fi

install_plugin tpope/vim-fugitive
install_plugin vim-airline/vim-airline
install_plugin scrooloose/nerdtree
install_plugin morhetz/gruvbox
install_plugin kien/ctrlp.vim
install_plugin martinda/Jenkinsfile-vim-syntax

if [ "$1" == f ] || [ ! -e ~/.vimrc ]; then
  cat <<EOT > ~/.vimrc
execute pathogen#infect()
syntax on
filetype plugin indent on
set list
set listchars=tab:>-,trail:~,extends:>,precedes:<,nbsp:+
set visualbell
set noerrorbells
set history=1000
set undofile
set undolevels=500
set undoreload=500
set undodir=\$HOME/.vim/tmp
set backupdir=\$HOME/.vim/tmp
set directory=\$HOME/.vim/tmp
set number
set shiftwidth=2
set tabstop=2
set autoindent
set smarttab
set expandtab
set cindent
set ruler
set termguicolors
set background=dark
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1
set cursorline
set laststatus=2
set scrolloff=3
set hlsearch
colorscheme gruvbox
set backspace=indent,eol,start
nmap <silent> ,/ :nohlsearch <CR>
noremap <F2> :split <CR>
noremap <F3> :vsplit <CR>
noremap <F4> :NERDTreeToggle <CR>
noremap <F5> :.!xmllint --format - <CR>
set t_vb=
EOT
fi
