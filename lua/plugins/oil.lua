return {
	"stevearc/oil.nvim",
	opts = {},
	dependencies = { { "nvim-mini/mini.icons", opts = {} } },
	lazy = false,
	config = function()
		require("oil").setup({
			default_file_explorer = false,
			delete_to_trash = true,

			lsp_file_methods = {
				enabled = true,
				timeout_ms = 1000,
				autosave_changes = true,
			},

			columns = {
				"icon",
			},

			float = {
				-- Reduce max_width so it doesn't cover the whole screen (e.g., 30% or 40 columns)
				max_width = 30,
				max_height = 0.8, -- 80% of screen height
				border = "rounded", -- "rounded", nil
				preview_split = "below", --  "auto", "left", "right", "above", "below".
				-- Custom positioning logic
				override = function(conf)
					-- Force it to the left edge
					-- conf.col = 0
					-- conf.row = 2

					-- Force it to the right edge
					local width = vim.o.columns
					local height = vim.o.lines

					-- Set the left-edge position: (Total Width - Window Width)
					conf.col = width - conf.width
					-- Optional: Center it vertically
					conf.row = math.floor((height - conf.height) / 2) - 2

					---

					-- Ensure it stays relative to the whole editor screen
					conf.relative = "editor"
					return conf
				end,
			},

			view_options = {
				show_hidden = true,
			},
		})
	end,

	keys = {
		vim.keymap.set("n", "-", "<cmd>Oil --float<cr>", { desc = "Open floating oil" }),
	},
}
