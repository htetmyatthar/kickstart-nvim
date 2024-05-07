return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()
		require('which-key').register {
			['<leader>h'] = { name = '[H]arpoon', _ = 'which_key_ignore' },
			['<leader>ha'] = { name = '[H]arpoon [A]ppend file', _ = 'which_key_ignore' },
			['<leader>hm'] = { name = '[H]arpoon [M]ain function file', _ = 'which_key_ignore' },
			['<leader>hh'] = { name = '[H]arpoon [H]elper file', _ = 'which_key_ignore' },
			['<leader>hs'] = { name = '[H]arpoon [S]econd helper file', _ = 'which_key_ignore' },
			['<leader>he'] = { name = '[H]arpoon [E]diting file', _ = 'which_key_ignore' },
		}
		vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
		vim.keymap.set("n", "<leader>th", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

		-- main file
		vim.keymap.set("n", "<leader>hm", function() harpoon:list():select(1) end)
		-- helper file
		vim.keymap.set("n", "<leader>hh", function() harpoon:list():select(2) end)
		-- second helper file 1
		vim.keymap.set("n", "<leader>hs", function() harpoon:list():select(3) end)
		-- editing one
		vim.keymap.set("n", "<leader>he", function() harpoon:list():select(4) end)
	end
}
