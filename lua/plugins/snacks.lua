return {
	-- Snacks: All-in-one utility plugin.
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,

	opts = {
		bigfile = { enabled = true },
		dashboard = { enabled = false },
		explorer = { enabled = false },
		toggle = { enabled = true },
		indent = {
			enabled = false,
			indent = {
				char = "│",
				hl = "SnacksIndent",
				scope = {
					enabled = true,
					char = "┃",
					hl = "SnacksIndentScope",
				},
			},
		},
		input = { enabled = true },
		notifier = { enabled = true, timeout = 2000 },
		picker = {
			enabled = true,
			layout = "ivy",

			layouts = {
				ivy = {

					layout = {
						box = "vertical",
						backdrop = false,
						row = -1,
						width = 0,
						height = 0.45,
						border = "none",
						title = " {title} {live} {flags}",
						title_pos = "left",
						{ win = "input", height = 1, border = "none" },
						{
							box = "horizontal",
							{ win = "list", border = "none" },
							{ win = "preview", title = "{preview}", width = 0.6, border = "left" },
						},
					},
				},
			},
		},
		quickfile = { enabled = true },
		scope = { enabled = false },
		scroll = { enabled = false },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		styles = { notification = {} },
		gh = {},
		terminal = {
			win = {
				style = "minimal",
				border = "rounded",
				height = 10,
				wo = {
					winbar = "", -- Removes the 'term://...' line at the top of the window
					statusline = "", -- Removes the status information at the bottom
				},
			},
		},
	},

	keys = {
		{
			"<leader>n",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Notifications",
		},
		{
			"]r",
			function()
				Snacks.words.jump(vim.v.count1)
			end,
			desc = "Next Reference",
			mode = { "n", "t" },
		},
		{
			"[r",
			function()
				Snacks.words.jump(-vim.v.count1)
			end,
			desc = "Prev Reference",
			mode = { "n", "t" },
		},

		-- Buffers
		{
			"<leader>bo",
			function()
				Snacks.picker.buffers({
					win = {
						input = {
							keys = { ["dd"] = "bufdelete", ["<c-d>"] = { "bufdelete", mode = { "n", "i" } } },
						},
						list = { keys = { ["dd"] = "bufdelete" } },
					},
				})
			end,
			desc = "Open Buffers",
		},
		{
			"<leader>bd",
			function()
				Snacks.bufdelete()
			end,
			desc = "Delete Buffer",
		},

		-- Diagnostics
		{
			"<leader>dd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Workspace Diagnostics",
		},
		{
			"<leader>dD",
			function()
				Snacks.picker.diagnostics_buffer()
			end,
			desc = "Buffer Diagnostics",
		},
		{
			"<leader>dq",
			function()
				Snacks.picker.qflist()
			end,
			desc = "Quickfix",
		},
		{
			"<leader>dl",
			function()
				Snacks.picker.loclist()
			end,
			desc = "Location List",
		},

		-- Find
		{
			"<leader>ps",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep live",
			mode = { "n", "x" },
		},
		{
			"<leader>pr",
			function()
				Snacks.picker.lsp_references()
			end,
			desc = "References",
			nowait = true,
		},
		{
			"<leader>pf",
			function()
				Snacks.picker.files()
			end,
			desc = "Files",
		},
		{
			"<C-p>",
			function()
				Snacks.picker.files({ layout = "select" })
			end,
			desc = "Files",
		},
		{
			"<leader>/",
			function()
				Snacks.picker.grep_buffers()
			end,
			desc = "Grep Buffers",
		},

		-- Git
		{
			"<leader>gl",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Log",
		},
		{
			"<leader>gf",
			function()
				Snacks.picker.git_log_file()
			end,
			desc = "Log (file)",
		},
		{
			"<leader>gs",
			function()
				Snacks.picker.git_status()
			end,
			desc = "Status",
		},

		-- LSP
		{
			"<leader>ls",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "Document Symbols",
		},
		{
			"<leader>lS",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "Workspace Symbols",
		},

		-- Search
		{
			"<leader>sh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help",
		},
		{
			"<leader>si",
			function()
				Snacks.picker.icons()
			end,
			desc = "Icons",
		},
		{
			"<leader>su",
			function()
				Snacks.picker.undo()
			end,
			desc = "Undo History",
		},

		-- Basic toggles
		{
			"<leader>uw",
			function()
				Snacks.toggle.option("wrap"):toggle()
			end,
			desc = "Wrap",
		},
		{
			"<leader>uc",
			function()
				Snacks.toggle.option("conceallevel"):toggle()
			end,
			desc = "Conceallevel",
		},
		{
			"<leader>us",
			function()
				Snacks.toggle.option("spell"):toggle()
			end,
			desc = "Spell",
		},
		{
			"<leader>uh",
			function()
				Snacks.toggle.inlay_hints():toggle()
			end,
			desc = "Inlay Hints",
		},
		{
			"<leader>ud",
			function()
				Snacks.toggle.diagnostics():toggle()
			end,
			desc = "Diagnostics",
		},
		{
			"<leader>ui",
			function()
				Snacks.toggle.indent():toggle()
			end,
			desc = "Indent Lines",
		},
	},
}
