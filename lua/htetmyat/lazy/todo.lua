return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		signs = false,
		-- can customize here.
		keywords = {
			IDEA = { icon = " ", color = "default" },
			ALERT = { icon = " ", color = "warning" },
			DONE = { icon = " ", color = "green" },
			todo = { icon = " ", color = "hint" } -- small todo for myself.
		},
		colors = {
			green = { "FIXED, FINISHED", "#31CB00" }
		}
	},

	-- map to find the todos with telescope.
	vim.api.nvim_set_keymap("n", "<leader>st", ":TodoTelescope<CR>", { noremap = true })
}
