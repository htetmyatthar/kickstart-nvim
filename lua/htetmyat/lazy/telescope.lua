return {
	-- due to incompatibilities with nvim-jdtls, download from the source github.
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable 'make' == 1
			end,
		},
		{ "nvim-tree/nvim-web-devicons", opts = {} },
	},
	config = function()
		require("telescope").setup {
			defaults = {
				mappings = {
					i = {
						['<C-u>'] = false,
						['<C-d>'] = false,
					},
				},
			},
			extensions = {
				fzf = {},
			},
			pickers = {
				disable_devicons = true
			}
		}

		pcall(require("telescope").load_extension, "fzf")
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "[S]earch [G]it files" })
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch [W]ord" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
		vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "[?] ?ind recently opened files" })
		vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "[ ]ind existing buffers" })
		vim.keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
				winblend = 10,
				previewer = false,
			})
		end, { desc = "[/] Fuzzily search in current buffer" })

		-- Shortcut for searching your neovim configuration files
		vim.keymap.set('n', '<leader>sn', function()
			builtin.find_files { cwd = vim.fn.stdpath 'config' }
		end, { desc = '[S]earch [N]eovim files' })
	end
}
