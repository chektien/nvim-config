-- Generic Neovim autocommands

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local autosave = augroup("Autosave", { clear = true })

-- Save on InsertLeave for normal files
autocmd("InsertLeave", {
	group = autosave,
	callback = function()
		if vim.bo.buftype == "" then
			vim.cmd("silent! write")
		end
	end,
})

-- Save all buffers on BufLeave (e.g. switching windows)
autocmd("BufLeave", {
	group = autosave,
	callback = function()
		if vim.bo.modifiable and vim.bo.buftype == "" then
			vim.cmd("silent! wall")
		end
	end,
})

-- Auto-cd to directory of current file
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		local bufname = vim.api.nvim_buf_get_name(0)
		if bufname ~= "" and vim.fn.isdirectory(vim.fn.expand("%:p:h")) == 1 then
			vim.cmd("lcd %:p:h")
		end
	end,
	desc = "Auto lcd to file directory",
})

-- Set up abbreviations
vim.cmd("cabbrev t tabnew")

-- Set up filetype-specific settings
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "html", "c" },
	callback = function()
		vim.bo.shiftwidth = 2
		vim.bo.tabstop = 2
	end,
})

-- Highlight on yank
autocmd("TextYankPost", {
	group = augroup("HighlightYank", { clear = true }),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ timeout = 150 })
	end,
})
