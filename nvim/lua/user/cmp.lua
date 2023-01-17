local cmp = require 'cmp'
local luasnip = require 'luasnip'

--local kind_icons = {
--  Text = "",
--  Method = "m",
--  Function = "",
--  Constructor = "",
--  Field = "",
--  Variable = "",
--  Class = "",
--  Interface = "",
--  Module = "",
--  Property = "",
--  Unit = "",
--  Value = "",
--  Enum = "",
--  Keyword = "",
--  Snippet = "",
--  Color = "",
--  File = "",
--  Reference = "",
--  Folder = "",
--  EnumMember = "",
--  Constant = "",
--  Struct = "",
--  Event = "",
--  Operator = "",
--  TypeParameter = "",
--}

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
}

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = {
    format = require 'lspkind'.cmp_format(),
  },
  mapping = {
    ['<Down>'] = cmp.mapping.select_next_item(),
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-e>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
    ['<C-y>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    -- ['<C-e>'] = cmp.mapping({
    --   i = cmp.mapping.abort(),
    --   c = cmp.mapping.close(),
    -- }),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      -- elseif check_backspace() then
      --  fallback()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = "luasnip" },
    { name = "path" },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  })
})
