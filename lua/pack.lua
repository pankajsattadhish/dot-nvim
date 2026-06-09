vim.pack.add({
	{ src = "https://github.com/vague-theme/vague.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/Saghen/blink.cmp" },
	{ src = "https://github.com/saghen/blink.compat" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/ray-x/go.nvim" },
	{ src = "https://github.com/wakatime/vim-wakatime" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/refractalize/oil-git-status.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-mini/mini.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
	{ src = "https://github.com/ThePrimeagen/99" },
})

require("vague").setup({ transparent = true })
vim.cmd.colorscheme("vague")
vim.api.nvim_set_hl(0, "TabLineSel", { bg = "#e0e0e0", fg = "#16161d", bold = true })

require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()
require("mini.surround").setup()
require("mini.pairs").setup()
require("mini.ai").setup()
require("mini.bracketed").setup()
-- require("mini.statusline").setup()

require("mini.diff").setup({
	view = {
		style = "sign",
		signs = { add = "▎", change = "▎", delete = "" },
	},
	source = require("mini.diff").gen_source.git({ index = false }),
})

vim.keymap.set({ "n", "x" }, "<leader>hs", function()
	require("mini.diff").operator("apply")
end, { desc = "Stage Hunk" })
vim.keymap.set({ "n", "x" }, "<leader>hr", function()
	require("mini.diff").operator("reset")
end, { desc = "Reset Hunk" })
vim.keymap.set("n", "<leader>hv", function()
	require("mini.diff").toggle_overlay()
end, { desc = "Toggle Hunk View" })

require("blink.cmp").setup({
	snippets = { preset = "default" },
	keymap = {
		preset = "default",
		["<Tab>"] = { "select_next", "fallback" },
		["<S-Tab>"] = { "select_prev", "fallback" },
		["<CR>"] = { "accept", "fallback" },
		["<C-j>"] = { "snippet_forward", "fallback" },
		["<C-k>"] = { "snippet_backward", "fallback" },
		["<C-e>"] = { "hide", "fallback" },
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
		default = {
			"lsp",
			"path",
			"snippets",
			"buffer",
		},
		per_filetype = {
			sql = { "lsp", "snippets", "buffer" },
		},
		providers = {
			lsp = {
				score_offset = 90,
			},
		},
	},
})

require("blink.compat")

require("go").setup()

require("oil").setup({
	default_file_explorer = true,
	delete_to_trash = true,
	lsp_file_methods = {
		enabled = true,
		timeout_ms = 1000,
		autosave_changes = true,
	},
	columns = {
		"icon",
	},
	win_options = {
		signcolumn = "yes:2",
	},
	view_options = { show_hidden = true, natural_order = true },
	float = {
		max_width = 0.3,
		max_height = 0.8,
		border = "rounded",
	},
})

require("oil-git-status").setup({
	show_ignored = false,
})

vim.keymap.set("n", "<leader>e", ":Oil<CR>", { silent = true, desc = "Open file explorer" })
vim.keymap.set("n", "-", function()
	vim.cmd("Oil --float")
end, { desc = "Open Oil Float" })

require("conform").setup({
	format_on_save = {
		timeout_ms = 8000,
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescript = { "prettierd" },
		typescriptreact = { "prettierd" },
		graphql = { "prettierd" },
		go = { "goimports", "gofmt" },
		json = { "prettierd" },
		html = { "prettierd" },
		css = { "prettierd" },
		markdown = { "prettierd" },
		yaml = { "prettierd", "yamlfmt" },
		python = { "black" },
		rust = { "rustfmt" },
		bash = { "shfmt" },
		sh = { "shfmt" },
		java = { "google-java-format" },
		cpp = { "clang_format" },
		c = { "clang_format" },
		sql = { "sql_formatter" },
	},
	formatters = {
		sql_formatter = {
			prepend_args = { "--language", "postgresql" },
		},
	},
})

vim.keymap.set("n", "<leader>lf", function()
	require("conform").format({ async = true, timeout_ms = 8000 })
end, { desc = "Format Code" })

require("fzf-lua").setup({
	keymap = {
		builtin = {
			["<C-d>"] = "preview-page-down",
			["<C-u>"] = "preview-page-up",
		},
	},
	winopts = { flags = "half" },
})
vim.keymap.set("n", "<leader>;", "<cmd>FzfLua builtin<cr>", { desc = "FzfLua Pickers" })
vim.keymap.set("n", "<leader><BS>", "<cmd>FzfLua resume<cr>", { desc = "Last Picker" })
vim.keymap.set("n", "<leader>f", "<cmd>FzfLua files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>s", "<cmd>FzfLua live_grep<cr>", { desc = "Find live grep" })
vim.keymap.set("n", "<leader>d", "<cmd>FzfLua diagnostics_workspace<cr>", { desc = "Diagnostics Workspace" })
vim.keymap.set("n", "<leader>/", "<cmd>FzfLua grep_curbuf<cr>", { desc = "Search in Current Buff" })
vim.keymap.set("n", "<leader>m", "<cmd>FzfLua marks<cr>", { desc = "Search Marks" })

require("render-markdown").setup({ anti_conceal = { enabled = false }, file_types = { "markdown" } })
