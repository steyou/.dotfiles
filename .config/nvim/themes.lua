return function(selection)
    return {
        {
            "Yazeed1s/oh-lucy.nvim",
            cond = selection == "lucy",
            config = function()
                vim.cmd([[colorscheme oh-lucy-evening]])
            end
        },
        {
            "aktersnurra/no-clown-fiesta.nvim",
            cond = selection == "noclown",
            config = function()
                vim.cmd([[colorscheme no-clown-fiesta]])
            end
        },
        {
            "sainnhe/gruvbox-material",
            cond = selection == "gruvbox",
            config = function()
                vim.cmd([[
                    " Important!!
                    if has('termguicolors')
                      set termguicolors
                    endif

                    " For dark version.
                    set background=dark

                    " Available values: 'hard', 'medium'(default), 'soft'
                    let g:gruvbox_material_background = 'hard'

                    colorscheme gruvbox-material
                ]])
            end
        },
        {
            "rebelot/kanagawa.nvim",
            cond = selection == "kanagawa",
            config = function()
                require('kanagawa').setup({
                    theme = "dragon",
                    background = {
                        dark = "dragon",
                        light = "dragon"
                    }
                })
                vim.cmd([[
                    set background=dark
                    colorscheme kanagawa
                ]])
            end
        },
        {
            "mcchrish/zenbones.nvim",
            cond = selection == "zenbones",
            dependencies = {
                "rktjmp/lush.nvim"
            },
            config = function()
                vim.cmd([[
                    if has('termguicolors')
                      set termguicolors
                    endif
                    set background=dark
                    colorscheme kanagawabones
                ]])
            end
        },
        {
            "Mofiqul/dracula.nvim",
            cond = selection == "dracula",
            config = function()
                vim.cmd([[
                    "set termguicolors
                    colorscheme dracula
                ]])
            end
        },
        {
            "miikanissi/modus-themes.nvim",
            cond = selection == "modus",
            config = function()
                vim.cmd([[colorscheme modus]])
            end
        },
        {
            "whatyouhide/vim-gotham",
            cond = selection == "gotham",
            config = function()
                vim.cmd([[
                    set termguicolors
                    colorscheme gotham256
                ]])
            end
        },
        {
            "EdenEast/nightfox.nvim",
            cond = selection == "nightfox",
            config = function()
                vim.cmd([[
                    set termguicolors
                    set background=dark
                    colorscheme carbonfox
                ]])
            end
        },
        {
            "eemed/sitruuna.vim",
            cond = selection == "lemon",
            config = function()
                vim.cmd([[
                    colorscheme sitruuna
                ]])
            end
        },
        {
            "mellow-theme/mellow.nvim",
            cond = selection == "mellow",
            config = function()
                vim.cmd([[
                    set termguicolors
                    colorscheme mellow
                ]])
            end
        },
        {
            "nyoom-engineering/oxocarbon.nvim",
            cond = selection == "oxo",
            config = function()
                vim.cmd([[
                    set termguicolors
                    set background=dark
                    colorscheme oxocarbon
                ]])
            end
        },
        {
            "metalelf0/jellybeans-nvim",
            cond = selection == "jellybeans",
            dependencies = {
                "rktjmp/lush.nvim",
            },
            config = function()
                vim.cmd([[
                    set termguicolors
                    colorscheme jellybeans-nvim
                ]])
            end
        },
        {
            "p00f/alabaster.nvim",
            cond = selection == "alabaster",
            config = function()
                vim.cmd([[
                    set termguicolors
                    set background=dark
                    colorscheme alabaster
                ]])
                vim.g.alabaster_dim_comments=true
            end
        },
        {
          'sainnhe/everforest',
          cond = selection == "everforest",
          config = function()
            -- Optionally configure and load the colorscheme
            -- directly inside the plugin declaration.
            -- vim.g.everforest_enable_italic = true
            vim.cmd.colorscheme('everforest')
          end
        },
        {
            "gmr458/cold.nvim",
            cond = selection == "cold",
            config = function()
                vim.cmd.colorscheme('cold')
            end
        }
    }
end
