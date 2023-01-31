return {
  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp'
    },
    config = function(opts)
      require('mason').setup(opts)
      require('mason-lspconfig').setup()
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      require('mason-lspconfig').setup_handlers({
        function(name)
          require('lspconfig')[name].setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              local bufopts = { silent=true, buffer=bufnr }
              vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
              vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
              vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
              vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
              vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
              vim.keymap.set('n', 'gk', vim.lsp.buf.signature_help, bufopts)
              vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
              vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
              vim.keymap.set('n', '<c-f>', function() vim.lsp.buf.format { async = true } end, bufopts)
            end,
            flags = {
              debounce_text_changes = 150,
            },
          })
        end
      })
    end
  }
}
