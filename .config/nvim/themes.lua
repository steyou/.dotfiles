local M = {}

local themes = {
    ["oh-lucy-evening"] = { plugin = "Yazeed1s/oh-lucy.nvim" },
    ["no-clown-fiesta"] = { plugin = "steyou/no-clown-fiesta.nvim" },
    ["gruvbox-material"] = {
        plugin = "sainnhe/gruvbox-material",
        pre_setup = function()
            vim.opt.background = "dark"
            vim.g.gruvbox_material_background = "hard"
        end,
    },
    ["kanagawa"] = {
        plugin = "rebelot/kanagawa.nvim",
        pre_setup = function()
            require("kanagawa").setup({
                theme = "dragon",
                background = { dark = "dragon", light = "dragon" }
            })
            vim.opt.background = "dark"
        end,
    },
    ["kanagawabones"] = {
        plugin = "mcchrish/zenbones.nvim",
        dependencies = { "rktjmp/lush.nvim" },
        pre_setup = function() vim.opt.background = "dark" end,
    },
    ["dracula"]      = { plugin = "Mofiqul/dracula.nvim" },
    ["modus"]        = { plugin = "miikanissi/modus-themes.nvim" },
    ["gotham256"]    = { plugin = "whatyouhide/vim-gotham" },
    ["carbonfox"]    = {
        plugin = "EdenEast/nightfox.nvim",
        pre_setup = function() vim.opt.background = "dark" end,
    },
    ["mellow"]       = { plugin = "mellow-theme/mellow.nvim" },
    ["oxocarbon"]    = {
        plugin = "nyoom-engineering/oxocarbon.nvim",
        pre_setup = function() vim.opt.background = "dark" end,
    },
    ["jellybeans-nvim"] = {
        plugin = "metalelf0/jellybeans-nvim",
        dependencies = { "rktjmp/lush.nvim" },
    },
    ["alabaster"]    = {
        plugin = "p00f/alabaster.nvim",
        pre_setup = function()
            vim.opt.background = "dark"
            vim.g.alabaster_dim_comments = true
        end,
    },
    ["everforest"]   = { plugin = "sainnhe/everforest" },
    ["cold"]         = { plugin = "gmr458/cold.nvim" },
}

function M.setup_autocmd()
    vim.opt.termguicolors = true
    vim.api.nvim_create_autocmd("ColorSchemePre", {
        callback = function(ev)
            local entry = themes[ev.match]
            if entry then
                if entry.pre_setup then
                    entry.pre_setup()
                end
            end
        end,
    })
end

function M.specs()
    local specs = {}
    local seen = {}
    for _, entry in pairs(themes) do
        if not seen[entry.plugin] then
            seen[entry.plugin] = true
            local spec = { entry.plugin }
            if entry.dependencies then
                spec.dependencies = entry.dependencies
            end
            table.insert(specs, spec)
        end
    end
    return specs
end

return M
