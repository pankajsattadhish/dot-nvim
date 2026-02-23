-- runtime path adjustment
vim.opt.rtp:prepend(vim.fn.stdpath("config") .. "/lua")

-- plugin list
vim.pack.add({

	-- ui / theme
	{ src = "https://github.com/vague-theme/vague.nvim", name = "vague" },
	{ src = "https://github.com/nvim-mini/mini.nvim", name = "mini" },

	-- treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", name = "nvim-treesitter" },

	-- LSP layer
	{ src = "https://github.com/neovim/nvim-lspconfig", name = "lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim", name = "mason" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim", name = "mason-lspconfig" },

	-- completion
	{ src = "https://github.com/saghen/blink.cmp", name = "blink.cmp" },
	{ src = "https://github.com/L3MON4D3/LuaSnip", name = "luasnip" },
	{ src = "https://github.com/rafamadriz/friendly-snippets", name = "friendly-snippets" },

	-- telescope & utilities
	{ src = "https://github.com/nvim-telescope/telescope.nvim", name = "telescope" },
	{ src = "https://github.com/nvim-lua/plenary.nvim", name = "plenary" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", name = "telescope-fzf-native" },

	-- formatting
	{ src = "https://github.com/stevearc/conform.nvim", name = "conform" },

	-- file navigation
	{ src = "https://github.com/stevearc/oil.nvim", name = "oil" },

	-- editing helpers
	{ src = "https://github.com/tpope/vim-sleuth", name = "vim-sleuth" },
	{ src = "https://github.com/mbbill/undotree", name = "undotree" },
})

-- ensure all plugins are loaded
vim.cmd.packloadall()

require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons() --mock devicons (for Telescope)
require("mini.surround").setup()
require("mini.pairs").setup()
require("mini.indentscope").setup({
	draw = {
		delay = 0,
		animation = function()
			return 0
		end,
	},
	options = { indent_at_cursor = true, try_as_border = true },
})

-- theme
require("vague").setup({ transparent = true })
vim.cmd("colorscheme vague")

-- full transparency
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- treesitter
require("nvim-treesitter.config").setup({
	ensure_installed = {
		"bash",
		"c",
		"cpp",
		"html",
		"java",
		"javascript",
		"json",
		"lua",
		"markdown",
		"python",
		"rust",
		"typescript",
		"vim",
		"yaml",
	},
	highlight = { enable = true },
	indent = { enable = false },
})

-- completion
require("blink.cmp").setup({
	snippets = { preset = "luasnip" },
	keymap = {
		["<C-space>"] = { "show", "hide" },
		["<CR>"] = { "accept", "fallback" },
		["<Tab>"] = { "select_next", "fallback" },
		["<S-Tab>"] = { "select_prev", "fallback" },
	},
	completion = {
		menu = { border = "rounded" },
		documentation = {
			auto_show = true,
			window = { border = "rounded" },
		},
	},
	signature = { enabled = true, window = { border = "rounded" } },
})

-- luasnip
require("luasnip").config.set_config({})
require("luasnip.loaders.from_vscode").lazy_load()

-- telescope
local ig = {
	"--glob=!node_modules/*",
	"--glob=!.git/*",
	"--glob=!dist/*",
	"--glob=!build/*",
	"--glob=!.next/*",
	"--glob=!out/*",
	"--glob=!coverage/*",
	"--glob=!tmp/*",
	"--glob=!.cache/*",
	"--glob=!**/.turbo/*",
	"--glob=!**/.vercel/*",
	"--glob=!**/.pnpm-store/*",
	"--glob=!**/.parcel-cache/*",
	"--glob=!**/.eslintcache/*",
	"--glob=!**/yarn/*",
	"--glob=!**/bun.lockb",
}

local base_rg = {
	"rg",
	"--color=never",
	"--no-heading",
	"--with-filename",
	"--line-number",
	"--column",
	"--smart-case",
	"--hidden",
}

require("telescope").setup({
	defaults = {
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = { horizontal = { preview_width = 0.60 } },
		file_ignore_patterns = {
			"node_modules",
			".git/",
			"dist/",
			"build/",
			".next/",
			"coverage/",
			"%.lock",
			"package%-lock.json",
			"yarn.lock",
		},
		vimgrep_arguments = vim.iter({ base_rg, ig }):flatten():totable(),
	},

	pickers = {
		find_files = {
			hidden = true,
			find_command = vim.iter({ { "rg", "--files", "--hidden" }, ig }):flatten():totable(),
		},
	},

	extensions = { fzf = {} },
})

pcall(require("telescope").load_extension, "fzf")

-- Telescope keymaps
local function tmap(lhs, fn, desc)
	vim.keymap.set("n", lhs, fn, { desc = desc })
end

tmap("<C-p>", function()
	require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({
		hidden = true,
		previewer = false,
		layout_config = { width = 0.5, height = 0.5 },
	}))
end, "File Search")
tmap("<leader>ff", function()
	require("telescope.builtin").find_files({ hidden = true })
end, "Find Files")
tmap("<leader>fs", function()
	require("telescope.builtin").live_grep()
end, "Live Grep")
tmap("<leader>/", function()
	require("telescope.builtin").current_buffer_fuzzy_find()
end, "Buffer Grep")
tmap("<leader>fr", function()
	require("telescope.builtin").lsp_references()
end, "References")
tmap("<leader>fm", function()
	require("telescope.builtin").man_pages()
end, "Man Pages")
tmap("<leader>fk", function()
	require("telescope.builtin").keymaps()
end, "Keymaps")
tmap("<leader>ft", function()
	require("telescope.builtin").builtin()
end, "Telescope")

-- git
tmap("<leader>gb", function()
	require("telescope.builtin").git_bcommits(require("telescope.themes").get_ivy())
end, "Git BCommits")
tmap("<leader>gf", function()
	require("telescope.builtin").git_files()
end, "Git Files")
tmap("<leader>gB", function()
	require("telescope.builtin").git_branches({
		layout_strategy = "horizontal",
		layout_config = { width = 0.99, height = 0.99, preview_width = 0.70 },
	})
end, "Git Branches")
tmap("<leader>gC", function()
	require("telescope.builtin").git_commits(require("telescope.themes").get_ivy())
end, "Git Commits")
tmap("<leader>gs", function()
	require("telescope.builtin").git_status({
		layout_strategy = "horizontal",
		layout_config = { width = 0.99, height = 0.99, preview_width = 0.70 },
	})
end, "Git Status")

-- diagnostics
tmap("<leader>dd", function()
	require("telescope.builtin").diagnostics({ layout_strategy = "vertical", sorting_strategy = "ascending" })
end, "Diagnostics")

-- conform (formatting + linting) - uses Mason for installation
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
		markdown = { "prettier" },
		python = { "black", "isort" },
		rust = { "rustfmt" },
		bash = { "shfmt" },
		sh = { "shfmt" },
		go = { "goimports", "gofmt" },
		java = { "google_java_format" },
		cpp = { "clang_format" },
		c = { "clang_format" },
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

-- Oil.nvim
require("oil").setup({
	default_file_explorer = false, -- you want netrw too
	delete_to_trash = true,
	columns = { "icon" },
	lsp_file_methods = {
		enabled = true,
		autosave_changes = true,
	},
	view_options = { show_hidden = true },
	float = {
		padding = 2,
		max_width = 35,
		max_height = 0.8,
		border = "rounded",
		override = function(conf)
			conf.col = vim.o.columns - conf.width - 2
			return conf
		end,
	},
})
vim.keymap.set("n", "-", "<cmd>Oil --float<cr>", { desc = "Open Oil Float" })

-- Undotree
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Undo Tree" })

-- Mason (package manager for LSP/formatters/linters)
require("mason").setup({
	ui = {
		border = "rounded",
	},
	log_level = vim.log.levels.INFO,
})
