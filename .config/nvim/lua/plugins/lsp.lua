return {
--- Uncomment these if you want to manage LSP servers from neovim
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},

    {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    {'L3MON4D3/LuaSnip'},
    {
        'saadparwaiz1/cmp_luasnip',
        setup = function ()
            require'cmp'.setup {
            snippet = {
                expand = function(args)
                    require'luasnip'.lsp_expand(args.body)
                end
            }}
        end
    }
}
