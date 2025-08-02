-- Generic keymaps for Neovim

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Clear search highlights when pressing <Esc>
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- A backup for the default <Esc> key, e.g., useful on iPad
vim.keymap.set("i", "jj", "<Esc>", opts)

-- Working with terminals within Neovim
map("n", "<leader>z", ":15sp term://zsh<CR>i", opts)
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })
vim.keymap.set("t", "<C-w><C-w>", [[<C-\><C-n><C-w>]], { noremap = true })

-- Smart horizontal wrap navigation
vim.keymap.set("n", "l", function()
	local col = vim.fn.col(".")
	local last_col = vim.fn.col("$") - 1
	if col == last_col then
		vim.api.nvim_feedkeys("j0", "n", false)
	else
		vim.api.nvim_feedkeys("l", "n", false)
	end
end, { noremap = true, silent = true })

vim.keymap.set("n", "h", function()
	local col = vim.fn.col(".")
	if col == 1 then
		vim.api.nvim_feedkeys("k$", "n", false)
	else
		vim.api.nvim_feedkeys("h", "n", false)
	end
end, { noremap = true, silent = true })

-----------------------
-- 🔁 Swap file cleanup
-----------------------
local swapdir = vim.fn.expand("$HOME/.local/state/nvim/swap")

-- Define function globally so mapping can access it
function _G.DeleteSwapFiles()
	local current_file = vim.fn.expand("%:p")
	local escaped = vim.fn.escape(current_file, " %")
	local pattern = swapdir .. "/" .. escaped:gsub("/", "%%") .. ".*.swp"
	vim.fn.system({ "rm", "-f", pattern })
	vim.cmd("redraw!")
end

-- Map <leader>ds to call the function
vim.keymap.set("n", "<leader>ds", ":lua DeleteSwapFiles()<CR>", { noremap = true, silent = true })

-- Easier navigation across splits
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-----------------------------------------------
-- 📋 Clipboard mappings using system clipboard
-----------------------------------------------
--- These are obsolete as normal yank/delete/paste
--- operations now use the system clipboard by default.

-- -- Yank
-- map({ "n", "v" }, "<leader>y", '"+y', opts)
-- map("n", "<leader>Y", '"+Y', opts)
--
-- -- Delete
-- map("n", "<leader>d", '"+d', opts)
-- map("n", "<leader>dd", '"+dd', opts)
--
-- -- Paste
-- map("n", "<leader>p", '"+p', opts)
-- map("n", "<leader>P", '"+P', opts)
-- map("v", "<leader>p", '"+p', opts)
-- map("v", "<leader>P", '"+P', opts)
