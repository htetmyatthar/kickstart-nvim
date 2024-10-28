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
		end
		-- document existing key chains
		require('which-key').register {
			['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
			['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
			['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
			['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
			['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
			['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
			['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
			['<leader>W'] = { name = 'buffer [W]indow', _ = 'which_key_ignore' },
		}

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
				templateExtensions = { "gohtmltmpl", "gohtml", "gotmpl", ".html.gotmpl", ".gotmpl.html" },
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
			tsserver = {
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
		}
		require("neodev").setup({
			library = {
				plugins = { "nvim-dap-ui" },
				types = true,
			}
		})
		-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
		local capabilities = vim.lsp.protocol.make_client_capabilities()
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
