return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    cond = require("mode").ide,
    opts = {
      flavour = "auto",
      no_italic = true,
      background = {
        light = "latte",
        dark = "mocha",
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd([[colorscheme catppuccin]])
      vim.o.background = "dark"
    end,
  },
}
