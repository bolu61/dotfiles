return {
	{ "echasnovski/mini.icons", version = "*" },
	{ 'echasnovski/mini.surround', version = '*' },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix",
			spec = {
				{
					mode = { "n", "v" },
					{ "<leader><tab>", group = "tabs" },
					{ "<leader>c", group = "code" },
					{ "<leader>d", group = "debug" },
					{ "<leader>dp", group = "profiler" },
					{ "<leader>f", group = "file/find" },
					{ "<leader>g", group = "git" },
					{ "<leader>gh", group = "hunks" },
					{ "<leader>q", group = "quit/session" },
					{ "<leader>s", group = "search" },
					{ "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
					{ "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
					{ "[", group = "prev" },
					{ "]", group = "next" },
					{ "g", group = "goto" },
					{ "gs", group = "surround" },
					{ "z", group = "fold" },
					{
						"<leader>b",
						group = "buffer",
						expand = function()
							return require("which-key.extras").expand.buf()
						end,
					},
					{
						"<leader>w",
						group = "windows",
						proxy = "<c-w>",
						expand = function()
							return require("which-key.extras").expand.win()
						end,
					},
					-- better descriptions
					{ "gx", desc = "Open with system app" },
				},
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Keymaps (which-key)",
			},
		},
	},
	{
		"folke/trouble.nvim",
		cmd = { "Trouble" },
		opts = {
			modes = {
				lsp = {
					win = { position = "right" },
				},
			},
		},
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>cs", "<cmd>Trouble symbols toggle<cr>",                  desc = "Symbols (Trouble)" },
			{ "<leader>cS", "<cmd>Trouble lsp toggle<cr>",                      desc = "LSP references/definitions/... (Trouble)" },
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                  desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                   desc = "Quickfix List (Trouble)" },
			{
				"[q",
				function()
					if require("trouble").is_open() then
						require("trouble").prev({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cprev)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Previous Trouble/Quickfix Item",
			},
			{
				"]q",
				function()
					if require("trouble").is_open() then
						require("trouble").next({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cnext)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Next Trouble/Quickfix Item",
			},
		},
	},
	{
		"Isrothy/neominimap.nvim",
		version = "v3.*.*",
		dependencies = { "nvim-treesitter/nvim-treesitter", "lewis6991/gitsigns.nvim" },
		enabled = true,
		lazy = false, -- NOTE: NO NEED to Lazy load
		-- Optional
		keys = {
			-- Global Minimap Controls
			{ "<leader>nm",  "<cmd>Neominimap toggle<cr>",      desc = "Toggle global minimap" },
			{ "<leader>no",  "<cmd>Neominimap on<cr>",          desc = "Enable global minimap" },
			{ "<leader>nc",  "<cmd>Neominimap off<cr>",         desc = "Disable global minimap" },
			{ "<leader>nr",  "<cmd>Neominimap refresh<cr>",     desc = "Refresh global minimap" },

			-- Window-Specific Minimap Controls
			{ "<leader>nwt", "<cmd>Neominimap winToggle<cr>",   desc = "Toggle minimap for current window" },
			{ "<leader>nwr", "<cmd>Neominimap winRefresh<cr>",  desc = "Refresh minimap for current window" },
			{ "<leader>nwo", "<cmd>Neominimap winOn<cr>",       desc = "Enable minimap for current window" },
			{ "<leader>nwc", "<cmd>Neominimap winOff<cr>",      desc = "Disable minimap for current window" },

			-- Tab-Specific Minimap Controls
			{ "<leader>ntt", "<cmd>Neominimap tabToggle<cr>",   desc = "Toggle minimap for current tab" },
			{ "<leader>ntr", "<cmd>Neominimap tabRefresh<cr>",  desc = "Refresh minimap for current tab" },
			{ "<leader>nto", "<cmd>Neominimap tabOn<cr>",       desc = "Enable minimap for current tab" },
			{ "<leader>ntc", "<cmd>Neominimap tabOff<cr>",      desc = "Disable minimap for current tab" },

			-- Buffer-Specific Minimap Controls
			{ "<leader>nbt", "<cmd>Neominimap bufToggle<cr>",   desc = "Toggle minimap for current buffer" },
			{ "<leader>nbr", "<cmd>Neominimap bufRefresh<cr>",  desc = "Refresh minimap for current buffer" },
			{ "<leader>nbo", "<cmd>Neominimap bufOn<cr>",       desc = "Enable minimap for current buffer" },
			{ "<leader>nbc", "<cmd>Neominimap bufOff<cr>",      desc = "Disable minimap for current buffer" },

			---Focus Controls
			{ "<leader>nf",  "<cmd>Neominimap focus<cr>",       desc = "Focus on minimap" },
			{ "<leader>nu",  "<cmd>Neominimap unfocus<cr>",     desc = "Unfocus minimap" },
			{ "<leader>ns",  "<cmd>Neominimap toggleFocus<cr>", desc = "Switch focus on minimap" },
		},
		init = function()
			-- The following options are recommended when layout == "float"
			vim.opt.wrap = false
			vim.opt.sidescrolloff = 36 -- Set a large value

			--- Put your configuration here
			---@type Neominimap.UserConfig
			vim.g.neominimap = {
				auto_enable = true,
			}
		end,
	},
	{
		'stevearc/oil.nvim',
		dependencies = { { 'echasnovski/mini.icons' } },
		version = '*',
		lazy = false,
		cond = require('mode').ide,
		opts = {
			default_file_explorer = true,
			delete_to_trash = true,
		}
	},
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
	}
}
