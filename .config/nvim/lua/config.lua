-- TREESITTER
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,
    custom_captures = {
      ["ff"] = "Function",
    },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}

-- LSP
vim.lsp.set_log_level("debug")
local nvim_lsp = require'lspconfig'

-- Set default client capabilities plus window/workDoneProgress
local on_attach = function(client, bufnr)
  require'completion'.on_attach(client)

  local opts = { noremap=true, silent=true }
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end
    -- vim.cmd [[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()]]
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red
      hi LspReferenceText cterm=bold ctermbg=red
      hi LspReferenceWrite cterm=bold ctermbg=red
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorHoldI * lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  })


vim.api.nvim_exec([[
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
    nnoremap <silent> e     <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

    nnoremap <silent> gr    <cmd>lua vim.lsp.buf.rename()<CR>
    nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
    nnoremap <silent> gE    :Telescope lsp_workspace_diagnostics<CR>
]], false);

vim.lsp.handlers["textDocument/references"]     = require'telescope.builtin'.lsp_references
vim.lsp.handlers["textDocument/implementation"] = require'telescope.builtin'.lsp_implementations
vim.lsp.handlers['textDocument/codeAction']     = require'telescope.builtin'.lsp_code_actions
vim.lsp.handlers['textDocument/definition']     = require'telescope.builtin'.lsp_definitions
vim.lsp.handlers['textDocument/documentSymbol'] = require'telescope.builtin'.lsp_document_symbols
-- vim.lsp.handlers['textDocument/workspaceSymbol'] = require'telescope.builtin'.lsp_document_symbols
vim.lsp.handlers['workspace/symbol']            = require'telescope.builtin'.lsp_workspace_symbols

local csharp_setup = function()
  local pid = vim.fn.getpid()
  local omnisharp_bin = "/home/sja/omnisharp/run"

  return {
      cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
      on_attach = on_attach,
  }
end

local lua_setup = function()
  local sumneko_root_path = vim.fn.stdpath('data')..'/lspinstall/lua/sumneko-lua'
  local sumneko_binary = vim.fn.stdpath('data')..'/lspinstall/lua/sumneko-lua-language-server'

  return {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    on_attach = on_attach,
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = vim.split(package.path, ';'),
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          },
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  }
end

nvim_lsp.pyright.setup({ on_attach = on_attach })
nvim_lsp.rust_analyzer.setup({ on_attach = on_attach })
nvim_lsp.sumneko_lua.setup(lua_setup())
nvim_lsp.omnisharp.setup(csharp_setup())

-- COMPLETION

require('vim.lsp.protocol').CompletionItemKind = {
  '', -- Text
  '', -- Method
  'ƒ', -- Function
  '+', -- Constructor
  '', -- Field
  '', -- Variable
  '', -- Class
  '', -- Interface
  '', -- Module
  '', -- Property
  '', -- Unit
  '', -- Value
  '', -- Enum
  '', -- Keyword
  '﬌', -- Snippet
  '', -- Color
  '', -- File
  '&', -- Reference
  '', -- Folder
  '', -- EnumMember
  '', -- Constant
  '', -- Struct
  'e', -- Event
  'o', -- Operator
  'T', -- TypeParameter
}
--     פּ
--    料

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
  };
}

vim.o.completeopt = "menuone,noselect"

-- STATUSLINE
require('lualine').setup{
  options = {
    theme = 'tokyonight',
    section_separators = '',
    component_separators = '',
    icons_enabled = false,
  },
  sections = {
    lualine_a = { {'mode', upper = true} },
    lualine_b = { {'branch', icon = ''}, {'diff'} },
    lualine_c = { {'filename', file_status = true, full_path = true} },
    lualine_x = { {'diagnostics', sources = {'nvim_lsp'}, symbols = {error = '', warn = '', info = ''} }, 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location'  },
  },
  inactive_sections = {
    lualine_a = {  },
    lualine_b = {  },
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {  },
    lualine_z = {   }
  },
  extensions = { 'fzf' }
}
