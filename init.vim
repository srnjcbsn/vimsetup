call plug#begin('~/.nvim/plugged')

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'neomake/neomake'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/deoplete.nvim'
Plug 'LnL7/vim-nix'
Plug 'bling/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'tomtom/tcomment_vim'
Plug 'lambdatoast/elm.vim'

" Haskell
Plug 'nbouscal/vim-stylish-haskell'
Plug 'bitc/vim-hdevtools'
Plug 'eagletmt/neco-ghc'
Plug 'neovimhaskell/haskell-vim'

" Color schemes
Plug 'morhetz/gruvbox'

call plug#end()

colorscheme gruvbox
set background=dark

set number
set cursorline
set expandtab
set shiftwidth=4

filetype plugin on
syntax on

nmap , <leader>

" Neomake
autocmd! BufWritePost * Neomake
let g:neomake_haskell_enabled_makers = ['hdevtools', 'hlint']
let g:neomake_warning_sign = {
  \ 'text': 'W',
  \ 'texthl': 'NeomakeWarningSign',
  \ }

" deoplete
let g:deoplete#enable_at_startup = 1

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
nnoremap <c-b> :CtrlPBuffer<CR>

" NERDTree
map <leader>f :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1

" remove highlighting
nnoremap <leader><space> :noh<cr>

" show invisible chars
set listchars=tab:▸\ ,eol:¬
nnoremap <leader>ø :set list!<cr>

" airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ' '
let g:airline_right_sep = ' '
let g:airline#extensions#default#layout = [
      \ [ 'a', 'b', 'c' ],
      \ [ 'x', 'z', 'warning' ]
      \ ]
