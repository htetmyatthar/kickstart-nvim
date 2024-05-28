return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		"nvim-neotest/nvim-nio",

		-- for golang
		"leoluz/nvim-dap-go",
		-- for python
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		local dap = require "dap"
		local dapui = require "dapui"

		require("mason-nvim-dap").setup {
			automatic_installation = true,
			automatic_setup = true,
			handlers = {},

			ensure_installed = {
				"delve", "codelldb", "debugpy", "java-debug-adapter", "java-test"
			},
		}

		vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
		vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
		vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
		vim.keymap.set("n", "<F4>", dap.step_back, { desc = "Debug: Step Out" })
		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>B", function()
			dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
		end, { desc = "Debug: Set Breakpoint" })
		vim.keymap.set("n", "<F9>", dap.terminate, { desc = "Debug: Terminate debug session." })

		-- let the defaults to override the mappings and such other settings.
		dapui.setup {
			icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
			controls = {
				enabled = true,
				element = "repl",

				-- uncomment if the font not includes the codeicons.
				-- Set icons to characters that are more likely to work in every terminal.
				--    Feel free to remove or use ones that you like more! :)
				--    Don't feel like these are good choices.
				-- 		icons = {
				-- 			pause = '⏸',
				-- 			play = '▶',
				-- 			step_into = '⏎',
				-- 			step_over = '⏭',
				-- 			step_out = '⏮',
				-- 			step_back = 'b',
				-- 			run_last = '▶▶',
				-- 			terminate = '⏹',
				-- 			disconnect = '⏏',
				-- 		},

			},
		}

		vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		--install golang specific config
		require("dap-go").setup()

		-- install python specific config
		require("dap-python").setup('~/.virtualenvs/debugpy/bin/python')

		-- install C specific config
		for _, lang in ipairs({ "c", "cpp" }) do
			dap.configurations[lang] = {
				{
					name = "Launch file",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}
		end
		dap.configurations.c = dap.configurations.cpp
		dap.configurations.rust = dap.configurations.cpp

		dap.adapters["codelldb"] = {
			type = 'server',
			host = "127.0.0.1",
			port = "${port}",
			executable = {
				-- don't forget to use the vim's buit-in paths.
				command = vim.fn.stdpath('data') .. '/mason/packages/codelldb/extension/adapter/codelldb',
				args = { "--port", "${port}" },

				-- On windows you may have to uncomment this:
				-- detached = false,
			}
		}

		-- java is automatically setup by nvim-dap and jdtls configurations.
	end
}
