-- outline.nvim provides a simple outline view for Neovim, including for md files

return {
	"hedyhli/outline.nvim",
	lazy = true,
	cmd = { "Outline", "OutlineOpen" },
	keys = { -- Example mapping to toggle outline
		{ "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
	},
	config = function()
		require("outline").setup({})
	end,
}
