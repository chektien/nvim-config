-- The gruvbox theme

return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	config = function()
		require("gruvbox").setup({
			contrast = "hard", -- 'hard', 'soft' or ''
			transparent_mode = false, -- true if you want no background
		})
		vim.cmd("colorscheme gruvbox")
	end,
}
