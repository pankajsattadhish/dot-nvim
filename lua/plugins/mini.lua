return {
	-- Mini.nvim (Core modules)
	{
		"nvim-mini/mini.nvim",
		version = false,
		config = function()
			require("mini.surround").setup()
			require("mini.pairs").setup()
			require("mini.trailspace").setup()
			require("mini.bracketed").setup()
			require("mini.indentscope").setup({
				draw = {
					delay = 0,
					animation = function()
						return 0
					end, -- This effectively kills the animation
				},
				options = {
					-- This makes the scope "smart" about where your cursor is
					indent_at_cursor = true,
					-- Try to locate scope even if cursor is on the border (if/then/end)
					try_as_border = true,
				},
			})
		end,
	},

	-- Mini Icons
	{
		"echasnovski/mini.icons",
		version = false,
		lazy = true,
		config = function()
			require("mini.icons").setup()
		end,
	},

	-- Mini Diff
	{
		"echasnovski/mini.diff",
		version = false,
		config = function()
			local diff = require("mini.diff")

			diff.setup({
				view = {
					style = "sign",
					signs = { add = "┃", change = "┃", delete = "▁" },
				},
			})

			-- Keymaps
			local map = vim.keymap.set
			map("n", "]h", function()
				diff.goto_hunk("next")
			end, { desc = "Next Hunk" })
			map("n", "[h", function()
				diff.goto_hunk("prev")
			end, { desc = "Prev Hunk" })
			map("n", "<leader>gp", function()
				diff.show_hunks()
			end, { desc = "Preview Hunk" })
		end,
	},
}
