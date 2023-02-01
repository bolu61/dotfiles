return {
  "SmiteshP/nvim-navic",
  lazy = true,
  dependencies = {
    "neovim/nvim-lspconfig"
  },
  init = function()
    local function on_lsp_attach(fn)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          fn(vim.lsp.get_client_by_id(args.data.client_id), args.buf)
        end,
      })
    end
    on_lsp_attach(function(client, buffer)
      if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, buffer)
      end
    end)
  end,
  opts = {
    separator = " ",
    highlight = true,
    depth_limit = 5
  }
}
