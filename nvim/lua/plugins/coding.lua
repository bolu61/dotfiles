return {
	{ 'echasnovski/mini.surround', version = '*' },
	{
		'williamboman/mason.nvim',
		dependencies = {
			'williamboman/mason-lspconfig.nvim',
			'neovim/nvim-lspconfig',
			'hrsh7th/nvim-cmp',
			'hrsh7th/cmp-nvim-lsp',
		},
		cond = require("mode").ide,
		lazy = false,
		config = function(_, opts)
			require('mason').setup(opts)
			require('mason-lspconfig').setup()
			require('mason-lspconfig').setup_handlers({
				function(name)
					require('lspconfig')[name].setup({
						capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
					})
				end,
				['pyright'] = function()
					require('lspconfig').pyright.setup {
						settings = {
							python = {
								analysis = {
									typeCheckingMode = 'standard',
								}
							}
						}
					}
				end,
				["texlab"] = function()
					require("lspconfig").texlab.setup {
						settings = {
							build = {
								executable = "tectonic",
								args = { "-X", "compile", "%f", "--synctex", "--keep-logs", "--keep-intermediates" },
								auxDirectory = "build",
								logDirectory = "build",
								pdfDirectory = "build",

							},

						}
					}
				end,
			})
			vim.diagnostic.config({ virtual_text = false, })
		end,
		keys = {
			{ "<leader><space>", vim.lsp.buf.hover },
			{ "<leader>gd",      vim.lsp.buf.declaration },
			{ "<leader>gf",      vim.lsp.buf.definition },
			{ "<leader>gr",      vim.lsp.buf.references },
			{ "<leader>gi",      vim.lsp.buf.implementation },
			{ "<leader>gh",      vim.lsp.buf.signature_help },
			{ "<leader>gn",      vim.lsp.buf.rename },
			{ "<leader>ga",      vim.lsp.buf.code_action },
			{ "<leader>fm",      vim.lsp.buf.format },
		}
	},

	-- auto pairs
	{
		"echasnovski/mini.pairs",
		version = "*",
		event = "VeryLazy",
		opts = {
			modes = {
				insert = true,
				command = true,
				terminal = false,
			},
		},
	},

	-- comments
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
	},

	-- Better text-objects
	{
		"echasnovski/mini.ai",
		event = "VeryLazy",
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({ -- code block
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),  -- class
					t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },      -- tags
					d = { "%f[%d]%d+" },                                                     -- digits
					e = {                                                                    -- Word with case
						{ "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
						"^().*()$",
					},
					u = ai.gen_spec.function_call(),                      -- u for "Usage"
					U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
				},
			}
		end,
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
			context_commentstring = { enable = true, enable_autocmd = false },
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
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
			"hrsh7th/cmp-buffer",
			'hrsh7th/cmp-cmdline',
			"hrsh7th/cmp-nvim-lsp",
			'hrsh7th/cmp-nvim-lsp-document-symbol',
			'hrsh7th/cmp-nvim-lsp-signature-help',
			"hrsh7th/cmp-path",
			"petertriho/cmp-git",
		},
		cond = require("mode").ide,
		opts = function()
		end,
		config = function()
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
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'nvim_lsp_signature_help' },
					{ name = 'nvim_lsp_document_symbol' },
					{ name = 'vsnip' },
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
			require("cmp_git").setup()

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
