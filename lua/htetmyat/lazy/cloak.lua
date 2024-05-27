return {
	"laytan/cloak.nvim",
	config = function()
		require("cloak").setup({
			enabled = true,
			cloak_character = "*",
			highlight_group = "Comment",
			patterns = {
				{
					-- Match any files in these.
					file_pattern = {
						".env*",
						"wrangler.toml",
						".dev.vars",
					},
					-- Match an equals sign and any character after it.
					cloak_pattern = "=.+"
				},
			},
		})
	end,
	vim.keymap.set("n", "<leader>tc", vim.cmd.CloakToggle, { desc = "[T]oggle [C]loak" }),
	require("which-key").register {
		["<leader>tc"] = { name = "[T]oggle [C]loak", _ = "which_key_ignore" },
	}
}
