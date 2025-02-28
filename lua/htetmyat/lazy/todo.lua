return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		signs = false,
		-- can customize here.
		keywords = {
			-- custom todo flags.
			IDEA = { icon = " ", color = "info" },
			LABEL = { icon = " ", color = "default" },
			ALERT = { icon = " ", color = "warning" },
			DONE = { icon = " ", color = "green" },
			todo = { icon = " ", color = "hint" }, -- small todo for myself.

			-- just to override the icon part of those flags.
			FIX = {
				icon = " ",                     -- icon used for the sign, and in search results
				color = "error",                -- can be a hex color, or a named color (see below)
				alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
				-- signs = false, -- configure signs for some keywords individually
			},
			TODO = { icon = " ", color = "info" },
			HACK = { icon = " ", color = "warning" },
			WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
			PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
			NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
			TEST = { icon = " ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
		},
		colors = {
			green = { "FIXED, FINISHED", "#31CB00" }
		}
	},

	-- map to find the todos with telescope.
	vim.api.nvim_set_keymap("n", "<leader>st", ":TodoTelescope<CR>", { noremap = true })
}
