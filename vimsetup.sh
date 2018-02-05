#!/bin/sh
#
# Setup Vim configuration and plugins for MSYS2.

which git > /dev/null
if [ $? -ne 0 ]; then
  echo 'git not installed!'
  exit 1
fi

if [ ! -e ~/.vim/autoload/pathogen.vim ]; then
  mkdir -p ~/.vim/autoload ~/.vim/bundle
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

if [ ! -e ~/.vim/bundle/vim-sensible ]; then
  cd ~/.vim/bundle
  git clone git://github.com/tpope/vim-sensible.git
fi

if [ ! -e ~/.vim/bundle/gruvbox ]; then
  cd ~/.vim/bundle
  git clone git://github.com/morhetz/gruvbox.git
fi

if [ ! -e ~/.vim/bundle/ctrlp.vim ]; then
  cd ~/.vim/bundle
  git clone git://github.com/kien/ctrlp.vim.git
fi

if [ $1 == f ] || [ ! -e ~/.vimrc ]; then
  cat <<EOT > ~/.vimrc
execute pathogen#infect()
syntax on
filetype plugin indent on
set list
set listchars=tab:>-,trail:~,extends:>,precedes:<
set visualbell
set noerrorbells
set number
set shiftwidth=2
set tabstop=2
set expandtab
set termguicolors
set background=dark
set cursorline
set hlsearch
colorscheme gruvbox
EOT
fi
