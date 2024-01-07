local lsp_zero = require("lsp-zero")
require("mason").setup()
require('mason-lspconfig').setup({
  handlers = {
    lsp_zero.default_setup,
  },
  -- ensure_installed = { "lua_ls" }
})

-- autocompletion mappings
local cmp = require('cmp')
cmp.setup({
    sources = {
        {name = 'nvim_lsp'},
        {name = 'luasnip'}
    },
    mapping = {
        ['C-l'] = cmp.mapping.confirm({select = false}),
        ['<CR>'] = cmp.mapping.confirm({select = false}),
        ['C-k'] = cmp.mapping.select_prev_item({behavior = 'select'}),
        ['C-j'] = cmp.mapping.select_next_item({behavior = 'select'})
    }
})
