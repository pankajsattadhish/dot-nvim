return {

	-- Mini.nvim core modules
	{
		"echasnovski/mini.nvim",

		version = false,
		config = function()
			require("mini.surround").setup()
			require("mini.pairs").setup()
			require("mini.bracketed").setup()
			require("mini.trailspace").setup()
		end,
	},

	-- Icons (lazy)
	{ "echasnovski/mini.icons", lazy = true },

	-- MiniDiff (REPLACE gitsigns)
	{
		"echasnovski/mini.diff",
		version = false,
		config = function()
			local diff = require("mini.diff")

			diff.setup({
				view = {
					style = "sign",
					signs = {
						add = "┃",
						change = "┃",
						delete = "▁",
					},
				},
			})

			-- Auto-refresh is handled automatically by mini.diff

			-- KEYMAPS
			vim.keymap.set("n", "]h", function()
				diff.goto_hunk("next")
			end, { desc = "Next Hunk" })

			vim.keymap.set("n", "[h", function()
				diff.goto_hunk("prev")
			end, { desc = "Prev Hunk" })

			vim.keymap.set("n", "<leader>gp", function()
				diff.show_hunks()
			end, { desc = "Preview Hunk" })
		end,
	},
}
