set t_Co=8
set nocompatible
colorscheme delek

call plug#begin('~/.vim/plugged')
Plug 'vito-c/jq.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'
Plug 'nvie/vim-flake8'
Plug 'tpope/vim-commentary'
Plug 'justinmk/vim-dirvish'
Plug 'mbbill/undotree'
Plug 'luochen1990/rainbow'
Plug 'wlangstroth/vim-racket'
Plug 'katusk/vim-qkdb-syntax'
call plug#end()

filetype plugin indent on
syntax on

set backspace=indent,eol,start
set mouse=a
set number
let mapleader = "\<Space>"
set directory=~/.vim/swapfiles//

nnoremap <Leader>fs :w<CR>

nmap <Leader>bb :Buffers<CR>
nmap <Leader>ff :Files<CR>
nmap <Leader>ll :Lines<CR>
nmap <Leader>tt :BTags<CR>
nmap <Leader>ls :BLines<CR>
nmap <Leader>ar :Ranger<CR>

noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$
onoremap <silent> j gj
onoremap <silent> k gk

let g:ale_sign_error = '○'
let g:ale_sign_warning = '○'

hi StatusLine cterm=bold ctermfg=7 ctermbg=6
hi StatusLineNC cterm=None ctermfg=1 ctermbg=8
hi VertSplit cterm=None ctermfg=8 ctermbg=8
hi LineNr ctermfg=4

hi ALEErrorSign ctermfg=Red
hi ALEWarningSign ctermfg=Yellow
hi ALEStyleErrorSign ctermfg=Yellow
hi ALEStyleWarningSign ctermfg=Yellow
hi ALEStyleError ctermfg=Blue
hi ALEError ctermfg=Red

let g:rainbow_active = 1
