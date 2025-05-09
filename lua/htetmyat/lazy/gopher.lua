return {
	-- WARN: to use this plugin you must configure GOPATH, GOBIN to found the executables installed by GoInstallDeps
	{
		"olexsmir/gopher.nvim",
		requires = { -- dependencies
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		build = function()
			vim.cmd [[silent! GoInstallDeps]]
		end,
	},
	vim.keymap.set("n", "<leader>Gj", "<Cmd> GoTagAdd json <CR>", { desc = "add [G]o [J]son tag" }),
	vim.keymap.set("n", "<leader>Gy", "<Cmd> GoTagAdd yaml <CR>", { desc = "add [G]o [Y]aml tag" }),
	vim.keymap.set("n", "<leader>Ge", "<Cmd> GoIfErr <CR>", { desc = "add [G]o if [E]rr != nil" }),
}
