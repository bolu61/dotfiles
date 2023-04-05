return {
  {
    "lambdalisue/fern.vim",
    dependencies = {
      "lambdalisue/fern-git-status.vim",
      
    },
    keys = {
      { "<leader><tab>", "<cmd>Fern . -reveal=%<cr>", "Open file picker."},
    },
  },
  {
    "lambdalisue/fern-hijack.vim", 
    dependencies = {
      "lambdalisue/fern.vim"
    }
  },
}
