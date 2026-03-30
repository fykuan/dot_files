set nocompatible
set showmatch
set ignorecase
set hlsearch
set incsearch
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set autoindent
set number
set wildmode=longest,list
set cc=80
filetype plugin indent on
syntax on
filetype plugin on
set cursorline
set ttyfast
set t_Co=256
set cursorcolumn
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set mouse=
"""""""""""""""""""""
"Plugins
"""""""""""""""""""""

call plug#begin('~/.vim/plugged')
Plug 'bling/vim-airline'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ntpeters/vim-better-whitespace'
Plug 'chriskempson/tomorrow-theme'
Plug 'sheerun/vim-polyglot'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'airblade/vim-gitgutter'
Plug 'frazrepo/vim-rainbow'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'jayli/vim-easycomplete'
Plug 'SirVer/ultisnips'
Plug 'ryanoasis/vim-devicons'
call plug#end()

" NerdTree key mappings
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Use \b to list and switch vim buffers
nnoremap <Leader>b :ls<CR>:b<Space>

silent! colorscheme Tomorrow-Night-Eighties
au FileType c,cpp,objc,objcpp call rainbow#load()

""" highlight 要寫在 colorscheme 之後
highlight CursorColumn cterm=none ctermbg=8
highlight CursorLine cterm=none ctermbg=8
