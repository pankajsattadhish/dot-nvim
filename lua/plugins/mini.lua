return {

	-- Mini.nvim (Core + Pick)
	{
		"echasnovski/mini.nvim",
		version = false,

		-- Lazy-load picker on key usage
		-- keys = {
		--   -- Files
		--   {
		--     "<leader>pf",
		--     function() require("mini.pick").builtin.files() end,
		--     desc = "Files",
		--   },
		--   {
		--     "<C-p>",
		--     function() require("mini.pick").builtin.files() end,
		--     desc = "Files",
		--   },
		--
		--   -- Live Grep
		--   {
		--     "<leader>ps",
		--     function() require("mini.pick").builtin.grep_live() end,
		--     desc = "Live Grep",
		--     mode = { "n", "x" },
		--   },
		--
		--   -- Buffers
		--   {
		--     "<leader>bo",
		--     function() require("mini.pick").builtin.buffers() end,
		--     desc = "Buffers",
		--   },
		--
		--   -- Diagnostics
		--   {
		--     "<leader>dd",
		--     function() require("mini.pick").builtin.diagnostics() end,
		--     desc = "Diagnostics",
		--   },
		--   {
		--     "<leader>dD",
		--     function()
		--       require("mini.pick").builtin.diagnostics({ scope = "current" })
		--     end,
		--     desc = "Buffer Diagnostics",
		--   },
		--
		--   -- Quickfix / Location list
		--   {
		--     "<leader>dq",
		--     function() require("mini.pick").builtin.quickfix() end,
		--     desc = "Quickfix",
		--   },
		--   {
		--     "<leader>dl",
		--     function() require("mini.pick").builtin.loclist() end,
		--     desc = "Location List",
		--   },
		--
		--   -- LSP
		--   {
		--     "<leader>pr",
		--     function() require("mini.pick").builtin.lsp_references() end,
		--     desc = "References",
		--   },
		--   {
		--     "<leader>ls",
		--     function() require("mini.pick").builtin.lsp_symbols() end,
		--     desc = "Document Symbols",
		--   },
		--   {
		--     "<leader>lS",
		--     function() require("mini.pick").builtin.lsp_workspace_symbols() end,
		--     desc = "Workspace Symbols",
		--   },
		--
		--   -- Help
		--   {
		--     "<leader>ph",
		--     function() require("mini.pick").builtin.help() end,
		--     desc = "Help",
		--   },
		-- },

		config = function()
			require("mini.surround").setup()
			require("mini.pairs").setup()
			require("mini.bracketed").setup()
			require("mini.trailspace").setup()
			-- require("mini.pick").setup()
		end,
	},

	-- Mini Icons (optional)
	{
		"echasnovski/mini.icons",
		lazy = true,
	},

	-- Mini Diff (Git signs)
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

			-- Hunk navigation
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
