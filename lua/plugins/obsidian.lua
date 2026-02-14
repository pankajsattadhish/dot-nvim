return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",
	dependencies = {
		"folke/snacks.nvim",
		"nvim-lua/plenary.nvim",
		"saghen/blink.cmp",
	},
	opts = {
		workspaces = {
			{
				name = "personal",
				path = "~/library/vaults/personal",
			},
			{
				name = "work",
				path = "~/library/vaults/work",
			},
			{
				name = "brainery",
				path = "~/library/vaults/brainery",
			},
		},

		completion = {
			nvim_cmp = false,
			blink = true,
		},

		daily_notes = {
			folder = "daily",
			date_format = "%Y-%m-%d",
		},

		templates = {
			folder = "_templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
		},

		ui = {
			enable = true,
			picker = "snacks",
		},

		follow_url_func = function(url)
			vim.fn.jobstart({ "xdg-open", url })
		end,
	},

	keys = {
		{ "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New note" },
		{ "<leader>oo", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick switch" },
		{ "<leader>od", "<cmd>ObsidianToday<cr>", desc = "Today note" },
		{ "<leader>ot", "<cmd>ObsidianTemplate<cr>", desc = "Insert template" },
		{ "gf", "<cmd>ObsidianFollowLink<cr>", desc = "Follow link" },
	},
}
