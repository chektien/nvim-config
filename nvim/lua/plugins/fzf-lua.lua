-- The fast fuzzy finder for Neovim, written in Lua.

return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local fzf = require("fzf-lua")

		fzf.setup({
			winopts = {
				preview = { layout = "vertical" },
			},
		})

		local map = vim.keymap.set
		local opts = { noremap = true, silent = true }

		map("n", "<leader><space><space>", fzf.git_files, opts)
		map("n", "<leader><space>.", function()
			fzf.files({ cwd = "." })
		end, opts)
		map("n", "<leader><space>~", function()
			fzf.files({ cwd = vim.fn.expand("~") })
		end, opts)
		map("n", "<leader><space>g", function()
			fzf.live_grep({
				search = "", -- starts with an empty query
				cwd = vim.fn.getcwd(), -- (optional) force use of current dir
			})
		end, opts)
		map("n", "<leader>/", fzf.blines, opts)
		map("n", "<leader><space>b", fzf.buffers, opts)
        map("n", "<leader><space>h", fzf.help_tags, opts)

		-- Optional: keymap for command maps, similar to <Plug>(fzf-maps-*)
		map("n", "<leader><Tab>", fzf.keymaps, opts)
		map("x", "<leader><Tab>", fzf.keymaps, opts)
		map("o", "<leader><Tab>", fzf.keymaps, opts)
	end,
}
