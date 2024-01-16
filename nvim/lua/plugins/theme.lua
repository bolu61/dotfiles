return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    cond = require("mode").ide,
    opts = {
      flavour = "frappe",
      no_italic = true,
      background = {
        light = "latte",
        dark = "frappe",
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd([[colorscheme catppuccin]])
      vim.o.background = "dark"
    end,
  },
}
