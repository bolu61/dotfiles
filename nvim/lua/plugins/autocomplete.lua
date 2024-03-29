return {
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    name = "cmp",
    dependencies = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig',
      'L3MON4D3/LuaSnip',
      "hrsh7th/cmp-buffer",
      'hrsh7th/cmp-cmdline',
      "hrsh7th/cmp-nvim-lsp",
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      "hrsh7th/cmp-path",
      'petertriho/cmp-git',
      "saadparwaiz1/cmp_luasnip",
    },
    cond = vim.g.ide,
    opts = function(_, opts)
      local cmp = require("cmp")
      return {
        preselect = cmp.PreselectMode.None,
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
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
          ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_document_symbol' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'luasnip' },
        }),
      }
    end,
    config = function(_, opts)
      local cmp = require("cmp")
      cmp.setup(opts)
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'cmp_git' },
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
          {name = 'cmdline', keyword_pattern = [[\!\@<!\w*]]},
        })
      })
    end
  }
}
