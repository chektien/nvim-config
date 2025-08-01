-- The Lua implementation of Coplit plugin for Neovim

return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = true,
				auto_trigger = true,
				keymap = {
					accept = "<Tab>",
					accept_word = "<M-Right>",
					accept_line = "<C-;>",
					next = "<C-]>",
					prev = "<C-[>",
					dismiss = "<C-/>",
				},
			},
			panel = { enabled = false },
			filetypes = {
				markdown = true,
				tex = true,
				lua = true,
				python = true,
				javascript = true,
				typescript = true,
				html = true,
				css = true,
				json = true,
				yaml = true,
				go = true,
				rust = true,
				c = true,
				cpp = true,
				java = true,
				bash = true,
				sh = true,
				zsh = true,
				fish = true,
				vim = true,
			},
		})

		-- Escape insert mode while dismissing Copilot suggestions
		vim.keymap.set("i", "<Esc>", function()
			local suggestion = require("copilot.suggestion")
			if suggestion.is_visible() then
				suggestion.dismiss()
			end
			-- Always escape insert mode
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
		end, { desc = "Dismiss Copilot and escape insert", silent = true })
	end,
}

-- Old version, kept for reference
-- return {
--     "github/copilot.vim",
-- }
