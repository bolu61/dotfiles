return {
  {
    "echasnovski/mini.pairs",
    cond = vim.g.ide,
    event = "VeryLazy",
    config = function(_, opts)
      require("mini.pairs").setup(opts)
    end,
  },
}
