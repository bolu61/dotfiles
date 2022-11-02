vim.cmd [[filetype plugin indent on]]
local fn = vim.fn

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.termguicolors = true
vim.o.syntax = 'on'
vim.o.errorbells = false
vim.o.smartcase = true

vim.bo.swapfile = false

vim.bo.autoindent = true
vim.bo.smartindent = true

-- vim.o.textwidth = 80
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.laststatus = 2

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'number'
vim.wo.wrap = false

vim.g.mapleader = ' '

local opts = { noremap = true, silent = true }
vim.keymap.set('i', 'jk', '<ESC>', opts)
vim.keymap.set('n', '<leader>w', ':w<CR>', opts)
vim.keymap.set('n', '<leader>q', ':b#<bar>bd#<CR>', opts)
vim.keymap.set('n', '<leader>wq', ':w<bar>b#<bar>bd#<CR>', opts)
vim.keymap.set('n', '<leader>wqa', ':wqa<CR>', opts)
vim.keymap.set('n', '<leader><Tab>', ':NvimTreeOpen<CR>', opts)
vim.keymap.set('n', '<leader>;', ':NvimTreeToggle<CR>', opts)
vim.keymap.set('n', '<leader>bb', '<C-^>', opts)
vim.keymap.set('n', '<leader>bn', ':bn<CR>', opts)
vim.keymap.set('n', '<leader>bp', ':bp<CR>', opts)
vim.keymap.set('n', '<leader>bd', ':bd<CRL>', opts)
vim.keymap.set('n', '<leader>bk', ':bd!<CR>', opts)
vim.keymap.set('n', '<leader>bl', ':ls<CR>:buffer<Space>', opts)
vim.keymap.set('n', '<leader>bh', ':new<CR>', opts)
vim.keymap.set('n', '<leader>bv', ':vnew<CR>', opts)


local ensurepacker = function()
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local bootstrap = ensurepacker()

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use { 'echasnovski/mini.nvim', branch = 'stable', config = function()
    require('mini.tabline').setup()
    require('mini.trailspace').setup()
    require('mini.test').setup()
    require('mini.indentscope').setup()
  end}

  -- treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', requires = {
    -- 'nvim-treesitter/nvim-treesitter-textobjects'
  }, config = function()
    require('nvim-treesitter.configs').setup{
      auto_install = true,
      highlight = {
        enable = true,
        disable = { 'latex' }
      }
    }
  end}

  -- theme
  use { 'catppuccin/nvim', as = 'catppuccin', config = function()
    vim.g.catppuccin_flavour = 'latte'
    require('catppuccin').setup{
      transparent_background = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        treesitter = true,
        mini = true,
        illuminate = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
        },
        -- For more plugins integrations https://github.com/catppuccin/nvim#integrations
      },
    }
    vim.cmd [[colorscheme catppuccin]]
  end}

  -- illuminate
  use { 'RRethy/vim-illuminate', config = function()
    require('illuminate').configure{
      large_file_cutoff = 10000,
      large_file_overrides = {
        delay = 500,
        modes_allowlist = { 'n' }
      }
    }
  end}

  -- file explorer
  use { 'nvim-tree/nvim-tree.lua', requires = {
    'nvim-tree/nvim-web-devicons'
  }, config = function()
    require('nvim-tree').setup{
      open_on_setup = true
    }
  end}

  -- latex plugin
  use { 'lervag/vimtex', config = function()
    vim.g.vimtex_view_method = 'skim'
    vim.g.vimtex_view_skim_sync = 1
    vim.g.vimtex_view_skim_activate = 1
  end}

  -- ide package manager
  use { 'williamboman/mason.nvim', requires = {
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp'
  }, config = function()
    require('mason').setup {
      log_level = vim.log.levels.DEBUG
    }
    require('mason-lspconfig').setup()
    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
    require('mason-lspconfig').setup_handlers({
      function(name)
        require('lspconfig')[name].setup({
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            local bufopts = { noremap=true, silent=true, buffer=bufnr }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
            vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
            vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
            vim.keymap.set('n', '<leader>wl', function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, bufopts)
            vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
            vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
          end,
          flags = {
            debounce_text_changes = 150,
          },
        })
      end
    })
  end}

  use { 'hrsh7th/nvim-cmp', requires = {
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-document-symbol',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    { 'petertriho/cmp-git', requires = 'nvim-lua/plenary.nvim' },
    { 'saadparwaiz1/cmp_luasnip', requires = 'L3MON4D3/LuaSnip' },
    'hrsh7th/cmp-omni',
  }, config = function()
    vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
    local cmp = require('cmp')
    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_document_symbol' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'luasnip' },
        { name = 'omni' },
      }, {
        { name = 'buffer' },
      })
    })
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
  end}

  use { 'fedepujol/move.nvim', config = function()
    vim.keymap.set('n', '<A-j>', ':MoveLine(1)<CR>', opts)
    vim.keymap.set('n', '<A-k>', ':MoveLine(-1)<CR>', opts)
    vim.keymap.set('n', '<A-h>', ':MoveHChar(-1)<CR>', opts)
    vim.keymap.set('n', '<A-l>', ':MoveHChar(1)<CR>', opts)

    vim.keymap.set('v', '<A-j>', ':MoveBlock(1)<CR>', opts)
    vim.keymap.set('v', '<A-k>', ':MoveBlock(-1)<CR>', opts)
    vim.keymap.set('v', '<A-h>', ':MoveHBlock(-1)<CR>', opts)
    vim.keymap.set('v', '<A-l>', ':MoveHBlock(1)<CR>', opts)

    vim.keymap.set('n', '∆', ':MoveLine(1)<CR>', opts)
    vim.keymap.set('n', '˚', ':MoveLine(-1)<CR>', opts)
    vim.keymap.set('n', '˙', ':MoveHChar(-1)<CR>', opts)
    vim.keymap.set('n', '¬', ':MoveHChar(1)<CR>', opts)

    vim.keymap.set('v', '∆', ':MoveBlock(1)<CR>', opts)
    vim.keymap.set('v', '˚', ':MoveBlock(-1)<CR>', opts)
    vim.keymap.set('v', '˙', ':MoveHBlock(-1)<CR>', opts)
    vim.keymap.set('v', '¬', ':MoveHBlock(1)<CR>', opts)
  end}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if bootstrap then
    require('packer').sync()
  end
end)

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
