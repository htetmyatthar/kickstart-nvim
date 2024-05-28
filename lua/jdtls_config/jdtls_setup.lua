local M = {}

function M.setup()
	local home = os.getenv("HOME")
	local jdtls = require("jdtls")
	local jdtls_dap = require("jdtls.dap")

	local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
	local root_dir = require("jdtls.setup").find_root(root_markers)

	local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
	local workspace_dir = home .. '/java_workspace/' .. project_name

	local path_to_mason_packages = home .. "/.local/share/nvim/mason/packages"
	local path_to_jdtls = path_to_mason_packages .. "/jdtls"
	local path_to_jdebug = path_to_mason_packages .. "/java-debug-adapter"
	local path_to_jtest = path_to_mason_packages .. "/java-test"
	local path_to_config = path_to_jdtls .. "/config_linux"
	local lombok_path = path_to_jdtls .. "/lombok.jar"
	local path_to_jar = path_to_jdtls .. "/plugins/org.eclipse.equinox.launcher_1.6.800.v20240330-1250.jar"

	local bundles = {
		vim.fn.glob(path_to_jdebug .. "/extension/server/com.microsoft.java.debug.plugin-0.50.0.jar", true),
	}

	vim.list_extend(bundles, vim.split(vim.fn.glob(path_to_jtest .. "/extension/server/*.jar", true), "\n"))

	local on_attach = function(_, bufnr)
		jdtls.setup_dap({ hotcodereplace = "auto" })
		jdtls_dap.setup_dap_main_class_configs()

		local nmap = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
		end

		-- Key mappings
		nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
		nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

		local builtin = require("telescope.builtin")
		nmap('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
		nmap("gr", builtin.lsp_references, "[G]oto [R]eferences")
		nmap("gI", builtin.lsp_implementations, "[G]oto [I]mplementation")
		nmap("<leader>D", builtin.lsp_type_definitions, "Type [D]efinition")
		nmap("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
		nmap("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
		nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
		nmap("<leader>hh", vim.lsp.buf.signature_help, "Signature [H][H]elp Documentation")
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

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = {
		textDocument = {
			completion = {
				completionItem = {
					snippetSupport = true,
					preselectSupport = true,
					deprecatedSupport = true,
				}
			}
		}
	}
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

	local config = {
		flags = { allow_incremental_sync = true },
		cmd = {
			"java",
			"-Declipse.application=org.eclipse.jdt.ls.core.id1",
			"-Dosgi.bundles.defaultStartLevel=4",
			"-Declipse.product=org.eclipse.jdt.ls.core.product",
			"-Dlog.protocol=true",
			"-Dlog.level=ALL",
			"-Xmx1g",
			"-javaagent:" .. lombok_path,
			"--add-modules=ALL-SYSTEM",
			"--add-opens", "java.base/java.util=ALL-UNNAMED",
			"--add-opens", "java.base/java.lang=ALL-UNNAMED",
			"-jar", path_to_jar,
			"-configuration", path_to_config,
			"-data", workspace_dir,
		},
		settings = {
			java = {
				references = { includeDecompiledSources = true },
				eclipse = { downloadSources = true },
				maven = { downloadSources = true },
				signatureHelp = { enabled = true },
				completion = {
					favoriteStaticMembers = {
						"org.hamcrest.MatcherAssert.assertThat",
						"org.hamcrest.Matchers.*",
						"org.hamcrest.CoreMatchers.*",
						"org.junit.jupiter.api.Assertions.*",
						"java.util.Objects.requireNonNull",
						"java.util.Objects.requireNonNullElse",
						"org.mockito.Mockito.*",
					},
					filteredTypes = {
						"com.sun.*", "io.micrometer.shaded.*", "java.awt.*", "jdk.*", "sun.*",
					},
					importOrder = { "java", "javax", "com", "org" },
				},
				sources = {
					organizeImports = {
						starThreshold = 9999,
						staticStarThreshold = 9999,
					},
				},
				codeGeneration = {
					toString = {
						template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
					},
					useBlocks = true,
				},
				-- to use with :JdtSetRuntime command.
				-- configuration = {
				-- 	runtimes = {
				-- 		name = "",
				-- 		path = ""
				-- 	}
				-- }
			},
		},
		on_attach = on_attach,
		capabilities = capabilities,
		init_options = {
			bundles = bundles,
			extendedClientCapabilities = require 'jdtls'.extendedClientCapabilities,
		},
	}

	config.init_options.extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

	-- Start Server
	jdtls.start_or_attach(config)

	-- Set java specific keymap
	require("jdtls_config.keymaps")
end

return M
