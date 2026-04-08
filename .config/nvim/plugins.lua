return {
-------------------------------------------------------------------------------
-- Appearance Plugins (not theme)
-------------------------------------------------------------------------------
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', 'SmiteshP/nvim-navic' },
        opts = {
            options = {
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' }
            },
            sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {
                    { 'filename', symbols = { unnamed = "*scratch*", newfile = "*new*" } },
                    'progress',
                    'location',
                    { 'tabs', tab_max_length = 80, symbols = { modified = '*' } }
                },
                lualine_x = {
                    { 'navic', navic_opts = { highlight = false, separator = ' > ' } },
                    {'diff', colored = false}, 'encoding', {'windows', show_modified_status = false, mode = 1}
                },
                lualine_y = {},
                lualine_z = {},
            }
        },
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
-------------------------------------------------------------------------------
-- LSP Plugins
-------------------------------------------------------------------------------
    {
        'hrsh7th/nvim-cmp',
        event = { 'InsertEnter', 'CmdlineEnter' },
        dependencies = {
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'L3MON4D3/LuaSnip'},
            {'hrsh7th/cmp-cmdline'}
        },
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'buffer' },
                    { name = 'path' },
                    { name = 'luasnip' },
                },
                mapping = cmp.mapping.preset.insert({
                    ['<TAB>'] = cmp.mapping.confirm({select = false})
                }),
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end
                }
            })
            -- cmdline / mode
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })
            -- `:` cmdline setup.
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    {
                        name = 'cmdline',
                        option = {
                            ignore_cmds = { 'Man', '!' }
                        }
                    }
                })
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
        init = function()
          -- Reserve a space in the gutter
          -- This will avoid an annoying layout shift in the screen
          vim.opt.signcolumn = 'yes'
        end,
        config = function()
            local lsp_defaults = require('lspconfig').util.default_config

            -- Add cmp_nvim_lsp capabilities settings to lspconfig
            -- This should be executed before you configure any language server
            lsp_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lsp_defaults.capabilities,
                require('cmp_nvim_lsp').default_capabilities()
            )

            -- LspAttach is where you enable features that only work
            -- if there is a language server active in the file
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', { buffer = event.buf, desc = "LSP hover" })
                    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', { buffer = event.buf, desc = "LSP go def" })
                    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', { buffer = event.buf, desc = "LSP go decl" })
                    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', { buffer = event.buf, desc = "LSP go impl" })
                    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', { buffer = event.buf, desc = "LSP go type" })
                    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', { buffer = event.buf, desc = "LSP references" })
                    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { buffer = event.buf, desc = "LSP signature" })
                    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', { buffer = event.buf, desc = "LSP rename" })
                    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', { buffer = event.buf, desc = "LSP format" })
                    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', { buffer = event.buf, desc = "LSP action" })
                end,
            })

            -- C++
            require('lspconfig').clangd.setup({
                keys = {
                    { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
                },
                root_dir = function(fname)
                    return require("lspconfig.util").root_pattern(
                        "Makefile",
                        "CMakeLists.txt",
                        "configure.ac",
                        "configure.in",
                        "config.h.in",
                        "meson.build",
                        "meson_options.txt",
                        "build.ninja"
                    )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
                        fname
                    ) or require("lspconfig.util").find_git_ancestor(fname)
                end,
                capabilities = {
                  offsetEncoding = { "utf-16" },
                },
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--function-arg-placeholders",
                    "--fallback-style=llvm",
                },
                init_options = {
                    usePlaceholders = true,
                    completeUnimported = true,
                    clangdFileStatus = true,
                },
            })
            -- require('lspconfig').texlab.setup()
        end
    },
    {
        'SmiteshP/nvim-navic',
        dependencies = { 'neovim/nvim-lspconfig' },
        opts = {
            highlight = false,
            separator = ' > ',
            lsp = {
                auto_attach = false,
            },
        },
        config = function(_, opts)
            local navic = require('nvim-navic')
            navic.setup(opts)
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'Navic attach',
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client and client.server_capabilities.documentSymbolProvider then
                        navic.attach(client, args.buf)
                    end
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {"lua", "cpp", "rust", "objc"},
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
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "undotree" })
        end
    },
-------------------------------------------------------------------------------
-- Keys
-------------------------------------------------------------------------------
    {"tpope/vim-repeat"},
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            win = {
                padding = { 0, 0 }
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
            local theme = require('telescope.themes').get_ivy({ previewer = true, })--border = false })

            local finder = function() builtin.find_files(theme) end
            local grepper = function() builtin.live_grep(theme) end
            local buffer = function() builtin.buffers(theme) end

            vim.keymap.set("n", "<leader>f", finder, { desc = "Telescope find_files" })
            vim.keymap.set("n", "<leader>/", grepper, { desc = "Telescope grep" })
            vim.keymap.set("n", "<leader>b", buffer, { desc = "Telescope buffer" })
        end
    },
    {"https://github.com/tpope/vim-abolish"}
}
