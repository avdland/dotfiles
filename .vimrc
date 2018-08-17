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

set number
set shiftwidth=2
set tabstop=2
set autoindent
set smarttab
set expandtab
set cindent
set ruler
set termguicolors
let g:airline#extensions#tabline#enabled = 1
set cursorline
set laststatus=2
set scrolloff=3
set hlsearch
set backspace=indent,eol,start
nmap <silent> ,/ :nohlsearch <CR>
noremap <F2> :split <CR>
noremap <F3> :vsplit <CR>
noremap <F4> :NERDTreeToggle <CR>
noremap <F5> :.!xmllint --format - <CR>
set t_vb= 

" disable bell and visual flash
autocmd GUIEnter * set vb t_vb= " for your GUI
autocmd VimEnter * set vb t_vb=

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

fu! BgFilename()
  if has('win32')
    return $HOME.'\vimfiles\mybg'
  else
    return $HOME.'/.vim/mybg'
  endif
endfu

fu! SetBg()
    try
      exec 'source '.fnameescape(BgFilename())
    catch
      set background=dark
      let g:airline_theme='gruvbox'
      MyColorscheme gruvbox
    endtry
endfu

fu! ToggleBackground()
  let fn = BgFilename()
  let clr = &bg
  if clr == "dark"
    let txt = ["set background=light", "MyColorscheme solarized", "let g:airline_theme='solarized'"]
  else
    let txt = ["set background=dark", "MyColorscheme gruvbox", "let g:airline_theme='gruvbox'"]
  endif
  call writefile(txt, fn, "b")
  exec 'source '.fnameescape(fn)
  AirlineRefresh
endfu

nnoremap <F6> :call ToggleBackground() <CR>

if has("win32")
  if has("gui_running")
    " GVIM
    set guioptions -=m  " remove menubar
    set guioptions -=T  " remove toolbar
    set guioptions -=r  " remove scrollbar

    let g:gruvbox_italic=0
    let g:solarized_italic=0
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
