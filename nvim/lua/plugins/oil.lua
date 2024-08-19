return {
  'stevearc/oil.nvim',
  dependencies = { { 'echasnovski/mini.icons' } },
  version = '*',
  lazy = false,
  cond = require('mode').ide,
  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
  }
}
