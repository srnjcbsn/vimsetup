----------------------------
-- TODO: show signatures: --
----------------------------
-- textDocument/completion does not list overloads for c#, need to use textDocument/signatureHelp:
-- lua print(vim.inspect(vim.lsp.buf_request_sync(gh, "textDocument/signatureHelp", {position = { line = 57, character = 42 }, textDocument = { uri = "file:///home/sja/git/BlobStore/BlobStore.Shim/Services/RealBlobStoreService.cs" }})))
-- Maybe use Telescope? (https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md)
-- Nvim lsp api: https://neovim.io/doc/user/lsp.html#lsp-core
-- LSP log: .cache/nvim/lsp.log

local pickers = require "telescope.pickers"
local previewers = require "telescope.previewers"
local previewers_utils = require "telescope.previewers.utils"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

local plenary = require "plenary"

local M = {}

local function map(tbl, f)
    local t = {}
    for k,v in pairs(tbl) do
        t[k] = f(v)
    end
    return t
end

local colors = function(opts)
  opts = opts or {}

  local r, c = unpack(vim.api.nvim_win_get_cursor(0))

  local path = 'file://' .. vim.fn.getcwd() .. '/' .. vim.fn.expand('%')

  local req = {
    position = {
      line = r - 1,
      character = c,
    },
    textDocument = { uri = path }
  }

  local resp = vim.lsp.buf_request_sync(0, "textDocument/signatureHelp", req)
  local results = resp[1].result.signatures
  if (results == nil) then return nil end
  table.sort(results, function (a, b) return string.len(a.label) < string.len(b.label) end)

  pickers.new(opts, {
    prompt_title = "overloads",
    finder = finders.new_table {
      results = resp[1].result.signatures,
      entry_maker = function(entry)
        return {
          value = entry.documentation,
          display = entry.label,
          ordinal = string.len(entry.label),
        }
      end
    },
    previewer = previewers.new_buffer_previewer {
      define_preview = function (self, entry, status)
        local s = entry.value
        -- local lines = { "      <name>"..entry.display.."</name>"}
        local lines = {}
        for s in string.gmatch(s, "[^\r\n]+") do
          table.insert(lines, s)
        end
        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, 0, false, lines)
        previewers_utils.highlighter(self.state.bufnr, "xml")
      end
    },
    sorter = conf.generic_sorter(opts),
  }):find()
end

M.colors = colors
return M

