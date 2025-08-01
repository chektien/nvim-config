-- Treesitter for performant code parsing and syntax highlighting

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	lazy = false, -- Load immediately
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
                "c",
                "cpp",
                "ruby",
				"lua",
				"python",
				"latex",
				"json",
				"html",
				"css",
				"javascript",
				"typescript",
				"bash",
				"markdown",
				"markdown_inline",
			},
            sync_install = false, -- Disable automatic installation
			highlight = { enable = true }, -- Enable syntax highlighting
			indent = { enable = true }, -- Enable indentation based on treesitter
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn",
					node_incremental = "grn",
					node_decremental = "grm",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
			},
		})
	end,
}
