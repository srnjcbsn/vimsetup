" set t_Co=8
set nocompatible
" colorscheme delek

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
" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'rust-lang/rust.vim'
Plug 'OmniSharp/omnisharp-vim'

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Extensions to built-in LSP, for example, providing type inlay hints
Plug 'tjdevries/lsp_extensions.nvim'

" Autocompletion framework for built-in LSP
Plug 'nvim-lua/completion-nvim'
Plug 'arcticicestudio/nord-vim'
Plug 'rafi/awesome-vim-colorschemes'
call plug#end()

colorscheme abstract

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
nnoremap <Leader>mgg :LspDefinition<CR>
nnoremap <Leader>mgG :LspPeekDefinition<CR>
nnoremap <Leader>mh :LspHover<CR>
nnoremap <Leader>mf :LspDocumentFormat<CR>
nnoremap <Leader>mR :LspRename<CR>
nnoremap <Leader>el :LspDocumentDiagnostics<CR>
nnoremap <Leader>ml :LspDocumentSymbol<CR>
nnoremap <Leader>mL :LspWorkspaceSymbol<CR>

nmap <Leader>bb :Buffers<CR>
nmap <Leader>ff :Files<CR>
nmap <Leader>ll :Lines<CR>
nmap <Leader>tt :BTags<CR>
nmap <Leader>ls :BLines<CR>
nmap <Leader>ar :Ranger<CR>

nnoremap <Leader>pf :CtrlPCurWD<CR>
nnoremap <Leader>bs :CtrlPBuffer<CR>

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

hi StatusLine cterm=bold ctermfg=7 ctermbg=6
hi StatusLineNC cterm=None ctermfg=1 ctermbg=8
hi VertSplit cterm=None ctermfg=8 ctermbg=8
hi LineNr ctermfg=4
hi Folded ctermbg=darkgray

" hi LspWarningHighlight cterm=underline
" " hi clear LspWarningHighlight 
" hi LspErrorHighlight ctermfg=Red
" hi LspInformationHighlight ctermbg=DarkBlue
" hi LspHintHighlight ctermbg=Green

" hi Pmenu ctermbg=LightBlue

 " hi LspHintText ctermbg=Red
" hi LspInformationText ctermbg=Red
" hi LspInformationLine ctermbg=Red
" hi LspHintLine ctermbg=Red
" hi LspErrorLine ctermbg=Red
" hi LspWarningText ctermfg=DarkYellow
" hi LspInformationText ctermfg=DarkBlue
" hi LspErrorText ctermfg=DarkRed
" hi LspErrorText ctermbg=Red

hi CursorLine cterm=NONE
set cursorline

let g:rainbow_active = 1
set t_ti=
set t_te=

if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
        \ 'workspace_config': {'rust': {'clippy_preference': 'on'}},
        \ 'whitelist': ['rust'],
        \ })
endif
let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
let g:lsp_preview_float = 1
let g:lsp_signs_error = {'text': '●'}
let g:lsp_signs_warning = {'text': '●'}
let g:lsp_signs_hint = {'text': '●'}
let g:lsp_signs_information = {'text': '●'}

let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')

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

autocmd FileType rust setlocal omnifunc=lsp#omni#complete
autocmd FileType rust setlocal tabstop=4
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>mgg :LspDefinition<CR>
nnoremap <Leader>mgG :LspPeekDefinition<CR>
nnoremap <Leader>mh :LspHover<CR>
nnoremap <Leader>mf :LspDocumentFormat<CR>
nnoremap <Leader>mR :LspRename<CR>
nnoremap <Leader>el :LspDocumentDiagnostics<CR>

nmap <Leader>bb :Buffers<CR>
nmap <Leader>ff :Files<CR>
nmap <Leader>ll :Lines<CR>
nmap <Leader>tt :BTags<CR>
nmap <Leader>ls :BLines<CR>
nmap <Leader>ar :Ranger<CR>

nnoremap <Leader>pf :CtrlPCurWD<CR>
nnoremap <Leader>bs :CtrlPBuffer<CR>

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
" hi LspDiagnosticsFloatingError ctermfg=green

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Configure LSP
" https://github.com/neovim/nvim-lspconfig#rust_analyzer
lua <<EOF

-- nvim_lsp object
local nvim_lsp = require'lspconfig'

-- function to attach completion when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({ on_attach=on_attach })
-- 	capabilities = {
-- 		textDocument = {
-- 			documentHighlight = {
-- 				dynamicRegistration = true
-- 			}
-- 		}
-- 	}
-- })

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

EOF

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <Tab> as trigger keys
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gR    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gf    <cmd>lua vim.lsp.buf.formatting()<CR>

nnoremap <silent> gr    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

hi LspReferenceText ctermbg=darkgrey gui=bold
hi LspReferenceRead ctermbg=darkgrey gui=bold
hi LspReferenceWrite ctermbg=darkgrey gui=bold

autocmd CursorHold  * lua vim.lsp.buf.document_highlight()
autocmd CursorHoldI * lua vim.lsp.buf.document_highlight()
autocmd CursorMoved * lua vim.lsp.buf.clear_references()

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

set signcolumn=yes

hi LspTypeInlayHint ctermfg=darkgrey cterm=italic

" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = ' § ', highlight = "LspTypeInlayHint" }
