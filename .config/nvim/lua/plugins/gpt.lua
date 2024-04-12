return {
    {
      "jackMort/ChatGPT.nvim",
        event = "VeryLazy",
        config = function()
          local home = vim.fn.expand("$HOME")
          require("chatgpt").setup({
            api_key_cmd = "gpg --decrypt " .. home .. "/openai_secret.txt.gpg",
            openai_params = {
              model = "gpt-4",
              max_tokens = 1000,
            },
          })
        end,
        dependencies = {
          "MunifTanjim/nui.nvim",
          "nvim-lua/plenary.nvim",
          "nvim-telescope/telescope.nvim"
        }
    }
}
--return {}
