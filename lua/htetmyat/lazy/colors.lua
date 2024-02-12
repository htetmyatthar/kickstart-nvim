return {
	"rose-pine/neovim",
	-- "folke/tokyonight.nvim",
	-- "navarasu/onedark.nvim",
	rose_pine = require("rose-pine"),
	require("rose-pine").setup({
		enable = {
			terminal = true,
			legacy_highlights = true,	-- improve compatibility for previous versions of neovim
			migrations = true,	-- handle deprecated options automatically
		},
		styles = {
			italic = false,
			bold = true,
			transparency = true,
		},
	}),
	priority = 1000,
	config = function()
		vim.cmd.colorscheme "rose-pine"
		-- vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
		-- vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
		-- vim.api.nvim_set_hl(0, "VertSplit", {bg = "none"})
		-- vim.api.nvim_set_hl(0, "Special", {bg = "none"})
		-- vim.api.nvim_set_hl(0, "NormalNC", {bg = "none"})
		-- vim.api.nvim_set_hl(0, "PromptNormal", {bg = "none"})
	end
}
