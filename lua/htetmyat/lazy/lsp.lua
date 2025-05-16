return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs to stdpath for Neovim
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",

		-- Useful status updates for LSP
		{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },

		-- Additional Lua configuration
		"folke/neodev.nvim",
	},
	config = function()
		-- Define on_attach function
		local on_attach = function(_, bufnr)
			local nmap = function(keys, func, desc)
				if desc then
					desc = "LSP: " .. desc
				end
				vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
			end

			nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[N]ame")
			nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode[A]ction")

			local builtin = require("telescope.builtin")
			nmap("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
			nmap("gr", builtin.lsp_references, "[G]oto [R]eferences")
			nmap("gI", builtin.lsp_implementations, "[G]oto [I]mplementation")
			nmap("<leader>D", builtin.lsp_type_definitions, "Type [D]efinition")
			nmap("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbol")
			nmap("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

			nmap("K", vim.lsp.buf.hover, "Hover Documentation")
			nmap("<C-s>", vim.lsp.buf.signature_help, "Hover Signature Documentation")

			nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
			nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
			nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
			nmap("<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, "[W]orkspace [L]ist Folders")

			vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
				vim.lsp.buf.format()
			end, { desc = "Format current buffer with LSP" })
		end

		-- Set up Neodev for Lua development
		require("neodev").setup({
			library = {
				plugins = { "nvim-dap-ui" },
				types = true,
			},
		})

		-- Set up Mason and Mason-LSPConfig
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"clangd",
				"gopls",
				"pyright",
				"rust_analyzer",
				"ts_ls",
				"lua_ls",
				"jsonls",
				"templ",
				"html",
				"htmx",
				"emmet_ls",
				"tailwindcss",
				"sqlls",
			},
		})

		-- Set up LSP capabilities with nvim-cmp
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		-- Define server configurations
		local servers = {
			clangd = {
				filetypes = { "c" },
			},
			gopls = {
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				allExperiments = true,
				templateExtensions = { "html", "gohtmltmpl", "gohtml", "gotmpl", ".html.gotmpl", ".gotmpl.html" },
				gofumpt = true,
				analyses = {
					unusedparams = true,
					fieldalignment = true,
					unusedvariable = true,
				},
				vulncheck = "Imports",
				staticcheck = true,
				settings = {
					gopls = {
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
					},
				},
			},
			pyright = {},
			rust_analyzer = {},
			ts_ls = {
				javascript = {
					inlayHints = {
						includeInlayEnumMemberValueHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayVariableTypeHints = true,
					},
				},
				typescript = {
					inlayHints = {
						includeInlayEnumMemberValueHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayVariableTypeHints = true,
					},
				},
			},
			lua_ls = {
				settings = {
					Lua = {
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
						hint = { enable = true },
					},
				},
			},
			jsonls = {},
			templ = {
				filetypes = { "templ" },
			},
			html = {
				filetypes = { "html" },
			},
			htmx = {
				filetypes = { "templ", "html" },
			},
			emmet_ls = {
				filetypes = { "css", "html", "templ" },
			},
			tailwindcss = {
				filetypes = { "templ" },
			},
			sqlls = {
				filetypes = { "sql" },
			},
		}

		-- Configure each server using vim.lsp.config
		for server_name, config in pairs(servers) do
			-- Skip jdtls if you don't want it configured here
			if server_name ~= "jdtls" then
				vim.lsp.config(server_name, {
					capabilities = capabilities,
					on_attach = on_attach,
					settings = config.settings or (config[server_name] or {}),
					filetypes = config.filetypes,
				})
			end
		end

		-- Manually set up servers not yet migrated to vim.lsp.config
		local lspconfig = require("lspconfig")
		for _, server_name in ipairs({ "templ", "htmx", "sqlls" }) do
			if servers[server_name] then
				lspconfig[server_name].setup({
					capabilities = capabilities,
					on_attach = on_attach,
					settings = servers[server_name].settings or {},
					filetypes = servers[server_name].filetypes,
				})
			end
		end
	end,
}
