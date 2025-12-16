return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		cond = require("mode").ide,
		opts = {
			flavour = "auto",
			background = {
				light = "latte",
				dark = "frappe",
			},
			term_colors = true,
			auto_integrations = true,
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
			vim.cmd([[colorscheme catppuccin]])
		end,
	},
}
