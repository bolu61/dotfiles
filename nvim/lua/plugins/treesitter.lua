return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    cond = require("mode").ide,
    event = "BufReadPost",
    keys = {
      { "<s-bs>", desc = "Increment selection" },
      { "<bs>", desc = "Shrink selection", mode = "x" },
    },
    opts = {
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      context_commentstring = { enable = true, enable_autocmd = false },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<s-bs>",
          node_incremental = "<s-bs>",
          scope_incremental = "<nop>",
          node_decremental = "<bs>",
        }
      }
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end
  }
}
