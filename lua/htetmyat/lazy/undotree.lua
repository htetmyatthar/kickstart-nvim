return {
	"mbbill/undotree",
	config = function()
		vim.keymap.set("n", "<leader>tu", vim.cmd.UndotreeToggle, {desc = "[T]oggle [U]ndotree"})
		require("which-key").register {
			["<leader>tu"] = { name = "[T]oggle [U]ndotree", _ = "which_key_ignore" },
		}
	end
}
