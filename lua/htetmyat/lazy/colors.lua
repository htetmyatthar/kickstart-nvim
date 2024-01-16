return {
	{
		-- {
		-- "folke/tokyonight.nvim",
		-- variant = "moon",
		-- },
		--{
		-- "navarasu/onedark.nvim",
		-- style = "darker",
		-- transparent = true,
		-- ending_tildes = true,
		--},
		-- {
		"rose-pine/neovim",
		name = "rose-pine",
		disable_background = true,
		-- },

		priority = 1000,
		config = function()
			vim.cmd.colorscheme "rose-pine"
			vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
			vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
		end,
	},
}
