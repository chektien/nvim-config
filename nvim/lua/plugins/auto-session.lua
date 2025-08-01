-- Auto Session is a Lua plugin to manage Neovim sessions automatically.

return {
	"rmagatti/auto-session",
	config = function()
		vim.o.sessionoptions = vim.o.sessionoptions .. ",localoptions"

		require("auto-session").setup({
			enabled = true,
			auto_restore = true,
			auto_restore_last_session = false,
			auto_save = true,
			cwd_change_handling = {
				restore_upcoming_session = true,
				pre_cwd_changed_hook = nil,
				post_cwd_changed_hook = function()
					require("lualine").refresh()
				end,
			},
			log_level = "info",
			git_use_branch_name = false,
			session_lens = {
				load_on_setup = false,
			},
			suppressed_dirs = { "~/", "~/Downloads", "/" },
		})

		-- Optional keymaps
		vim.keymap.set("n", "<leader>ss", "<cmd>SessionSave<CR>", { desc = "Save session" })
		vim.keymap.set("n", "<leader>sr", "<cmd>SessionRestore<CR>", { desc = "Restore session" })
		vim.keymap.set("n", "<leader>sd", "<cmd>SessionDelete<CR>", { desc = "Delete session" })
	end,
}
