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
		lazy = false,
		config = function(_, opts)
			local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
			require('mason').setup(opts)
			require('mason-lspconfig').setup({
				handlers = {
					function(name)
						require('lspconfig')[name].setup({
							capabilities = capabilities
						})
					end,
					['pyright'] = function()
						require('lspconfig').pyright.setup {
							capabilities = capabilities,
							settings = {
								python = {
									analysis = {
										useLibraryCodeForTypes = false,
										typeCheckingMode = 'standard',
									}
								}
							},
						}
					end,
					["texlab"] = function()
						require("lspconfig").texlab.setup {
							capabilities = capabilities,
							settings = {
								texlab = {
									build = {
										auxDirectory = "build",
										pdfDirectory = "build",
										logDirectory = "build",
										forwardSearchAfter = true,
										onSave = true,
									},
									forwardSearch = {
										executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
										args = {"-g", "-r", "%l", "%p", "%f"},
									},
									latexFormatter = "latexindent",
									diagnostics = {
										ignoredPatterns = {"Unused label", "Unused entry"},
									},
								},
							},
						}
					end,
				}
			})
			vim.diagnostic.config({ virtual_text = false, })
		end,
		keys = {
			{ "<leader>cc", vim.lsp.buf.hover },
			{ "<leader>cd",      vim.lsp.buf.declaration },
			{ "<leader>ce",      vim.lsp.buf.definition },
			{ "<leader>cr",      vim.lsp.buf.references },
			{ "<leader>ci",      vim.lsp.buf.implementation },
			{ "<leader>ch",      vim.lsp.buf.signature_help },
			{ "<leader>cn",      vim.lsp.buf.rename },
			{ "<leader>ca",      vim.lsp.buf.code_action },
			{ "<leader>cf",     vim.lsp.buf.format },
		}
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
