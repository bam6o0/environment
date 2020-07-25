set encoding=utf-8
scriptencoding utf-8
set number
set cursorline

set hlsearch
set ignorecase
set incsearch

set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set smartindent

set showmatch
set matchtime=3
set matchpairs& matchpairs+=<:>
source $VIMRUNTIME/macros/matchit.vim

set nowritebackup
set nobackup
set noswapfile

if &term =~ "xterm"
  let &t_SI .= "\e[?2004h"
  let &t_EI .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction

  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif
syntax on


filetype plugin indent on
