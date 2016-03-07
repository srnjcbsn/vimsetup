set shell=bash
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set runtimepath+=.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'kien/ctrlp.vim'
Plugin 'sjl/gundo.vim'
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'tomtom/tcomment_vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'danro/rename.vim'
Plugin 'tpope/vim-surround'
Plugin 'raichoo/haskell-vim'
Plugin 'bitc/vim-hdevtools'
Plugin 'nbouscal/vim-stylish-haskell'
Plugin 'justinmk/vim-sneak'
Plugin 'LnL7/vim-nix'

" Color schemes
Plugin 'tomasr/molokai'
Plugin 'chriskempson/base16-vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'morhetz/gruvbox'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on

colorscheme gruvbox
set background=dark

set backspace=indent,eol,start

syntax on
let mapleader = ","

set noswapfile
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
set expandtab
set colorcolumn=80

" jump to tag
:nnoremap <c-j> <c-]>

" Automatically cd to path of file
autocmd BufEnter * silent! lcd %:p:h

" Do not step over display lines by default
nnoremap j gj
nnoremap k gk

" general ignores
set wildignore+=*.swp

" latex-specific ignores
set wildignore+=*.fls,*.log,*.pdf,*.aux,*.out,*.fdb_latexmk,*.toc,*.loa,*.dvi,*.synctex.gz

" haskell-specific ignores
set wildignore+=*.hi,*.o,*.dyn_hi,*.p_hi,*.dyn_o,*.p_o

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
nnoremap <c-b> :CtrlPBuffer<CR>

" NERDTree
map <leader>f :NERDTreeToggle<CR>
map <C-n> :NERDTreeToggle<CR>

" remove highlighting
nnoremap <leader><space> :noh<cr>

" show invisible chars
set listchars=tab:▸\ ,eol:¬
nnoremap <leader>ø :set list!<cr>

" undo tree
nnoremap <leader>u :GundoToggle<cr>

" airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ' '
let g:airline_right_sep = ' '
let g:airline#extensions#default#layout = [
      \ [ 'a', 'b', 'c' ],
      \ [ 'x', 'z', 'warning' ]
      \ ]

" syntastic
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = "!"
let g:syntastic_warning_symbol = "W"
let g:syntastic_style_warning_symbol = "W"

" Reload
map <silent> tu :call GHC_BrowseAll()<CR>
" Type Lookup
map <silent> tw :call GHC_ShowType(1)<CR>

" tagbar
nnoremap <leader>t = :TagbarToggle<CR>
let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
    \ }
\ }
