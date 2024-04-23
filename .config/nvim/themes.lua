return {
    --"Yazeed1s/oh-lucy.nvim",
    --config = function()
    --    vim.cmd([[colorscheme oh-lucy-evening]])
    --end
    --"aktersnurra/no-clown-fiesta.nvim",
    --config = function()
    --    vim.cmd([[colorscheme no-clown-fiesta]])
    --end
    "sainnhe/gruvbox-material",
    config = function()
        vim.cmd([[
            " Important!!
            if has('termguicolors')
              set termguicolors
            endif

            " For dark version.
            set background=dark

            " Set contrast.
            " This configuration option should be placed before `colorscheme gruvbox-material`.
            " Available values: 'hard', 'medium'(default), 'soft'
            let g:gruvbox_material_background = 'hard'

            " For better performance
            " let g:gruvbox_material_better_performance = 1

            colorscheme gruvbox-material
        ]])
    end
    --"rebelot/kanagawa.nvim",
    --config = function()
    --    require('kanagawa').setup({
    --        theme = "dragon",
    --        background = {
    --            dark = "dragon",
    --            light = "dragon"
    --        }
    --    })
    --    vim.cmd([[
    --        set background=dark
    --        colorscheme kanagawa
    --    ]])
    --end
    --"mcchrish/zenbones.nvim",
    --dependencies = {
    --    "rktjmp/lush.nvim"
    --},
    --config = function()
    --    vim.cmd([[
    --        if has('termguicolors')
    --          set termguicolors
    --        endif
    --        set background=dark
    --        colorscheme forestbones
    --    ]])
    --end
}
