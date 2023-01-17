local km_opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", km_opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", km_opts)
keymap("n", "<C-j>", "<C-w>j", km_opts)
keymap("n", "<C-k>", "<C-w>k", km_opts)
keymap("n", "<C-l>", "<C-w>l", km_opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", km_opts)
keymap("n", "<C-Down>", ":resize +2<CR>", km_opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", km_opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", km_opts)

-- Navigate buffers
keymap("n", "gl", ":bnext<CR>", km_opts)
keymap("n", "gh", ":bprevious<CR>", km_opts)

-- Move text up and down
-- keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
-- keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", km_opts)
keymap("v", ">", ">gv", km_opts)

-- Move text up and down
-- keymap("v", "<A-j>", ":m .+1<CR>==", opts)
-- keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', km_opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", km_opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", km_opts)
-- keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- LSP kms
vim.api.nvim_exec([[
    nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
    inoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
    nnoremap <silent> gR    <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> gf    <cmd>lua vim.lsp.buf.formatting()<CR>
    nnoremap <silent> e     <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

    nnoremap <silent> gE    :Telescope diagnostics<CR>
    nnoremap <silent> ge    :Telescope diagnostics bufnr=0<CR>

    nnoremap <silent> gj    <cmd>lua require'overloads'.colors({layout_strategy='vertical'})<CR>
]], false);

local wk = require "which-key"

wk.setup({})
local mappings = {
  [" "] = { "<cmd>w!<cr>", "Save" },
  f = {
    name = "file",
    f = { "<cmd>w!<cr>", "Save" },
    e = { "<cmd>NvimTreeFocus<cr>", "Explorer" },
    E = { "<cmd>NvimTreeClose<CR>", "Close explorer" },
    s = {
      "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
      "Find files",
    },
  },
  s = {
    name = "Search",
    b = { "<cmd>Telescope buffers<cr>", "Search buffers" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    g = { "<cmd>Telescope live_grep<cr>", "Grep" },
  },
  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Actions" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    R = { "<cmd>lua vim.lsp.buf.references()<cr>", "References" },
    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
    t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type definition" },
    g = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition" },
    d = {
      "<cmd>Telescope diagnostics bufnr=0<CR>",
      "Document Diagnostics",
    },
    w = {
      "<cmd>Telescope diagnostics<CR>",
      "Workspace Diagnostics",
    },
    i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to implementation" },
    j = {
      "<cmd>lua vim.diagnostic.goto_next()<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
      "Prev Diagnostic",
    },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
    h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
  },
  g = {
    name = "Git",
    s = { "<cmd>Git<CR>", "Status" },
    g = { "<cmd>Git<CR>", "Status" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    S = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
  },
}

local opts = {
  prefix = "<leader>",
  nowait = true,
}

wk.register(mappings, opts)
require('Comment').setup()
