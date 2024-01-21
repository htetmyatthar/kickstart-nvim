return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",

		-- for golang
		"leoluz/nvim-dap-go",
		-- for python
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		local dap = require "dap"
		local dapui = require "dapui"

		require("mason-nvim-dap").setup{
			automatic_installation = true,
			automatic_setup = true,
			handlers = {},

			ensure_installed = {
				"delve", "codelldb", "debugpy"
			},
		}

		vim.keymap.set("n", "<F5>", dap.continue, {desc = "Debug: Start/Continue"})
		vim.keymap.set("n", "<F1>", dap.step_into, {desc = "Debug: Step Into"})
		vim.keymap.set("n", "<F2>", dap.step_over, {desc = "Debug: Step Over"})
		vim.keymap.set("n", "<F3>", dap.step_out, {desc = "Debug: Step Out"})
		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, {desc = "Debug: Toggle Breakpoint"})
		vim.keymap.set("n", "<leader>B", function()
			dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
		end, {desc = "Debug: Set Breakpoint"})

		dapui.setup{
		-- Set icons to characters that are more likely to work in every terminal.
		--    Feel free to remove or use ones that you like more! :)
		--    Don't feel like these are good choices.
			icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
			controls = {
				enabled = true,
				element = "repl",
				icons = {
					pause = '⏸',
					play = '▶',
					step_into = '⏎',
					step_over = '⏭',
					step_out = '⏮',
					step_back = 'b',
					run_last = '▶▶',
					terminate = '⏹',
					disconnect = '⏏',
				},
			},
		}

		vim.keymap.set("n", "<F7>", dapui.toggle, {desc = "Debug: See last session result."})

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		--install golang specific config
		require("dap-go").setup()
		-- install python specific config
		require("dap-python").setup('~/.virtualenvs/debugpy/bin/python')
		-- install C specific config
		if not dap.adapters["codelldb"] then
			require("dap").adapters["codelldb"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "codelldb",
					args = {
						"--port",
						"${port}",
					},
				},
			}
		end
		for _, lang in ipairs({"c", "cpp"}) do
			dap.configurations[lang] = {
				{
					type ="codelldb",
					request = "launch",
					name = "Launch file",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
				},
				{
					type = "codelldb",
					request = "attach",
					name = "Attach to process",
					--processId = require("dap.utils.").pick_process,
					cwd = "${workspaceFolder}",
				},
			}
		end
	end
}
