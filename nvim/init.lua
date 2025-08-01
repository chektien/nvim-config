-- The Neovim configuration entry point

-- ✨ Leader key setup early (before plugins)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- 🛠 Basic options
require("config.options")

-- 🎹 Key mappings
require("config.keymaps")

-- 🚀 Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- 🚀 Load all plugin specs from lua/plugins/*.lua
require("lazy").setup({
	-- Auto-load from lua/plugins/ directory
	{ import = "plugins" },
}, { -- This is where global lazy.nvim options go
	change_detection = {
		enabled = true,
		notify = false,
	},
	rocks = {
		enabled = false, -- Disable luarocks integration
	},
})

-- 🧪 Autocommands
require("config.autocmds")

