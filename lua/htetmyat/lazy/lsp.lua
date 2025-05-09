return {
	-- LSP configuration and plugins
	"neovim/nvim-lspconfig",
	dependencies = {
		-- automatically install LSPs to stdpath for neovim
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",

		-- Useful status updated for LSP
		{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },

		-- Additional lua configuration
		"folke/neodev.nvim",
	},
	config = function()
		local on_attach = function(_, bufnr)
			local nmap = function(keys, func, desc)
				if desc then
					desc = "LSP: " .. desc
				end

				vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
			end
			-- rename the variables and such
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

			-- Lesser used LSP functionality
			nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
			nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
			nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
			nmap('<leader>wl', function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, '[W]orkspace [L]ist Folders')

			-- Create a command `:Format` local to the LSP buffer
			vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
				vim.lsp.buf.format()
			end, { desc = 'Format current buffer with LSP' })


			-- NOTE: this format command creating will shwo which language servers are used to format the file.
			--
			-- vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
			-- 	-- Get active clients for current buffer
			-- 	local active_clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })
			-- 	-- Log before formatting
			-- 	print("Active clients that support formatting:")
			-- 	for _, client in ipairs(active_clients) do
			-- 		if client.server_capabilities.documentFormattingProvider then
			-- 			print(string.format("- %s", client.name))
			-- 		end
			-- 	end
			--
			-- 	-- Perform the formatting
			-- 	vim.lsp.buf.format({
			-- 		-- Optional: specify which client to use for formatting
			-- 		-- filter = function(client)
			-- 		--     return client.name == "templ"  -- or any other specific client
			-- 		-- end,
			-- 		async = true,
			-- 		timeout_ms = 2000,
			-- 		callback = function(err)
			-- 			if err then
			-- 				print("Formatting error:", vim.inspect(err))
			-- 			else
			-- 				print("Formatting complete")
			-- 			end
			-- 		end
			-- 	})
			-- end, { desc = 'Format current buffer with LSP' })
		end
		-- we are strict to make this order.
		require("mason").setup()     -- setup mason
		require("mason-lspconfig").setup() -- setup mason-lspconfi

		local servers = {
			clangd = {
				filetypes = { "c" }
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
					}
				}
			},
			pyright = {},
			rust_analyzer = {},
			ts_ls = {
				-- taken from https://github.com/typescript-language-server/typescript-language-server#workspacedidchangeconfiguration
				javascript = {
					inlayHints = {
						includeInlayEnumMemberValueHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayParameterNameHints = 'all',
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
						includeInlayParameterNameHints = 'all',
						includeInlayParameterNameHintsWhenArgumentMatchesName = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayVariableTypeHints = true,
					},
				},
			},

			lua_ls = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
					hint = { enable = true },
				},
			},
			jsonls = {},
			templ = {
				filetypes = { "templ" },
			},
			html = {
				filetypes = { "html" } -- removed the templ so that .templ files will not be formatted with html lsp.
			},
			htmx = {
				filetypes = { "templ", "html" }
			},
			emmet_ls = {
				filetypes = { "css", "html", "templ" }
			},
			tailwindcss = {
				filetypes = { "template", "templ" }
			},
			sqlls = {
				filetypes = { "sql" }
			}
		}
		require("neodev").setup({
			library = {
				plugins = { "nvim-dap-ui" },
				types = true,
			}
		})
		-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
		-- Ensure the servers above are installed
		local mason_lspconfig = require 'mason-lspconfig'
		mason_lspconfig.setup {
			ensure_installed = vim.tbl_keys(servers),
		}
		mason_lspconfig.setup_handlers {
			function(server_name)
				if (server_name ~= 'jdtls') then
					require('lspconfig')[server_name].setup {
						capabilities = capabilities,
						on_attach = on_attach,
						settings = servers[server_name],
						filetypes = (servers[server_name] or {}).filetypes,
					}
				end
			end,
		}
	end,
}
