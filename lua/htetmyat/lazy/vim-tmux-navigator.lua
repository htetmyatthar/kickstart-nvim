return {
	"christoomey/vim-tmux-navigator",
	-- this can sometimes refresh the netrw if you are in netrw
	-- event = "BufReadPre",
	config = function()
		-- WARN: I commented out the line 6442 of netrw.vim file to use 
		-- change to configure <C-l> to <C-t> to use refresh in netrw
		-- /home/htetmyat/neovim/share/nvim/runtime/autoload/netrw.vim

		vim.keymap.set("n", "<c-h>", "<cmd>TmuxNavigateLeft<CR>");
		vim.keymap.set("n", "<c-j>", "<cmd>TmuxNavigateDown<CR>");
		vim.keymap.set("n", "<c-k>", "<cmd>TmuxNavigateUp<CR>");
		vim.keymap.set("n", "<c-l>", "<cmd>TmuxNavigateRight<CR>");
	end,
}
