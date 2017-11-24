execute pathogen#infect()
syntax enable

set noswapfile

" presistent undo
set undofile
set undolevels=500
set undoreload=500

if has("win32")
  set undodir=$HOME\vimfiles\tmp
  set backupdir=$HOME\vimfiles\tmp
  set directory=$HOME\vimfiles\tmp
else
  if has("unix")
    set undodir=$HOME/.vim/tmp
    set backupdir=$HOME/.vim/tmp
    set directory=$HOME/.vim/tmp
  endif
endif

if !exists('s:known_links')
  let s:known_links = {}
endif

function! s:Find_links() " {{{1
  " Find and remember links between highlighting groups.
  redir => listing
  try
    silent highlight
  finally
    redir END
  endtry
  for line in split(listing, "\n")
    let tokens = split(line)
    " We're looking for lines like "String xxx links to Constant" in the
    " output of the :highlight command.
    if len(tokens) == 5 && tokens[1] == 'xxx' && tokens[2] == 'links' && tokens[3] == 'to'
      let fromgroup = tokens[0]
      let togroup = tokens[4]
      let s:known_links[fromgroup] = togroup
    endif
  endfor
endfunction

function! s:Restore_links() " {{{1
  " Restore broken links between highlighting groups.
  redir => listing
  try
    silent highlight
  finally
    redir END
  endtry
  let num_restored = 0
  for line in split(listing, "\n")
    let tokens = split(line)
    " We're looking for lines like "String xxx cleared" in the
    " output of the :highlight command.
    if len(tokens) == 3 && tokens[1] == 'xxx' && tokens[2] == 'cleared'
      let fromgroup = tokens[0]
      let togroup = get(s:known_links, fromgroup, '')
      if !empty(togroup)
        execute 'hi link' fromgroup togroup
        let num_restored += 1
      endif
    endif
  endfor
endfunction

function! s:AccurateColorscheme(colo_name)
  call <SID>Find_links()
  exec "colorscheme " a:colo_name
  call <SID>Restore_links()
endfunction

command! -nargs=1 -complete=color MyColorscheme call <SID>AccurateColorscheme(<q-args>)

" GUI
set number                   " show line numbers
set ruler                    " show ruler
set hlsearch                 " higlight search results
set incsearch                " show search matches as you type
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
  "set nolist
  set textwidth=0
  set wrapmargin=0
  set fo-=t
endfu

" Disable line breaks for all file types
:au BufNewFile,BufRead *.* call DisableBr()

fu! BgFilename()
  if has('win32')
    return $HOME.'\vimfiles\mybg'
  else
    return $HOME.'/.vim/mybg'
  fi
endfu

fu! ToggleBackground()
  let fn = BgFilename()
  let clr = &bg
  if clr == "dark"
    let txt = ["set background=light", "MyColorscheme solarized", "let g_airline_theme='solarized'"]
  else
    let txt = ["set background=dark", "MyColorscheme gruvbox", "let g_airline_theme='gruvbox'"]
  endif
  call writefile(txt, fn, "b")
  exec 'source '.fnameescape(fn)
endfu

nnoremap <F6> :call ToggleBackground() <CR>

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

" https://github.com/majutsushi/tagbar
nmap <F5> :TagbarToggle <CR>

" Remove all trailing whitespace by pressing F5
nnoremap <F9> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR> 

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
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

if &term =~ '256color'
    " Disable Background Color Erase (BCE) so that color schemes
    " work properly when Vim is used inside tmux and GNU screen.
    set t_ut=
endif

fu! SetBg()
    try
      exec 'source '.fnameescape(BgFilename())
    catch
      set background=dark
      let g_airline_theme='gruvbox'
      MyColorscheme gruvbox
    endtry
endfu

if has("win32")
  if has("gui_running")
    " GVIM
    set guioptions -=m  " remove menubar
    set guioptions -=T  " remove toolbar
    set guioptions -=r  " remove scrollbar

    let g:gruvbox_italic=0
    call SetBg()
  else
    " VIM via CMD (only 16 colors)
    set noeb vb t_vb=
    MyColorscheme industry
  endif
else
  if has("unix")
    " Linux
    call SetBg()
  endif
endif
