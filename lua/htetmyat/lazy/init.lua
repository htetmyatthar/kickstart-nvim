return {
	-- git related plugins
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",

	-- detect tabstop and shiftwidth automatically
	--"tpope/vim-sleuth",
	-- I set those as defaults in set.lua

	"nvim-lua/plenary.nvim",

	-- "gc" to comment visual regions/lines
	{"numToStr/Comment.nvim", opts = {} },

	-- useful plugin to show you pending keybinds.
	{ "folke/which-key.nvim", opts = {} },

	-- {
	-- 	-- add indentation guides even on blank lines
	-- 	"lukas-reineke/indent-blankline.nvim",
	-- 	main = "ibl",
	-- 	opts = {},
	-- },

	{
		-- Set lualine as statusline
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				icons_enabled = false,
				theme = "auto",
				component_seperators = "|",
				section_seperators = '',
			},
		},
	},
	{
		-- Autocompletoin
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- Snippet Engine & it's associated nvim-cmp source
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",

			-- Adds LSP completion capabilities
			"hrsh7th/cmp-nvim-lsp",

			-- Adds a number of user-friendly snippets
			"rafamadriz/friendly-snippets",
		},
	},
}
