vim.pack.add({
	"https://github.com/Saghen/blink.cmp",
	"https://github.com/rafamadriz/friendly-snippets",
})

require("blink.cmp").setup({
	snippets = { preset = "default" },
	keymap = {
		preset = "default",
		["<CR>"] = { "accept", "fallback" },
		["<C-h>"] = { "hide", "fallback" },
	},
	completion = {
		menu = {
			border = "rounded",
			auto_show = true,
			draw = {
				treesitter = { "lsp" },
				columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
			},
		},
		documentation = { auto_show = true, window = { border = "rounded" } },
	},
	signature = { enabled = true },
	fuzzy = { implementation = "lua" },
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
		per_filetype = { sql = { "lsp", "snippets", "buffer" } },
		providers = { lsp = { score_offset = 90 } },
	},
})
