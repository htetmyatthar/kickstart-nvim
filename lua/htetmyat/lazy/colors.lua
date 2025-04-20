-- to use with rose-pine
function ColorMyPencil(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
	"rose-pine/neovim",
	name = "rose-pine",
	--
	-- "navarasu/onedark.nvim",
	-- name = "onedark"
	--
	-- "projekt0n/github-nvim-theme",
	--
	-- "folke/tokyonight.nvim",
	-- name = "tokyonight",
	--
	lazy = false,
	priority = 10000,
	config = function()

		-- rose-pine color setup
		require("rose-pine").setup({
			styles = {
				italic = false,
				bold = false,
				transparency = true,
			},
			disable_background = true,
		})
		vim.cmd("colorscheme rose-pine")
		ColorMyPencil("rose-pine")

		-- tokyonight color setup
		-- require("tokyonight").setup({
		-- 	style = "moon",
		-- 	transparent = true,
		-- 	styles = {
		-- 		comments = { italic = false },
		-- 		keywords = { italic = false },
		-- 	}
		-- })
		-- vim.cmd("colorscheme tokyonight")
		-- ColorMyPencil("tokyonight")

		-- nordic theme
		-- 'AlexvZyl/nordic.nvim',
		-- lazy = false,
		-- priority = 1000,
		-- config = function()
		--     require('nordic').load()
	end
}
