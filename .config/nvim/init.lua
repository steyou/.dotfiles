-------------------------------------------------------------------------------
-- Options
-------------------------------------------------------------------------------

-- Display and interface settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmatch = true
vim.opt.linebreak = true
vim.opt.guicursor = ""
vim.opt.scrolloff = 1
vim.opt.colorcolumn = "90"

-- Searching settings
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Indentation and whitespace settings
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = false

-- File handling and backup settings
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true

-- Buffer and window management settings
vim.opt.switchbuf = 'split'

-- lualine describes tabs
vim.opt.showtabline = 0

-------------------------------------------------------------------------------
-- Keymaps
-------------------------------------------------------------------------------

vim.g.mapleader = " "
vim.keymap.set("n", "<leader><enter>", vim.cmd.Ex, { desc = "netrw" })
vim.keymap.set("n", "<leader><left>", vim.cmd.bprev, { desc = "bprev" })
vim.keymap.set("n", "<leader><right>", vim.cmd.bnext, { desc = "bnext" })

-- Kill the current buffer
vim.keymap.set("n", "<leader>k", function() vim.cmd("bp | bd #") end, { desc = "bkill" })

-------------------------------------------------------------------------------
-- Lazy loading setup
-------------------------------------------------------------------------------

require('colemak_dh').setup(0)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
   vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
   })
end
vim.opt.rtp:prepend(lazypath)

local config_dir = vim.fn.stdpath("config")
package.path = package.path .. ";" .. vim.fn.stdpath("config") .. "/?.lua"
require("lazy").setup(
    {
        require("plugins"),
        require("themes")("modus")
    }
)

-- set the theme
--require("gruvbox-material")
