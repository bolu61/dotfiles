return {
	{ 'echasnovski/mini.surround', version = false },
	{
		'mason-org/mason.nvim',
		lazy = false,
		opts = {},
		keys = {
			{ "gd",         vim.lsp.buf.definition,     desc = "[g]oto [d]efinition" },
			{ "gi",         vim.lsp.buf.implementation, desc = "[g]oto [i]mplementation" },
			{ "<leader>ck", vim.lsp.buf.hover,          desc = "lsp code hover" },
			{ "<leader>ch", vim.lsp.buf.signature_help, desc = "[c]ode signature [h]elp" },
			{ "<leader>cr", vim.lsp.buf.rename,         desc = "[c]ode [r]ename" },
			{ "<leader>ca", vim.lsp.buf.code_action,    desc = "[c]ode [a]ction" },
			{ "<leader>cf", vim.lsp.buf.format,         desc = "[c]ode [f]ormat" },
		}
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "BufReadPost",
		keys = {
			{ "<s-bs>", desc = "Increment selection" },
			{ "<bs>",   desc = "Shrink selection",   mode = "x" },
		},
		opts = {
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
			context_commentstring = {
				enable = true,
				enable_autocmd = false
			},
			incremental_selection = {
				enable = true,
			}
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end
	},
	{
		"hrsh7th/nvim-cmp",
		version = "*",
		lazy = false,
		name = "cmp",
		dependencies = {
			'nvim-lua/plenary.nvim',
			'neovim/nvim-lspconfig',
			"hrsh7th/cmp-buffer",
			'hrsh7th/cmp-cmdline',
			"hrsh7th/cmp-nvim-lsp",
			'hrsh7th/cmp-nvim-lsp-document-symbol',
			'hrsh7th/cmp-nvim-lsp-signature-help',
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
			"petertriho/cmp-git",
		},
		config = function()
			require("cmp_git").setup()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					['<c-b>'] = cmp.mapping.scroll_docs(-4),
					['<c-f>'] = cmp.mapping.scroll_docs(4),
					['<c-space>'] = cmp.mapping.complete(),
					['<c-e>'] = cmp.mapping.abort(),
					['<cr>'] = cmp.mapping.confirm(),
					['<tab>'] = cmp.mapping.select_next_item(),
					['<s-tab>'] = cmp.mapping.select_prev_item(),
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'nvim_lsp_signature_help' },
					{ name = 'nvim_lsp_document_symbol' },
				})
			}, {
				name = 'buffer'
			})

			cmp.setup.filetype('gitcommit', {
				sources = cmp.config.sources({
					{ name = 'git' },
				}, {
					{ name = 'buffer' },
				})
			})

			cmp.setup.cmdline({ '/', '?' }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' }
				}
			})

			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' }
				}, {
					{ name = 'cmdline' },
				}),
				matching = { disallow_symbol_nonprefix_matching = false }
			})
		end
	}
}
