return {
	-- git related plugins
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",

	-- -- detect tabstop and shiftwidth automatically
	-- "tpope/vim-sleuth", -- I set those as defaults in set.lua if you want it uncomment

	"nvim-lua/plenary.nvim",

	-- "gc" to comment visual regions/lines
	{"numToStr/Comment.nvim", opts = {} },

	-- useful plugin to show you pending keybinds.
	{ "folke/which-key.nvim", opts = {} },

	--[[ 
		{
			-- add indentation guides even on blank lines
			"lukas-reineke/indent-blankline.nvim",
			main = "ibl",
			opts = {},
		},
	]]

	{
		-- Set lualine as statusline
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				icons_enabled = false,
				theme = "auto",
				section_separators = '',
				component_separators = '',
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				}
			},
			sections = {
				lualine_a = {'mode'},
				lualine_b = {'branch', 'diff', 'diagnostics'},
				lualine_c = {{'filename', path = 1}},
				lualine_x = {'encoding', 'fileformat', 'filetype'},
				lualine_y = {'progress'},
				lualine_z = {'location'},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {'filename'},
				lualine_x = {'location'},
				lualine_y = {},
				lualine_z = {}
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {}
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
	{
		"rose-pine/neovim",
		name = "rose-pine",
	},

	{
		"sourcegraph/sg.nvim",
		dependencies = { "nvim-lua/plenary.nvim", --[[ "nvim-telescope/telescope.nvim ]] },

		-- -- If you have a recent version of lazy.nvim, you don't need to add this!
		-- build = "nvim -l build/init.lua",
	},
	{
		"olexsmir/gopher.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		build = function()
			vim.cmd [[silent! GoInstallDeps]]
		end,
	}
}
