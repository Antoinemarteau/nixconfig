-- Setup nvim-cmp.
local cmp = require'cmp'
local imap = require 'utils'.imap

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<A-t>'] = cmp.mapping.select_next_item(),
    ['<A-s>'] = cmp.mapping.select_prev_item(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<A-c>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'path' },      -- For vsnip users.
    { name = 'ultisnips' }, -- For ultisnips users.
  }, {
    { name = 'buffer' },
  })
})

local function confirm_Nth_item(N)
    cmp = require('cmp')
    if not (cmp == nil) then
        for _ = 1, N do
            cmp.select_next_item()
        end
        cmp.confirm()
    end
end

-- mappings for accepting the Nth item in list
imap('<A-v>', function() confirm_Nth_item(1) end)
imap('<A-d>', function() confirm_Nth_item(2) end)
imap('<A-l>', function() confirm_Nth_item(3) end)
imap('<A-j>', function() confirm_Nth_item(4) end)
imap('<A-à>', function() confirm_Nth_item(5) end)
