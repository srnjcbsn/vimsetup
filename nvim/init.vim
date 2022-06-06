" set t_Co=8
set nocompatible

call plug#begin('~/.vim/plugged')
" Plug 'mhinz/vim-signify'
Plug 'nvim-lua/plenary.nvim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vito-c/jq.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'nvie/vim-flake8'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'
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
" Plug 'rust-lang/rust.vim'
" Plug 'OmniSharp/omnisharp-vim'

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

" Extensions to built-in LSP, for example, providing type inlay hints
Plug 'nvim-lua/lsp_extensions.nvim'

" Autocompletion framework for built-in LSP
Plug 'nvim-lua/completion-nvim'
Plug 'arcticicestudio/nord-vim'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'folke/tokyonight.nvim'

" Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 

" Plug 'hrsh7th/nvim-compe'
" Plug 'tami5/lspsaga.nvim'
Plug 'hrsh7th/nvim-cmp'
" Plug 'hrsh7th/cmp-vsnip'
" Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'onsails/lspkind-nvim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-treesitter/playground'
Plug 'vim-test/vim-test'
Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins' }
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'mechatroner/rainbow_csv'
" Plug 'yuki-yano/fern-preview.vim'
" Plug 'ray-x/lsp_signature.nvim'
call plug#end()

" colorscheme jellybeans
" colorscheme tokyonight
colorscheme seoul256-light

filetype plugin indent on
syntax on
let g:netrw_liststyle = 3

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
nnoremap <Leader>gs :Git<CR>

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
autocmd FileType cs setlocal ts=2 sts=2 sw=2 noexpandtab

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


sign define DiagnosticsSignError text=U texthl=LspDiagnosticsError linehl= numhl=
sign define DiagnosticsSignWarning text=W texthl=LspDiagnosticsWarning linehl= numhl=
sign define DiagnosticsSignInformation text=I texthl=LspDiagnosticsInformation linehl= numhl=
sign define DiagnosticsSignHint text=H texthl=LspDiagnosticsHint linehl= numhl=
hi LspDiagnosticsError ctermfg=green
hi LspDiagnosticsWarning ctermfg=yellow
hi LspDiagnosticsInformation ctermfg=green cterm=underline
hi LspDiagnosticsHint ctermfg=blue cterm=underline
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
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost FileType rust
\ lua require'lsp_extensions'.inlay_hints{ prefix = ' § ', highlight = "LspTypeInlayHint" }

set termguicolors

" Tests
let test#csharp#runner = 'dotnettest'
let g:python3_host_prog = '/usr/bin/python3.7'
let g:ultest_not_run_sign = '?'
let g:ultest_pass_sign = '+'
let g:ultest_fail_sign = '#'
let g:ultest_running_sign = '*'

" show signature help
nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>
" or command
nnoremap <silent> gs :Lspsaga signature_help<CR>

"" FERN

function! s:init_fern() abort
  echo "This function is called ON a fern buffer WHEN initialized"

  nmap <buffer> D <Plug>(fern-action-remove)

  " Add any code to customize fern buffer
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END
