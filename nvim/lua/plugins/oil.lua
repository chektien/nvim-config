-- oil.nvim is a file explorer that is fast and provides a vim editing experience

return {
	"stevearc/oil.nvim",
	lazy = false, -- eagerly load

	dependencies = {
		{ "echasnovski/mini.icons", opts = {} },
	},

	opts = {
		float = {
			max_width = 0.9,
			max_height = 0.9,
            padding = 2,
			border = "rounded",
			preview_split = "auto",
            win_options = {
                winblend = 10,
            }
		},
		keymaps = {
			["q"] = "actions.close",
            ["<Esc>"] = "actions.close",
		},
		view_options = {
			show_hidden = true,
		},
	},

	keys = {
		{ "<leader>e", "<CMD>Oil --float<CR>", desc = "Open Oil (float)" },
	},
}
