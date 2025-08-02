-- Neovim LSP configuration with Conform for formatting, Mason for managing LSP servers,
-- cmp for autocompletion,
-- LuaSnip for snippets,
-- fidget for LSP progress,
-- and various language servers setup.

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"stevearc/conform.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
	},

	config = function()
		-------------------------------
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
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				-- ["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				-- show LSP suggestions first, then snippets, then Copilot
				{ name = "nvim_lsp", group_index = 1 },
				{ name = "luasnip", group_index = 1 },
				{ name = "copilot", group_index = 2 },
				{ name = "dictionary", group_index = 2 },
			}, {
				{ name = "buffer" },
			}),
		})

		----------------------------------------
		-- Setup mason for LSP server management
		----------------------------------------
		require("mason").setup({})

		-- Keymaps for LSP actions
		local on_attach = function(_, bufnr)
			local map = function(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
			end

			map("n", "K", vim.lsp.buf.hover, "Hover Doc")
			map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
			map("n", "<leader>a", vim.lsp.buf.code_action, "Code Action")
			-- map("x", "<leader>a", vim.lsp.buf.range_code_action, "Code Action (range)")
			map("n", "<leader>qf", function()
				vim.lsp.buf.code_action({ apply = true, context = { only = { "quickfix" } } })
			end, "Quickfix")
			map("n", "<leader>d", function()
				vim.diagnostic.open_float(nil, { scope = "line" })
			end, "Show line diagnostics")

			map("n", "[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
			map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
			map("n", "<leader>dl", vim.diagnostic.setloclist, "Set Loclist")

			map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
			map("n", "gy", vim.lsp.buf.type_definition, "Goto Type Def")
			map("n", "gi", vim.lsp.buf.implementation, "Goto Implementation")

			map("n", "gr", vim.lsp.buf.references, "Goto References")
			map("n", "[g", vim.diagnostic.goto_prev, "Prev Diagnostic")
			map("n", "]g", vim.diagnostic.goto_next, "Next Diagnostic")
		end

		--------------------
		-- Setup LSP servers
		--------------------
		local lspconfig = require("lspconfig")

		lspconfig.ts_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" }, -- Recognize 'vim' as a global variable
					},
					workspace = {
						checkThirdParty = false, -- Disable third-party checks
					},
				},
			},
		})

		lspconfig.pyright.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				python = {
					analysis = {
						typeCheckingMode = "basic", -- Set type checking mode
						autoSearchPaths = true, -- Enable automatic search paths
						useLibraryCodeForTypes = true, -- Use library code for type inference
					},
				},
			},
		})

		lspconfig.clangd.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			cmd = { "clangd", "--background-index", "--clang-tidy" }, -- Enable background indexing and clang-tidy
		})

		lspconfig.jsonls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				json = {
					validate = { enable = true },
				},
			},
		})

		lspconfig.html.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "html", "htmldjango" }, -- Add htmldjango support
		})

		lspconfig.cssls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "css", "scss", "less" }, -- Add support for CSS preprocessors
		})

		lspconfig.bashls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "sh", "bash" }, -- Add support for shell scripts
		})

		lspconfig.texlab.setup({
			capabilities = capabilities,
			on_attach = on_attach,
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
		})

		lspconfig.ltex_plus.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "tex", "bib", "markdown", "text" },
			settings = {
				ltex = {
					language = "en-US", -- Set default language
					diagnosticSeverity = "information", -- Set diagnostic severity
					dictionary = {
						["en-US"] = { "Neovim", "LuaSnip", "cmp", "ltex", "immersification" }, -- Custom dictionary words
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
		})

		------------------------------
		--- Setup LuaSnip and snippets
		------------------------------

		local luasnip = require("luasnip")
		luasnip.config.set_config({
			history = true,
			updateevents = "TextChanged,TextChangedI",
		})

		require("luasnip.loaders.from_vscode").lazy_load() -- friendly-snippets
		require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/snippets" })

		--------------------------------------
		--- Setup fidget and diagnostic config
		--------------------------------------
		require("fidget").setup({})
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
