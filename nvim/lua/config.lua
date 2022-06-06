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

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    formatting = {
      format = require'lspkind'.cmp_format(),
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      },
      sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
        }, {
          { name = 'buffer' },
        })
    })
  local cmp_nvim_capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Set default client capabilities plus window/workDoneProgress
local on_attach = function(client, bufnr)
  require'completion'.on_attach(client)
  local opts = { noremap=true, silent=true }
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- client.capabilities = cmp_nvim_capabilities

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

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
    underline = true,
  })


require('telescope').setup{
  defaults = {
    generic_sorter = require'telescope.sorters'.get_fzy_sorter,
    -- path_display = "tail",
    path_display = function(opts, path)
                  local tail = require("telescope.utils").path_tail(path)
                  return string.format("%s (%s)", tail, path)
                end,
  }
}

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

vim.api.nvim_exec([[
    " Code navigation shortcuts
    nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
    inoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
    nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
    nnoremap <silent> gR    <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
    nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
    nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> gf    <cmd>lua vim.lsp.buf.formatting()<CR>
    nnoremap <silent> e     <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

    nnoremap <silent> gr    <cmd>lua vim.lsp.buf.rename()<CR>
    nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
    nnoremap <silent> ga    :Telescope lsp_code_actions<CR>
    nnoremap <silent> gE    :Telescope diagnostics<CR>
    nnoremap <silent> ge    :Telescope diagnostics bufnr=0<CR>

    nnoremap <silent> gj    <cmd>lua require'overloads'.colors({layout_strategy='vertical'})<CR>
]], false);

-- map('n', '<leader>j', '<cmd>lua  vim.lsp.buf.rename()<CR>')
-- map('n', '<leader>j', '<cmd>lua :vim.inspect({})colors()<CR>')

vim.lsp.handlers["textDocument/references"]     = require'telescope.builtin'.lsp_references
vim.lsp.handlers["textDocument/implementation"] = require'telescope.builtin'.lsp_implementations
vim.lsp.handlers['textDocument/codeAction']     = require'telescope.builtin'.lsp_code_actions
-- vim.lsp.handlers['textDocument/definition']     = require'telescope.builtin'.lsp_definitions
vim.lsp.handlers['textDocument/documentSymbol'] = require'telescope.builtin'.lsp_document_symbols
-- vim.lsp.handlers['textDocument/workspaceSymbol'] = require'telescope.builtin'.lsp_document_symbols
vim.lsp.handlers['workspace/symbol']            = require'telescope.builtin'.lsp_workspace_symbols

local csharp_setup = function()
  local bin_folder = vim.fn.stdpath("data")
  local omnisharp_bin = bin_folder .. "/lsp_servers/omnisharp/omnisharp/run"

  return {
      cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(vim.fn.getpid()) },
      on_attach = on_attach,
      capabilities = cmp_nvim_capabilities,
  }
end

local lua_setup = function()
  local sumneko_binary = vim.fn.stdpath('data')..'/lsp_servers/sumneko_lua/extension/server/bin/Linux/lua-language-server'

  return {
    cmd = {sumneko_binary},
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

-- nvim_lsp.pyright.setup({ on_attach = on_attach, capabilities = cmp_nvim_capabilities })
-- nvim_lsp.rust_analyzer.setup({ on_attach = on_attach, cmd = { "/home/sja/.local/share/nvim/lspinstall/rust/rust-analyzer" }, capabilities = cmp_nvim_capabilities})
-- nvim_lsp.sumneko_lua.setup(lua_setup())
-- nvim_lsp.omnisharp.setup(csharp_setup())
-- nvim_lsp.tsserver.setup{}
-- nvim_lsp.bashls.setup({ on_attach = on_attach, capabilities = cmp_nvim_capabilities })

local lsp_installer = require("nvim-lsp-installer")

local enhance_server_opts = {
  ["rust-analyzer"] = function(opts)
    opts.settings = {
      ['rust-analyzer'] = {
        checkOnSave = {
          enable = true,
          allFeatures = true,
          overrideCommand = {
            'cargo', 'clippy', '--workspace', '--message-format=json',
            '--all-targets', '--all-features'
          }
        }
      }
    }
  end,
  ["tsserver"] = function(opts)
    opts.settings = {
      on_attach = on_attach,
      root_dir = nvim_lsp.util.root_pattern("package.json"),
      init_options = {
        lint = true,
      },
    }
  end
}

-- Register a handler that will be called for all installed servers.
lsp_installer.on_server_ready(function(server)
    local opts = {on_attach = on_attach, capabilities = cmp_nvim_capabilities}
    if enhance_server_opts[server.name] then
      enhance_server_opts[server.name](opts)
    end
    server:setup(opts)
end)

-- COMPLETION

require('vim.lsp.protocol').CompletionItemKind = {

  '⁋', -- Text
  'λ', -- Method
  'ƒ', -- Function
  '+', -- Constructor
  '', -- Field
  'α', -- Variable
  '', -- Class
  '', -- Interface
  '', -- Module
  '', -- Property
  ' ᪾', -- Unit
  '', -- Value
  '', -- Enum
  '⁕', -- Keyword
  '↬', -- Snippet
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
  -- '', -- Text
  -- '', -- Method
  -- 'ƒ', -- Function
  -- '+', -- Constructor
  -- '', -- Field
  -- '', -- Variable
  -- '', -- Class
  -- '', -- Interface
  -- '', -- Module
  -- '', -- Property
  -- '', -- Unit
  -- '', -- Value
  -- '', -- Enum
  -- '', -- Keyword
  -- '﬌', -- Snippet
  -- '', -- Color
  -- '', -- File
  -- '&', -- Reference
  -- '', -- Folder
  -- '', -- EnumMember
  -- '', -- Constant
  -- '', -- Struct
  -- 'e', -- Event
  -- 'o', -- Operator
  -- 'T', -- TypeParameter
}
--     פּ
--    料

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
    lualine_x = { {'diagnostics', sources = {'nvim_diagnostic'}, symbols = {error = '', warn = '', info = ''} }, 'encoding', 'fileformat', 'filetype' },
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

-- DAP
local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode-10', -- adjust as needed
  name = "lldb"
}

local dap = require('dap')
dap.configurations.rust = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    -- program = function()
    --   return vim.fn.getcwd() .. '/target/debug
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
  },
}

dap.adapters.netcoredbg = {
  type = 'executable',
  command = '/home/sja/Downloads/netcoredbg/netcoredbg',
  args = {'--interpreter=vscode'}
}

dap.configurations.cs = {
  {
    type = "netcoredbg",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
  },
}


-- DAP
-- require('telescope').load_extension('dap')
function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- local opts = { noremap=true, silent=true }
-- local function map(mode, lhs, rhs, opts) vim.api.nvim_buf_set_keymap(mode, lhs, rhs, {noremap = true}) end

map('n', '<leader>dct', '<cmd>lua require"dap".continue()<CR>')
map('n', '<F5>', '<cmd>lua require"dap".continue()<CR>')
map('n', '<leader>dsv', '<cmd>lua require"dap".step_over()<CR>')
map('n', '<F10>', '<cmd>lua require"dap".step_over()<CR>')
map('n', '<leader>dsi', '<cmd>lua require"dap".step_into()<CR>')
map('n', '<F11>', '<cmd>lua require"dap".step_into()<CR>')
map('n', '<leader>dso', '<cmd>lua require"dap".step_out()<CR>')
map('n', '<leader>dtb', '<cmd>lua require"dap".toggle_breakpoint()<CR>')

map('n', '<leader>dsc', '<cmd>lua require"dap.ui.variables".scopes()<CR>')
map('n', '<leader>dhh', '<cmd>lua require"dap.ui.variables".hover()<CR>')
map('v', '<leader>dhv', '<cmd>lua require"dap.ui.variables".visual_hover()<CR>')

map('n', '<leader>duh', '<cmd>lua require"dap.ui.widgets".hover()<CR>')
map('n', '<leader>duf', "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>")

map('n', '<leader>dsbr',
    '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
map('n', '<leader>dsbm',
    '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>')
map('n', '<leader>dro', '<cmd>lua require"dap".repl.open()<CR>')
map('n', '<leader>drl', '<cmd>lua require"dap".repl.run_last()<CR>')


-- telescope-dap
map('n', '<leader>dcc',
    '<cmd>lua require"telescope".extensions.dap.commands{}<CR>')
map('n', '<leader>dco',
    '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>')
map('n', '<leader>dlb',
    '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>')
map('n', '<leader>dv',
    '<cmd>lua require"telescope".extensions.dap.variables{}<CR>')
map('n', '<leader>df',
          '<cmd>lua require"telescope".extensions.dap.frames{}<CR>')
-- nvim-dap-virtual-text. Show virtual text for current frame
vim.g.dap_virtual_text = true

-- nvim-dap-ui
require("dapui").setup()
map('n', '<leader>dui', '<cmd>lua require"dapui".toggle()<CR>')
-- { {
--     result = {
--       activeParameter = 0,
--       activeSignature = 2,
--       signatures = { {
--           documentation = '\n      <summary>Creates a new instance of the <see cref="T:System.Net.Http.StringContent" /> class.</summary>\n      <param name="content">The content used to initialize the <see cref="T:System.Net.Http.StringContent" />.</para
-- m>\n    ',
--           label = "StringContent.StringContent(string content)",
--           parameters = { {
--               documentation = "The content used to initialize the System.Net.Http.StringContent .",
--               label = "string content"
--             } }
--         }, {
--           documentation = '\n      <summary>Creates a new instance of the <see cref="T:System.Net.Http.StringContent" /> class.</summary>\n      <param name="content">The content used to initialize the <see cref="T:System.Net.Http.StringContent" />.</para
-- m>\n      <param name="encoding">The encoding to use for the content.</param>\n    ',
--           label = "StringContent.StringContent(string content, Encoding? encoding)",
--           parameters = { {
--               documentation = "The content used to initialize the System.Net.Http.StringContent .",
--               label = "string content"
--             }, {
--               documentation = "The encoding to use for the content.",
--               label = "Encoding? encoding"
--             } }
--         }, {
--           documentation = '\n      <summary>Creates a new instance of the <see cref="T:System.Net.Http.StringContent" /> class.</summary>\n      <param name="content">The content used to initialize the <see cref="T:System.Net.Http.StringContent" />.</para
-- m>\n      <param name="encoding">The encoding to use for the content.</param>\n      <param name="mediaType">The media type to use for the content.</param>\n    ',
--           label = "StringContent.StringContent(string content, Encoding? encoding, string? mediaType)",
--           parameters = { {
--               documentation = "The content used to initialize the System.Net.Http.StringContent .",
--               label = "string content"
--             }, {
--               documentation = "The encoding to use for the content.",
--               label = "Encoding? encoding"
--             }, {
--               documentation = "The media type to use for the content.",
--               label = "string? mediaType"
--             } }
--         } }
--     }
--   } }
