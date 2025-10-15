-- oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- exit terminal
vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'Exit terminal mode' })

-- diagnostic
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- better window navigation
vim.keymap.set('n', '<c-h>', '<c-w><c-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<c-l>', '<c-w><c-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<c-j>', '<c-w><c-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<c-k>', '<c-w><c-k>', { desc = 'Move focus to the upper window' })

-- better up/down
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, remap = false })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, remap = false })

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
vim.keymap.set(
	"n",
	"<leader>ur",
	"<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <c-L><CR>",
	{ desc = "Redraw / clear hlsearch / diff update" }
)

-- Select all words at cursor
vim.keymap.set({ "n", "x" }, "gw", "*N")

-- Search navigation
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- save file
vim.keymap.set({ "i", "v", "n", "s" }, "<c-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- lazy
vim.keymap.set("n", "<leader>l", "<cmd>:Lazy<cr>", { desc = "Lazy" })

-- mason
vim.keymap.set("n", "<leader>m", "<cmd>:Mason<cr>", { desc = "Mason" })

-- views
vim.keymap.set("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Open Location List" })
vim.keymap.set("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Open Quickfix List" })

-- quit
vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- windows
vim.keymap.set("n", "<leader>ww", "<c-W>p", { desc = "Other window" })
vim.keymap.set("n", "<leader>wd", "<c-W>c", { desc = "Delete window" })
vim.keymap.set("n", "<leader>w-", "<c-W>s", { desc = "Split window below" })
vim.keymap.set("n", "<leader>w|", "<c-W>v", { desc = "Split window right" })

-- tabs
vim.keymap.set("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
vim.keymap.set("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
vim.keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
vim.keymap.set("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
vim.keymap.set("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

return {
	{ "grd", vim.lsp.buf.definition, desc = "vim.lsp.buf.definition()" },
	{ "grf", vim.lsp.buf.format,     desc = "vim.lsp.buf.format()" },
	{ "grk", vim.lsp.buf.hover,      desc = "vim.lsp.buf.fhover()" },
}
