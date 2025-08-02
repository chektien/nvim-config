-- Neovim LSP configuration with
-- - Mason for managing LSP servers,
-- - Conform for formatting,
-- - blink lcmp for autocompletion,
-- - LuaSnip for snippets,
-- - fidget for LSP progress,
-- - and various language servers setup.
-- This file is heavilty inspired by Kickstart.nvim

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} }, -- same as `require("mason").setup({})`
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"stevearc/conform.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/nvim-cmp",
		"saghen/blink.cmp",
		{
			"L3MON4D3/LuaSnip",
			dependencies = {
				"rafamadriz/friendly-snippets",
			},
			config = function()
				require("luasnip").config.set_config({
					history = true,
					updateevents = "TextChanged,TextChangedI",
				})

                -- Load snippets from friendly-snippets and custom Lua snippets
				require("luasnip.loaders.from_vscode").lazy_load()
				require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/snippets" })
			end,
		},
		{ "j-hui/fidget.nvim", opts = {} },
	},

	config = function()
		-- Setup blink.cmp for more power completions
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- Always run when any LSP attaches
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("on-lsp-attach", { clear = true }),
			callback = function(event)
				local bufnr = event.buf
				local client = vim.lsp.get_client_by_id(event.data.client_id)

				-- Reusable function to set keymaps for LSP
				local map = function(mode, keys, func, desc)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- Keymaps for LSP functionality
				map("n", "K", vim.lsp.buf.hover, "Hover Doc")
				map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
				map("n", "<leader>a", vim.lsp.buf.code_action, "Code Action")
				map("n", "<leader>qf", function()
					vim.lsp.buf.code_action({ apply = true, context = { only = { "quickfix" } } })
				end, "Quickfix")
				map("n", "<leader>d", function()
					vim.diagnostic.open_float(nil, { scope = "line" })
				end, "Line diagnostics")
				map("n", "[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
				map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
				map("n", "<leader>dl", vim.diagnostic.setloclist, "Set Loclist")
				map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
				map("n", "gy", vim.lsp.buf.type_definition, "Goto Type Def")
				map("n", "gi", vim.lsp.buf.implementation, "Goto Implementation")
				map("n", "gr", vim.lsp.buf.references, "Goto References")
			end,
		})

		------------------------------
		-- Setup Conform for formatting
		-------------------------------
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				html = { "prettierd" },
				css = { "prettierd" },
				json = { "prettierd" },
				markdown = { "markdownlint" },
				bib = { "bibtex-tidy" },
				tex = { "latexindent" },
				c = { "clang-format" },
				cpp = { "clang-format" },
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			require("conform").format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end, { desc = "Format file with Conform" })

		--------------------------------
		--- Setup cmp for autocompletion
		--------------------------------

		-- setup blink.cmp for more powerful completions
		local blink_cmp = require("blink.cmp")
		blink_cmp.setup({

			-- Use defaults
			-- ["<C-p>"] = { "select_prev" },
			-- ["<C-n>"] = { "select_next" },
			keymap = {
				preset = "default",
				-- ["<CR>"] = { "accept" },
			},

			-- Use mono font variant for appearance
			appearance = {
				nerd_font_variant = "mono",
			},

			-- By default, you may press `<c-space>` to show the documentation.
			-- set `auto_show = true` to show the documentation after a delay.
			completion = {
				documentation = { auto_show = true, auto_show_delay_ms = 500 },
			},

			-- Use the default cmp sources
			-- TODO: figure out how to use cmp_dictionary and cmp_copilot here
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			-- Use lua snippets for completion
			snippets = { preset = "luasnip" }, -- Use LuaSnip for snippets

			-- Use Rust implementation for fuzzy matching
			fuzzy = { implementation = "lua" },

			-- Show a signature help window when completing functions
			signature = { enabled = true },
		})

		----------------------------------------
		-- Setup mason for LSP server management
		----------------------------------------

		-- The list of LSP servers and any custom settings
		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			},

			pyright = {
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic", -- Set type checking mode
						},
					},
				},
			},

			clangd = {
				cmd = { "clangd", "--background-index", "--clang-tidy" }, -- Enable background indexing and clang-tidy
			},

			texlab = {
				filetypes = { "tex", "bib" }, -- Add support for LaTeX and BibTeX
				settings = {
					texlab = {
						build = {
							executable = "latexmk",
							args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
							onSave = true,
						},
						forwardSearch = {
							executable = "skim",
							args = { "--synctex-forward", "%l:1:%f", "%p" },
						},
					},
				},
			},

			ltex_plus = {
				filetypes = { "tex", "bib", "markdown", "text" },
				settings = {
					ltex = {
						language = "en-US", -- Set default language
						diagnosticSeverity = "information", -- Set diagnostic severity
						dictionary = {
							["en-US"] = { "immersification" }, -- Custom dictionary words
						},
						disabledRules = {
							["en-US"] = {
								"TOO_LONG_SENTENCE",
								"PASSIVE_VOICE",
								"WORDINESS",
							},
						},
					},
				},
			},

			html = {
				filetypes = { "html", "htmldjango" }, -- Add htmldjango support
			},

			jsonls = {},
			cssls = {},
			bashls = {},
			marksman = {},
			ts_ls = {},
		}

		-- Define the entire list of things Mason should ensure are installed
		local ensure_installed = vim.tbl_keys(servers)
		vim.list_extend(ensure_installed, {
			"stylua", -- Used to format Lua code
			"black", -- Used to format Python code
			"prettierd", -- Used to format JavaScript, TypeScript, HTML, CSS, JSON
			"markdownlint", -- Used to format Markdown files
			"bibtex-tidy", -- Used to format BibTeX files
			"latexindent", -- Used to format LaTeX files
			"clang-format", -- Used to format C/C++ code
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		-- This method does not work but supposed to be the "better" way to set up LSP servers
		-- require("mason-lspconfig").setup({
		-- 	ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
		-- 	automatic_installation = false,
		-- 	handlers = {
		-- 		function(server_name)
		-- 			vim.notify("Setting up LSP server: " .. server_name, vim.log.levels.INFO)
		-- 			local server = servers[server_name] or {}
		-- 			-- This handles overriding only values explicitly passed
		-- 			-- certain features of an LSP (for example, turning off formatting for ts_ls)
		-- 			server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
		-- 			require("lspconfig")[server_name].setup(server)
		-- 		end,
		-- 	},
		-- })

		-- Since the above method does not work, we use the manual way to set up LSP servers
		local lspconfig = require("lspconfig")
		for name, opts in pairs(servers) do
			opts.capabilities = vim.tbl_deep_extend("force", {}, capabilities, opts.capabilities or {})
			lspconfig[name].setup(opts)
		end

		------------------------------
		--- Setup LuaSnip and snippets
		------------------------------

		-- require("luasnip").config.set_config({
		-- 	history = true,
		-- 	updateevents = "TextChanged,TextChangedI",
		-- 	dependencies = {
		-- 		{
		-- 			"rafamadriz/friendly-snippets",
		-- 			config = function()
		-- 				require("luasnip.loaders.from_vscode").lazy_load()
		-- 				require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/snippets" })
		-- 			end,
		-- 		},
		-- 	},
		-- })

		-- require("luasnip.loaders.from_vscode").lazy_load() -- friendly-snippets
		-- require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/snippets" })

		--------------------------------------
		--- Setup fidget and diagnostic config
		--------------------------------------
		vim.diagnostic.config({
			severity_sort = true,
			underline = { severity = vim.diagnostic.severity.ERROR },
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "if_many",
				header = "",
				prefix = "",
			},
			signs = {
				text = {
					Error = "",
					Warn = "",
					Info = "",
					Hint = "",
				},
			},
			virtual_text = {
				source = "if_many",
				spacing = 2,
				prefix = "◌", -- Could be '●', '▎', 'x'
				format = function(diagnostic)
					local diagnostic_message = {
						[vim.diagnostic.severity.ERROR] = diagnostic.message,
						[vim.diagnostic.severity.WARN] = diagnostic.message,
						[vim.diagnostic.severity.INFO] = diagnostic.message,
						[vim.diagnostic.severity.HINT] = diagnostic.message,
					}
					return diagnostic_message[diagnostic.severity]
				end,
			},
		})

		-- Softer diagnostic virtual text (no bg, dull fg colors)
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#ff5f5f", bg = "NONE", italic = true })
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#ffaa00", bg = "NONE", italic = true })
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#5fafff", bg = "NONE", italic = true })
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#8888aa", bg = "NONE", italic = true })
	end,
}
