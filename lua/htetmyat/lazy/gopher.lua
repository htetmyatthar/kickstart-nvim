return {
	require('which-key').register {
			['<C-a>'] = { name = '[A]dd automatically', _ = 'which_key_ignore' },
			['<C-a>g'] = { name = '[A]dd automatically golang', _ = 'which_key_ignore' },
	},
	vim.keymap.set("n", "<C-a>gj", "<Cmd> GoTagAdd json <CR>", {desc = "[A]dd [G]o [J]son tag"}),
	vim.keymap.set("n", "<C-a>gy", "<Cmd> GoTagAdd yaml <CR>", {desc = "[A]dd [G]o [Y]aml tag"}),
	vim.keymap.set("n", "<C-a>ge", "<Cmd> GoIfErr <CR>", {desc = "[A]add [G]o if [E]rr != nil"}),
}
