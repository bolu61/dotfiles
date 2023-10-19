return {
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
      { "<leader>gD", vim.lsp.buf.declaration },
      { "<leader>gd", vim.lsp.buf.definition },
      { "<leader>gr", vim.lsp.buf.references },
      { "<leader>gi", vim.lsp.buf.implementation },
      { "<leader>h", vim.lsp.buf.signature_help },
      { "<leader>rn", vim.lsp.buf.rename },
      { "<leader>ca", vim.lsp.buf.code_action },
      { "<leader>f", vim.lsp.buf.format },
    }
  }
}
