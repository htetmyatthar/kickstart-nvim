return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim" -- for ui, remove if you don't use.
	},
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup() -- required important.
		vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
		vim.keymap.set("n", "<leader>th", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

		-- current editing one
		vim.keymap.set("n", "<leader>he", function() harpoon:list():select(1) end)
		-- main file
		vim.keymap.set("n", "<leader>hm", function() harpoon:list():select(2) end)
		-- helper file
		vim.keymap.set("n", "<leader>hh", function() harpoon:list():select(3) end)
		-- second helper file 1
		vim.keymap.set("n", "<leader>hs", function() harpoon:list():select(4) end)
	end
}
