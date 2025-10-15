-- lazy plugins
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
require("which-key").add(require("keymaps"))

-- vim options
vim.diagnostic.config({ virtual_text = false, })
vim.cmd "filetype plugin indent on"
vim.schedule(function()
	vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.exrc = true
vim.opt.termguicolors = true
vim.opt.syntax = 'on'
vim.opt.errorbells = false
vim.opt.smartcase = true
vim.opt.swapfile = false
vim.opt.autoindent = true
vim.opt.smartindent = false
vim.opt.textwidth = 0
vim.opt.expandtab = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 0
vim.opt.softtabstop = 0
vim.opt.smarttab = false
vim.opt.scrolloff = 8
vim.opt.laststatus = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'number'
vim.opt.wrap = false
vim.opt.mouse = 'a'
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, { command = "checktime" })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = 'Highlight when yanking (copying) text',
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"qf",
		"help",
		"man",
		"notify",
		"lspinfo",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"PlenaryTestPopup",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- enable text wrap and spellcheck for text file types
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "gitcommit", "markdown", "txt" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})
