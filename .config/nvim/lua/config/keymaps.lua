-- see also debugger.lua which contains specific keymaps for debugging

local nnoremap = function(k, cmd)
    vim.keymap.set("n", k, cmd)
end

vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })

vim.g.mapleader = " "

nnoremap("<leader>q", vim.cmd.Ex) 
nnoremap("<leader>u", vim.cmd.UndotreeToggle)
--nnoremap("<leader>t", vim.cmd.Telescope)

-- fast navigation between windows
nnoremap("<C-l>", "<C-w>l")
nnoremap("<C-h>", "<C-w>h")
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l")
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h")

nnoremap("<C-j>", "<C-w>k")
nnoremap("<C-j>", "<C-w>j")
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k")

--vim.keymap.set("t", "<Esc><Esc", "<C-\\><C-n>")


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
