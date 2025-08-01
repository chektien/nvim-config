-- VimTeX configuration for Neovim
-- This is old vimscript but no Lua equivalent exists yet.

return {
	"lervag/vimtex",
	lazy = false, -- Don't lazy load for optimal LaTeX workflow
	init = function()
		vim.g.tex_flavor = "latex"
		vim.g.vimtex_view_method = "skim"
		vim.g.vimtex_view_general_viewer = "skim"
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_compiler_latexmk = {
			build_dir = "build",
			callback = 1,
			continuous = 1,
			executable = "latexmk",
			options = { "-pdf", "-interaction=nonstopmode", "-synctex=1" },
		}

		-- Skim inverse search
		pcall(function()
			os.remove("/tmp/nvim-skim")
		end)
		pcall(function()
			vim.fn.serverstart("/tmp/nvim-skim")
		end)
	end,
	config = function()
		local map = vim.keymap.set
		local opts = { noremap = true, silent = true }

		map("n", "<leader>lv", "<cmd>VimtexView<CR>", opts)
		map("n", "<leader>ll", "<cmd>VimtexCompile<CR>", opts)
		map("n", "<leader>lt", "<cmd>VimtexTocOpen<CR>", opts)
	end,
	ft = { "tex", "bib" }, -- Load for LaTeX and BibTeX files
}
