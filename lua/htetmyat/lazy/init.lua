return {
	-- git related plugins
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",

	-- detect tabstop and shiftwidth automatically
	-- "tpope/vim-sleuth", -- I set those as defaults in set.lua if you want it uncomment

	"nvim-lua/plenary.nvim",

	-- useful plugin to show you pending keybinds.
	"folke/which-key.nvim",

	-- to work with which-key
	{ "nvim-tree/nvim-web-devicons", opts = {} },
	{ 'echasnovski/mini.nvim',       version = '*' },

	-- "gc" to comment visual regions/lines
	"numToStr/Comment.nvim",

	{
		"mfussenegger/nvim-jdtls",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
	},

	{
		-- Autocompletion
		-- see cmp.lua file.
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- js-regexp library for luasnip
			"kmarius/jsregexp",
			-- Snippet Engine & it's associated nvim-cmp source
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",

			-- Adds LSP completion capabilities
			"hrsh7th/cmp-nvim-lsp",

			-- Adds a number of user-friendly snippets
			"rafamadriz/friendly-snippets",
		},
	},

	-- lightweight rose-pine colorscheme
	{
		"rose-pine/neovim",
		name = "rose-pine",
	},
}
