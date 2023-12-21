return {
  {
    "Yazeed1s/oh-lucy.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme oh-lucy-evening]])
    end,
  }
  --,
  --{
  --  "rockerBOO/boo-colorscheme-nvim",
  --  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --  priority = 1000, -- make sure to load this before all the other start plugins
  --  --theme = "radioactive_waste"
  --  config = function ()
  --      require('boo-colorscheme').use({ theme = 'sunset_cloud' })
  --  end,
  --},
  --{
  --  "mellow-theme/mellow.nvim",
  --  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --  priority = 1000 -- make sure to load this before all the other start plugins
  --}
}
