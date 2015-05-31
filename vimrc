set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'kien/ctrlp.vim'
Plugin 'sjl/gundo.vim'
Plugin 'scrooloose/nerdcommenter'

" Color schemes
Plugin 'tomasr/molokai'
Plugin 'flazz/vim-colorschemes'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on

colorscheme twilight
" colorscheme oxeded
set backspace=indent,eol,start

syntax on
let mapleader = ","

set wrap linebreak nolist
set autoindent
set shiftwidth=4
set tabstop=4

set number
set cursorline
set scrolloff=3
set hidden

set gdefault
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch

" Do not step over display lines by default
nnoremap j gj
nnoremap k gk

" general ignores
set wildignore+=*.swp

" latex-specific ignores
set wildignore+=*.fls,*.log,*.pdf,*.aux,*.out,*.fdb_latexmk,*.toc,*.loa,*.dvi

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
nnoremap <c-b> :CtrlPBuffer<CR>

" remove highlighting
nnoremap <leader><space> :noh<cr>

" show invisible chars
set listchars=tab:▸\ ,eol:¬
nnoremap <leader>ø :set list!<cr>

" undo tree
nnoremap <leader>u :GundoToggle<cr>

" latex-suite stuff:
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
let g:Tex_DefaultTargetFormat = "pdf"
set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
