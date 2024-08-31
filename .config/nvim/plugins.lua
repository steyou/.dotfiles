return {
-------------------------------------------------------------------------------
-- Appearance Plugins (not theme)
-------------------------------------------------------------------------------
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' }
            },
            sections = {
                lualine_b = {},
                lualine_c = {'filename', 'diff'},
                lualine_x = {'diagnostics', 'encoding'}
            }
        },
        config = true
    },
    {
        "lewis6991/gitsigns.nvim",
        cmd = "Gitsigns",
        event = {"BufRead", "BufWritePost", "BufEnter"}, -- necessary
        opts = {
            signs = {
                add = { text = '+' },
                --add = { text = '\"' },
                change = { text = '~' },
                delete = { text = '-' },
                topdelete = { text = '-' },
                changedelete = { text = '~' },
                untracked = { text = '┆' },
            }
        },
        config = true,
        main = "gitsigns"
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = { char = "▏" }
        },
        config = true
    },
    {
        'goolord/alpha-nvim',
        dependencies = { 'echasnovski/mini.icons' },
        config = function ()
            require'alpha'.setup(
                require'alpha.themes.startify'.config
            )
            local startify = require'alpha.themes.startify'
            local version_info = vim.version()
            startify.section.header.val = "Neovim v" .. version_info.major .. "." .. version_info.minor .. "." .. version_info.patch
        end
    };
-------------------------------------------------------------------------------
-- LSP Plugins
-------------------------------------------------------------------------------
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
        init = function()
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end
    },
    {
        'hrsh7th/nvim-cmp',
        --event = 'InsertEnter',
        dependencies = {
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'L3MON4D3/LuaSnip'},
            {'hrsh7th/cmp-cmdline'}
        },
        config = function()
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_cmp()

            local cmp = require('cmp')
            cmp.setup({
                formatting = lsp_zero.cmp_format({details = true}),
                mapping = {
                    ['<C-Enter>'] = cmp.mapping.confirm({select = false})
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'buffer' },
                    { name = 'path' },
                    { name = 'luasnip' },
                }
            })
            ---- cmdline : mode
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' },
                },
                {
                    {
                        name = 'cmdline',
                        option = {
                            ignore_cmds = { 'Man', '!' },
                        },
                    },
                }),
            })
            -- cmdline / mode
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })
        end
    },
    {
        'neovim/nvim-lspconfig',
        cmd = 'LspInfo',
        event = {'BufReadPre', 'BufNewFile'},
        dependencies = {
            {'hrsh7th/cmp-nvim-lsp'}
        },
        config = function()
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function(client, bufnr)
                lsp_zero.default_keymaps({buffer = bufnr})
            end)

            require('lspconfig').clangd.setup({
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=never",
                    "--completion-style=detailed"
                },
                init_options = {
                    usePlaceholders = true,
                    completeUnimported = true,
                    clangdFileStatus = true,
                    semanticHighlighting = true
                },
            })
            require('lspconfig').texlab.setup({})
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {"lua", "cpp", "rust"},
                sync_install = false,
                highlight = { enable = true, disable = {"latex"}},
                indent = { enable = true },
            })
        end
    },
    {
      "hedyhli/outline.nvim",
      config = function()
        -- Example mapping to toggle outline
        vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>",
          { desc = "Toggle Outline" })

        require("outline").setup {
          -- Your setup opts here (leave empty to use defaults)
          symbol_folding = {
            -- Depth past which nodes will be folded by default. Set to false to unfold all on open.
            autofold_depth = 2
            -- autofold_depth = false
          }
        }
      end,
    },
    -- {
    --     'stevearc/aerial.nvim',
    --     config = function()
    --         require("aerial").setup()
    --         vim.keymap.set("n", "<leader>o", vim.cmd.AerialToggle, { desc = "Toggle outline" })
    --     end,
    --     dependencies = {
    --         "nvim-treesitter/nvim-treesitter",
    --         "nvim-tree/nvim-web-devicons"
    --     },
    -- },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {}
    },
-------------------------------------------------------------------------------
-- Tools
-------------------------------------------------------------------------------
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
    },
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end
    },
    --{
    --    "ThePrimeagen/harpoon",
    --    branch = "harpoon2",
    --    config = function()
    --        local harpoon = require("harpoon")

    --        harpoon:setup({
    --            -- Setting up custom behavior for a list named "cmd"
    --            "cmd" = {

    --                -- When you call list:add() this function is called and the return
    --                -- value will be put in the list at the end.
    --                --
    --                -- which means same behavior for prepend except where in the list the
    --                -- return value is added
    --                --
    --                -- @param possible_value string only passed in when you alter the ui manual
    --                add = function(possible_value)
    --                    -- get the current line idx
    --                    local idx = vim.fn.line(".")

    --                    -- read the current line
    --                    local cmd = vim.api.nvim_buf_get_lines(0, idx - 1, idx, false)[1]
    --                    if cmd == nil then
    --                        return nil
    --                    end

    --                    return {
    --                        value = cmd--,
    --                        -- context = { ... any data you want ... },
    --                    }
    --                end--,

    --                --- This function gets invoked with the options being passed in from
    --                --- list:select(index, <...options...>)
    --                --- @param list_item {value: any, context: any}
    --                --- @param list { ... }
    --                --- @param option any
    --                --select = function(list_item, list, option)
    --                --    -- WOAH, IS THIS HTMX LEVEL XSS ATTACK??
    --                --    vim.cmd(list_item.value)
    --                --end

    --            }
    --        })
    --        vim.keymap.set("n", "<leader>w", function() harpoon:list():add() end, {desc = "harpoon add"})
    --        vim.keymap.set("n", "<leader>q", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc = "harpoon menu"})

    --        vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, {desc = "harpoon 1"})
    --        vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, {desc = "harpoon 2"})
    --        vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, {desc = "harpoon 3"})
    --        vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, {desc = "harpoon 4"})
    --        vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end, {desc = "harpoon 5"})
    --        vim.keymap.set("n", "<leader>6", function() harpoon:list():select(6) end, {desc = "harpoon 6"})
    --        vim.keymap.set("n", "<leader>7", function() harpoon:list():select(7) end, {desc = "harpoon 7"})
    --        vim.keymap.set("n", "<leader>8", function() harpoon:list():select(8) end, {desc = "harpoon 8"})
    --        vim.keymap.set("n", "<leader>9", function() harpoon:list():select(9) end, {desc = "harpoon 9"})

    --        -- Toggle previous & next buffers stored within Harpoon list
    --        vim.keymap.set("n", "<leader>a", function() harpoon:list():prev() end, {desc = "harpoon prev"})
    --        vim.keymap.set("n", "<leader>s", function() harpoon:list():next() end, {desc = "harpoon next"})
    --    end,
    --    dependencies = { "nvim-lua/plenary.nvim" }
    --},
    --{
    --    "stevearc/conform.nvim",
    --    opts = {
    --        formatters_by_ft = {
    --            --lua = { "stylua" },
    --            cpp = {"clang-format"}
    --            -- Conform will run multiple formatters sequentially
    --            --python = { "isort", "black" },
    --        },
    --        format_on_save = {
    --            timeout_ms = 500,
    --            lsp_fallback = true
    --        }
    --    },
    --},
-------------------------------------------------------------------------------
-- Keys
-------------------------------------------------------------------------------
    {"tpope/vim-repeat"},
    {"tpope/vim-fugitive"},
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({
                mappings = {
                    basic = false,
                    extra = false
                }
            })
            local comment_api = require('Comment.api')
            vim.keymap.set('n', '<C-/>', function()
                comment_api.toggle.linewise.current()
            end)

            vim.keymap.set('x', '<C-/>', function()
                local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
                vim.api.nvim_feedkeys(esc, 'nx', false) -- Escape visual mode
                comment_api.toggle.linewise(vim.fn.visualmode())
            end, { noremap = true, silent = true })
        end
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            window = {
                margin = {0,0,0,0},
                padding = {0,0,0,0}
            },
            layout = {
                height = { max = 10 }
            }
        },
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
    },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set("n", "<leader>z", builtin.find_files, { desc = "Telescope find files" })
        end
    },
    --{
    --    "kylechui/nvim-surround",
    --    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    --    event = "VeryLazy",
    --    opts = {
    --        keymaps = {
    --            insert          = '<C-g>s',
    --            insert_line     = '<leader>C-ggS',
    --            normal          = '<leader>s',
    --            normal_cur      = '<leader>S',
    --            normal_line     = '<leader>sgs',
    --            normal_cur_line = '<leader>SgS',
    --            visual          = '<leader>s',
    --            visual_line     = '<leader>S',
    --            delete          = '<leader>sd',
    --            change          = '<leader>sc',
    --        }
    --    },
    --    config = true
    --    --function(plugin, opts)
    --    --    require('nvim-surround').setup(opts)
    --    --end
    --},
    {
        "ggandor/leap.nvim",
        config = function()
            vim.keymap.set({'n', 'x', 'o'}, '\\',  '<Plug>(leap)')
            --vim.keymap.set({'n', 'x', 'o'}, '|"', '<Plug>(leap-from-window)')
        end
    },
}
