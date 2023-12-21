vim.api.nvim_create_autocmd("BufEnter", {
   pattern = { "*.hs" },
   callback = function()
      vim.opt.shiftwidth = 2
      vim.opt.tabstop = 2
      vim.opt.softtabstop = 2
      -- vim.opt_local.colorcolumn = {70, 80}
   end
})
