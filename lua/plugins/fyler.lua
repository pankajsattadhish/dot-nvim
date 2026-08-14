vim.pack.add({ "https://github.com/FylerOrg/fyler.nvim" })

local fyler = require("fyler")
fyler.setup({
	auto_confirm_simple_mutation = false,
	bound_cursor = true,
	follow_current_file = true,
	use_as_default_explorer = true,
	kind = "replace",
	extensions = {
		git = { enabled = true, inline = true },
	},
	integrations = {
		icon = "mini_icons",
	},
	kind_presets = {
		floating = {
			border = "rounded",
			height = "90%",
			width = "30%",
			col = "center",
			row = "center",
			mappings = { n = { ["<CR>"] = { action = "select", args = { close = true } } } },
		},
		replace = {
			mappings = { n = { ["<CR>"] = { action = "select", args = { close = true } } } },
		},
		split_left = { width = "30%" },
		split_left_most = { width = "20%" },
		split_right = { width = "30%" },
		split_right_most = { width = "30%" },
	},
	mappings = {
		n = {
			["-"] = { action = "visit", args = { parent = true } },
			["."] = { action = "visit", args = { cursor = true } },
			["<BS>"] = { action = "shrink", args = { parent = true } },
			["<C-R>"] = { action = "refresh" },
			["<C-S>"] = { action = "select", args = { split = true } },
			["<C-T>"] = { action = "select", args = { tabedit = true } },
			["<C-V>"] = { action = "select", args = { vsplit = true } },
			["<CR>"] = { action = "select" },
			["="] = { action = "visit" },
			["g."] = { action = "toggle_ui", args = { "hidden_items" } },
			["gi"] = { action = "toggle_ui", args = { "indent_guides" } },
			["q"] = { action = "close" },
		},
	},
	ui = {
		hidden_items = {
			switches = { "dotfiles" },
			patterns = {},
			always_visible = {},
			always_hidden = {},
		},
		indent_guides = true,
	},
})

vim.keymap.set("n", "<leader>op", function()
	require("fyler").toggle({ kind = "split_left_most" })
end, { desc = "Fyler tree sidebar" })
vim.keymap.set("n", "-", function()
	require("fyler").open({ kind = "floating" })
end, { desc = "Fyler tree float" })
