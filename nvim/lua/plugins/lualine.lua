-- lualine.nvim is a fast and lightweight statusline (bottom bar) plugin for Neovim

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- specially show Skim server in the statusline when editing TeX files
		local skim_server = function()
			if vim.bo.filetype == "tex" then
				local servers = vim.fn.serverlist()
				for _, path in ipairs(servers) do
					if path == "/tmp/nvim-skim" then
						return "🖇 Skim"
					end
				end
			end
			return ""
		end

		-- Setup lualine with various sections showing different info
		require("lualine").setup({
			options = {
				theme = "gruvbox",
				section_separators = "",
				component_separators = "|",
				icons_enabled = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					"filename",
					skim_server,
				},
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = {
					function()
						local current_line = vim.fn.line(".")
						local total_lines = vim.fn.line("$")
						return string.format("Ln %d/%d, Col %d", current_line, total_lines, vim.fn.col("."))
					end,
				},
			},
		})
	end,
}
