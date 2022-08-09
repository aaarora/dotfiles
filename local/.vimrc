" Vim with all enhancements

syntax on
set nocompatible
set hidden

set noerrorbells visualbell

set backspace=indent,eol,start

set nowrap
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set smarttab
set ignorecase
set shiftround
set autoindent
set copyindent
set smartindent
set showmatch
set number

set incsearch

set title
set nobackup
set noswapfile
set noundofile

colorscheme slate 

vnoremap <silent> # :s/^/#/<cr>:noh<cr>
vnoremap <silent> -# :s/^#//<cr>:noh<cr>