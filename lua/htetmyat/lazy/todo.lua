return {
	"folke/todo-comments.nvim",
	dependencies = {"nvim-lua/plenary.nvim"},
	opts = {
		signs = false,
		-- can customize here.
	},

	-- map to find the todos with telescope.
	vim.api.nvim_set_keymap("n", "<leader>st", ":TodoTelescope<CR>", {noremap = true})
}
