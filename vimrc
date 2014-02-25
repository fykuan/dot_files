set cindent
set cursorline
set encoding=utf8
set expandtab
set fileencoding=utf8
set fileencodings=ucs-bom,utf8,cp950,latin1
set guifont=Inconsolata:h12
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set listchars=tab:»\ ,trail:·
set list
set nobomb
set nocompatible
set number
set ruler
set scrolloff=3
set secure
set shiftwidth=4
set showmatch
set smartcase
set t_Co=256
set visualbell
set wildmenu
set tabstop=4
set guifont=Sauce\ Code\ Powerline\ ExtraLight
syntax on
"
" keybinding
nmap <Esc>[Z <C-w>W
nmap <Tab> <C-w>w
"
" template
function LoadHTMLTemplate()
    0r ~/.vim/template/production.html
    normal Gdd
endfunction
function LoadPHPTemplate()
    0r ~/.vim/template/production.php
    normal Gdd
endfunction
function LoadPerlTemplate()
    0r ~/.vim/template/production.pl
    normal Gdd
endfunction

autocmd BufNewFile *.html call LoadHTMLTemplate()
autocmd BufNewFile *.pl call LoadPerlTemplate()
autocmd BufNewFile *.php call LoadPHPTemplate()
"
" other
au BufNewFile,BufRead *.psgi setf perl
au BufNewFile,BufRead *.json setf json
au BufNewFile,BufRead Makefile set noexpandtab
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
"

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'
Bundle 'Lokaltog/powerline'
Bundle 'altercation/vim-colors-solarized'
Bundle 'godlygeek/tabular'
Bundle 'Shougo/neocomplete.vim'

filetype on
"
" color schema
set background=dark
let g:solarized_termcolors=256
colo solarized
highlight Search cterm=none ctermbg=blue

" fix background issue
" see http://snk.tuxfamily.org/log/vim-256color-bce.html
"
if &term =~ '256color'
  " Disable Background Color Erase (BCE) so that color schemes
  " work properly when Vim is used inside tmux and GNU screen.
  " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

let mapleader = "\\"
let g:mapleader = "\\"
set rtp+=${HOME}/.vim/bundle/powerline/powerline/bindings/vim

let g:neocomplete#enable_at_startup = 1
