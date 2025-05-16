-- to use with rose-pine
function ColorMyPencil(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- rose pine theme
return {
	"rose-pine/neovim",
	name = "rose-pine",

	lazy = false,
	priority = 10000,
	config = function()
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
	end
}

-- tokyonight theme
-- return {
-- 	"folke/tokyonight.nvim",
-- 	name = "tokyonight",
-- 	lazy = false,
-- 	priority = 10000,
-- 	config = function()
-- 		require("tokyonight").setup({
-- 			style = "moon",
-- 			transparent = true,
-- 			styles = {
-- 				comments = { italic = false },
-- 				keywords = { italic = false },
-- 			}
-- 		})
-- 		vim.cmd("colorscheme tokyonight")
-- 		ColorMyPencil("tokyonight")
-- 	end
-- }
