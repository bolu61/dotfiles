return {
  {
    "windwp/nvim-spectre",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },
}
