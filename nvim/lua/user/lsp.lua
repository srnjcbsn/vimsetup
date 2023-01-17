local nvim_lsp = require'lspconfig'
local lsp_installer = require("nvim-lsp-installer")

local on_attach = function(client, bufnr)
  local opts = { noremap=true, silent=true }
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- client.capabilities = cmp_nvim_capabilities

  -- if client.resolved_capabilities.document_formatting then
  --   buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  -- end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  if client.server_capabilities.signatureHelpProvider then
    require('lsp-overloads').setup(client, { })
  end

  -- TODO: this keeps not working
  -- if client.resolved_capabilities.document_highlight then
  --   vim.api.nvim_exec([[
  --     hi LspReferenceRead cterm=bold ctermbg=red
  --     hi LspReferenceText cterm=bold ctermbg=red
  --     hi LspReferenceWrite cterm=bold ctermbg=red
  --     augroup lsp_document_highlight
  --       autocmd! * <buffer>
  --       autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
  --       autocmd CursorHoldI * lua vim.lsp.buf.document_highlight()
  --       autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  --     augroup END
  --   ]], false)
  -- end
end

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

local cmp_nvim_capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Register a handler that will be called for all installed servers.
lsp_installer.on_server_ready(function(server)
    local opts = {on_attach = on_attach, capabilities = cmp_nvim_capabilities}
    if enhance_server_opts[server.name] then
      enhance_server_opts[server.name](opts)
    end
    server:setup(opts)
end)

vim.lsp.handlers["textDocument/references"]     = require'telescope.builtin'.lsp_references
vim.lsp.handlers["textDocument/implementation"] = require'telescope.builtin'.lsp_implementations
vim.lsp.handlers['textDocument/codeAction']     = require'telescope.builtin'.lsp_code_actions
-- vim.lsp.handlers['textDocument/definition']     = require'telescope.builtin'.lsp_definitions
vim.lsp.handlers['textDocument/documentSymbol'] = require'telescope.builtin'.lsp_document_symbols
-- vim.lsp.handlers['textDocument/workspaceSymbol'] = require'telescope.builtin'.lsp_document_symbols
vim.lsp.handlers['workspace/symbol']            = require'telescope.builtin'.lsp_workspace_symbols
vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = false
  }
)

vim.api.nvim_exec([[
  sign define DiagnosticsSignError text=U texthl=LspDiagnosticsError linehl= numhl=
  sign define DiagnosticsSignWarning text=W texthl=LspDiagnosticsWarning linehl= numhl=
  sign define DiagnosticsSignInformation text=I texthl=LspDiagnosticsInformation linehl= numhl=
  sign define DiagnosticsSignHint text=H texthl=LspDiagnosticsHint linehl= numhl=
  hi LspDiagnosticsError ctermfg=green
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
]], false)
