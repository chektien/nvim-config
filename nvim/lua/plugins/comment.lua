-- Comment.nvim is a Lua commenting plugin for easy commenting in Neovim

return {
	"numToStr/Comment.nvim",
	event = "VeryLazy",
	config = function()
		local comment = require("Comment")

		comment.setup({

			-- Keymaps for toggling comments
			toggler = {
				line = "<leader>c",
				block = "<leader>b",
			},

            opleader = {
                line = "<leader>c",
                block = "<leader>b",
            },
		})
	end,
}
