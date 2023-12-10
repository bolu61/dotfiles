return {
  {
    "lambdalisue/fern.vim",
    dependencies = {
      "lambdalisue/fern-git-status.vim",
    },
    cond = require("mode").ide,
    keys = {
      { "<leader>e", "<cmd>Fern . -reveal=%<cr>", "Open file picker."},
    },
  },
  {
    "lambdalisue/fern-hijack.vim", 
    dependencies = {
      "lambdalisue/fern.vim"
    }
  },
}
