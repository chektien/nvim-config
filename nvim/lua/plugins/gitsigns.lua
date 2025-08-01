-- gitsigns.nvim helps to show git changes in the sign column on the left gutter

return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "" }, -- nf-fa-plus
			change = { text = "" }, -- nf-oct-dot-fill
			delete = { text = "" }, -- nf-oct-trash
			topdelete = { text = "" }, -- nf-md-delete_circle_outline
			changedelete = { text = "󰈸" }, -- nf-md-pencil_outline
			--   契 󰩹 󰩼 󰎞 󰐊 󰍵 󰆴 󰧞 󰧟 󰧠 󰈸 󰅖 󰅗 󰜺 󰛲 󰛳
			--   󰍴 󰍵 󰑕 󰛿 󱌣 󰔉 󰙼 󰚡 󰙷 󱓼
		},
		signcolumn = true, -- Toggle with :Gitsigns toggle_signs
		numhl = false, -- Optional: highlight line numbers
		linehl = false, -- Optional: highlight lines
		current_line_blame = true, -- Git blame on current line
		update_debounce = 100,
	},
}
