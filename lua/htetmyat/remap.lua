-- personal keymaps.
vim.keymap.set("n", "nt", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>nb", vim.cmd.bnext, {desc = "[N]ext opened [B]uffer"})
vim.keymap.set("n", "<leader>pb", vim.cmd.bprevious, {desc = "[P]revious opened [B]uffer"})
vim.keymap.set("n", "<leader>db", vim.cmd.bdelete, {desc = "[D]elete current [B]uffer"})

vim.keymap.set("n", "<leader>Wv", vim.cmd.vsplit, {desc = "split [W]indow [V]ertically"})
vim.keymap.set("n", "<leader>Wh", vim.cmd.split, {desc = "split [W]indow [H]orizontally"})

-- keymaps for better default experiences
vim.keymap.set({"n", "v"}, "<Space>", "<Nop>", {silent = true})

-- remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", {expr = true, silent = true})
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", {expr = true, silent = true})

-- diagonostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {desc = "Go to previous diagnostic message"})
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {desc = "Go to next diagnostic message"})
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {desc = "Open floating diagonostic message"})
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", {clear = true})
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- see lazy.lsp for this command.
vim.keymap.set("n", "<leader>ft", vim.cmd.Format, {desc = "[F]ormat [T]his file"})

-- open split terminal
vim.keymap.set("n", "st", ":split<CR>:wincmd j<CR>:term<CR>", {desc = "[S]plit [T]erminal"})

-- open tab terminal
vim.keymap.set("n", "tt", ":tabnew<CR>:term<CR>", {desc = "[T]ab [T]erminal"})

-- current buffer dir is root now
vim.keymap.set("n", "FR", ":cd %:p:h<CR>", {desc = "current [F]ile dir is [R]oot"})

-- exit terminal
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", {desc = "Escape Escape exits terminal mode."})

-- change to vb for visual block mode since I'm using copy paste.
vim.api.nvim_set_keymap("n", "vb", "<C-v>", {noremap = true})
