set t_Co=8
set nocompatible
colorscheme delek

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
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'rust-lang/rust.vim'
call plug#end()

filetype plugin indent on
syntax on

set backspace=indent,eol,start
set mouse=a
set number
let mapleader = "\<Space>"
set directory=~/.vim/swapfiles//

set wildmenu
set wildignorecase

nnoremap <Leader>fs :w<CR>
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

hi StatusLine cterm=bold ctermfg=7 ctermbg=6
hi StatusLineNC cterm=None ctermfg=1 ctermbg=8
hi VertSplit cterm=None ctermfg=8 ctermbg=8
hi LineNr ctermfg=4
hi Folded ctermbg=darkgray

hi LspWarningHighlight cterm=underline
" hi clear LspWarningHighlight 
hi LspErrorHighlight ctermfg=Red
hi LspInformationHighlight ctermbg=DarkBlue
hi LspHintHighlight ctermbg=Green

hi Pmenu ctermbg=LightBlue

 " hi LspHintText ctermbg=Red
" hi LspInformationText ctermbg=Red
" hi LspInformationLine ctermbg=Red
" hi LspHintLine ctermbg=Red
" hi LspErrorLine ctermbg=Red
hi LspWarningText ctermfg=DarkYellow
hi LspInformationText ctermfg=DarkBlue
hi LspErrorText ctermfg=DarkRed
" hi LspErrorText ctermbg=Red

hi CursorLine cterm=NONE
set cursorline

let g:rainbow_active = 1
set t_ti=
set t_te=

if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
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
