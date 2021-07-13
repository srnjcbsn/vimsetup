" set t_Co=8
set nocompatible

call plug#begin('~/.vim/plugged')
" Plug 'mhinz/vim-signify'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vito-c/jq.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'nvie/vim-flake8'
Plug 'tpope/vim-commentary'
Plug 'justinmk/vim-dirvish'
Plug 'mbbill/undotree'
Plug 'luochen1990/rainbow'
Plug 'wlangstroth/vim-racket'
Plug 'katusk/vim-qkdb-syntax'
Plug 'cespare/vim-toml'
Plug 'sheerun/vim-polyglot'
" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'rust-lang/rust.vim'
" Plug 'OmniSharp/omnisharp-vim'

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Extensions to built-in LSP, for example, providing type inlay hints
Plug 'nvim-lua/lsp_extensions.nvim'

" Autocompletion framework for built-in LSP
Plug 'nvim-lua/completion-nvim'
Plug 'arcticicestudio/nord-vim'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'folke/tokyonight.nvim'


" Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
Plug 'kabouzeid/nvim-lspinstall'

Plug 'hrsh7th/nvim-compe'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-treesitter/playground'
call plug#end()

" colorscheme jellybeans
colorscheme tokyonight

filetype plugin indent on
syntax on

set backspace=indent,eol,start
set mouse=a
set number
let mapleader = "\<Space>"
set directory=~/.vim/swapfiles//

set wildmenu
set wildignorecase

set ignorecase
set smartcase

" Use system clipboard
set clipboard=unnamedplus
" Don't lose undo history when switching buffers
set hidden

nnoremap <Leader>fs :w<CR>
nnoremap <Leader>gs :Gstatus<CR>

nnoremap <Leader>pf :Telescope find_files<CR>
nnoremap <Leader>bs :Telescope buffers<CR>
nnoremap <Leader>ls :Telescope live_grep<CR>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <Leader>wj <C-W><C-J>
nnoremap <Leader>wk <C-W><C-K>
nnoremap <Leader>wl <C-W><C-L>
nnoremap <Leader>wh <C-W><C-H>

noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$
onoremap <silent> j gj
onoremap <silent> k gk

map <Leader>b :silent !rust-watch notify<CR>

" hi StatusLine cterm=bold ctermfg=white ctermbg=6
" hi StatusLineNC cterm=None ctermfg=1 ctermbg=8
hi VertSplit cterm=None ctermfg=8 ctermbg=8
hi LineNr ctermfg=4
hi Folded ctermbg=darkgray

hi CursorLine cterm=NONE
set cursorline

let g:rainbow_active = 1
set t_ti=
set t_te=

let g:ctrlp_custom_ignore = 'all_data'

"" gitgutter
nmap <Leader>gp <Plug>(GitGutterPrevHunk)
nmap <Leader>gn <Plug>(GitGutterNextHunk)
let g:gitgutter_override_sign_column_highlight = 1
let g:gitgutter_highlight_linenrs = 1

hi GitGutterAdd ctermfg=Green
hi GitGutterChange ctermfg=Yellow
hi GitGutterDelete ctermfg=Red
hi GitGutterChangeDelete ctermfg=Red

hi GitGutterAddLineNr ctermfg=Green
hi GitGutterChangeLineNr ctermfg=Yellow
hi GitGutterDeleteLineNr ctermfg=Red
hi GitGutterChangeDeleteLineNr ctermfg=Red

" autocmd FileType rust setlocal omnifunc=lsp#omni#complete
autocmd FileType rust setlocal tabstop=4
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <Leader>wj <C-W><C-J>
nnoremap <Leader>wk <C-W><C-K>
nnoremap <Leader>wl <C-W><C-L>
nnoremap <Leader>wh <C-W><C-H>

noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$
onoremap <silent> j gj
onoremap <silent> k gk

map <Leader>b :silent !rust-watch notify<CR>


sign define LspDiagnosticsSignError text=E texthl=LspDiagnosticsError linehl= numhl=
sign define LspDiagnosticsSignWarning text=W texthl=LspDiagnosticsWarning linehl= numhl=
sign define LspDiagnosticsSignInformation text=I texthl=LspDiagnosticsInformation linehl= numhl=
sign define LspDiagnosticsSignHint text=H texthl=LspDiagnosticsHint linehl= numhl=
hi LspDiagnosticsError ctermfg=red 
hi LspDiagnosticsWarning ctermfg=yellow
hi LspDiagnosticsInformation ctermfg=green
hi LspDiagnosticsHint ctermfg=blue
" hi LspDiagnosticsErrorFloat ctermfg=red ctermfg=green
" hi LspDiagnosticsDefaultHint ctermfg=red
hi LspDefaultInformation ctermfg=blue
hi LspDiagnosticsDefaultError ctermfg=red cterm=italic
hi LspDiagnosticsDefaultWarning ctermfg=yellow cterm=italic
hi LspDiagnosticsDefaultInformation ctermfg=green cterm=italic
hi LspDiagnosticsDefaultHint ctermfg=blue cterm=italic
" hi LspDiagnosticsVirtualTextError ctermfg=blue
" hi LspDiagnosticsVirtualTextWarning ctermfg=blue
" hi LspDiagnosticsVirtualTextInformation ctermfg=blue
" hi LspDiagnosticsVirtualTextHint ctermfg=blue

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
" set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

lua <<EOF
    require('config')
EOF

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <Tab> as trigger keys
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hold
" autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
" nnoremap <silent> <leader>e    <cmd>lua vim.lsp.diagnostics.show_line_diagnostics()<CR>

hi LspReferenceText ctermbg=darkgrey gui=bold
hi LspReferenceRead ctermbg=darkgrey gui=bold
hi LspReferenceWrite ctermbg=darkgrey gui=bold

" autocmd CursorHold  * lua vim.lsp.buf.document_highlight()
" autocmd CursorHoldI * lua vim.lsp.buf.document_highlight()
" autocmd CursorMoved * lua vim.lsp.buf.clear_references()

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

set signcolumn=yes

hi LspTypeInlayHint ctermfg=darkgrey cterm=italic

" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = ' § ', highlight = "LspTypeInlayHint" }

set termguicolors
