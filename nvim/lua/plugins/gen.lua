-- Gen.nvim is a plugin for Neovim that provides an interface to
-- interact with large language models (LLMs)
-- TODO find a cmp version of this plugin

return {
	"David-Kunz/gen.nvim",
	config = function()
		require("gen").setup({
			-- Model options
			model = "deepcoder:latest",
			-- model = "deepseek-r1:latest",
			-- model = "deepseek-r1:14b",
			-- model = "deepseek-r1:32b",
			-- model = "deepseek-r1:70b",
			-- model = "deepseek-coder-v2",
			-- model = "llama3.1:8b",
			-- model = "llama3.3",
			-- model = "mistral-small:24b",
			-- model = "gemma:3.27b",
			-- model = "mistral-nemo:latest",
			host = "localhost",
			port = "11434",

			-- Display behavior
			display_mode = "float", -- Clean, centered popup window
			show_model = false, -- Optional: hide model name for less clutter
			show_prompt = true, -- Show the prompt used at top of output
			result_filetype = "markdown", -- Syntax highlight + formatting
			no_auto_close = false, -- Auto-close result buffer after accepting

			-- Key mappings inside Gen buffer
			quit_map = "<Esc>", -- close Gen buffer
			retry_map = "<C-r>", -- retry last prompt
			accept_map = "<C-CR>", -- send accepted content to current buffer
		})

		-- Check if Ollama is running
		local function is_ollama_running()
			local handle = io.popen("curl -s --max-time 0.5 http://localhost:11434/api/tags")
			if not handle then
				return false
			end
			local result = handle:read("*a")
			handle:close()
			return result ~= ""
		end

		if is_ollama_running() then
			local map = vim.keymap.set
			local opts = { noremap = true, silent = true }

			map({ "n", "v" }, "<leader>gg", ":Gen Chat<CR>", vim.tbl_extend("force", opts, { desc = "Gen: Chat" }))
			map({ "n", "v" }, "<leader>ga", ":Gen Ask<CR>", vim.tbl_extend("force", opts, { desc = "Gen: Ask" }))
		else
			vim.schedule(function()
				vim.notify(
					"⚠️ Ollama is not running on localhost:11434. :Gen mappings not loaded.",
					vim.log.levels.WARN
				)
			end)
		end
	end,
}
