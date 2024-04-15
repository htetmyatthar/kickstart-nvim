return {
	require('which-key').register {
			['<leader>'] = { name = '[A]dd automatically', _ = 'which_key_ignore' },
			['<leader>G'] = { name = '[A]dd automatically golang', _ = 'which_key_ignore' },
	},
	vim.keymap.set("n", "<leader>Gj", "<Cmd> GoTagAdd json <CR>", {desc = "add [G]o [J]son tag"}),
	vim.keymap.set("n", "<leader>Gy", "<Cmd> GoTagAdd yaml <CR>", {desc = "add [G]o [Y]aml tag"}),
	vim.keymap.set("n", "<leader>Ge", "<Cmd> GoIfErr <CR>", {desc = "add [G]o if [E]rr != nil"}),
}
