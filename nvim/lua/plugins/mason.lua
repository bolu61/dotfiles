return {
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
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      require('mason-lspconfig').setup_handlers({
        function(name)
          require('lspconfig')[name].setup({
            capabilities = capabilities,
          })
        end,
        ['pyright'] = function()
          require('lspconfig').pyright.setup {
            settings = {
              python = {
                analysis = {
                  typeCheckingMode = 'strict',
                  useLibraryCodeForTypes = false,
                }
              }
            }
          }
        end,
      })
    end,
    keys = {
      { "<leader><space>", vim.lsp.buf.hover },
      { "<leader>gd", vim.lsp.buf.declaration },
      { "<leader>gf", vim.lsp.buf.definition },
      { "<leader>gr", vim.lsp.buf.references },
      { "<leader>gi", vim.lsp.buf.implementation },
      { "<leader>gh", vim.lsp.buf.signature_help },
      { "<leader>gn", vim.lsp.buf.rename },
      { "<leader>ga", vim.lsp.buf.code_action },
      { "<leader>fm", vim.lsp.buf.format },
    }
  }
}
