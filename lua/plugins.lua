-- runtime path adjustment
vim.opt.rtp:prepend(vim.fn.stdpath("config") .. "/lua")

-- plugin list
vim.pack.add({

	{ src = "https://github.com/vague-theme/vague.nvim", name = "vague" },
	{ src = "https://github.com/nvim-mini/mini.nvim", name = "mini" },

	-- lsp, treesitter & formatting
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", name = "nvim-treesitter" },
	{ src = "https://github.com/neovim/nvim-lspconfig", name = "lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim", name = "mason" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim", name = "mason-lspconfig" },
	{ src = "https://github.com/stevearc/conform.nvim", name = "conform" },

	-- autocompletion
	{ src = "https://github.com/saghen/blink.cmp", name = "blink.cmp" },
	{ src = "https://github.com/rafamadriz/friendly-snippets", name = "friendly-snippets" },

	--  navigation
	{ src = "https://github.com/nvim-telescope/telescope.nvim", name = "telescope" },
	{ src = "https://github.com/nvim-lua/plenary.nvim", name = "plenary" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", name = "telescope-fzf-native" },
	{ src = "https://github.com/stevearc/oil.nvim", name = "oil" },
	{ src = "https://github.com/mbbill/undotree", name = "undotree" },
	{ src = "https://github.com/tpope/vim-fugitive", name = "vim-fugitive" },
	{
		src = "https://github.com/ThePrimeagen/harpoon",
		name = "harpoon",
		branch = "harpoon3",
	},

	-- ai
	{ src = "https://github.com/sudo-tee/opencode.nvim", name = "opencode.nvim" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim", name = "render-markdown" },
})

vim.cmd.packloadall() -- ensure all plugins are loaded

require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons() --mock devicons (for Telescope)
require("mini.surround").setup()
require("mini.pairs").setup()
-- require("mini.indentscope").setup({
-- 	draw = {
-- 		delay = 0,
-- 		animation = function()
-- 			return 0
-- 		end,
-- 	},
-- 	options = { indent_at_cursor = true, try_as_border = true },
-- })

-- theme
require("vague").setup({
	transparent = true,
})

vim.cmd("colorscheme vague")

-- full transparency
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })

-- treesitter
require("nvim-treesitter").setup({
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
	sync_install = true,
	highlight = { enable = true },
	indent = { enable = true },
})

-- completion
require("blink.cmp").setup({
	fuzzy = {
		implementation = "lua",
	},
	keymap = {
		["<C-space>"] = { "show", "hide" },
		["<CR>"] = { "accept", "fallback" },
		["<Tab>"] = { "select_next", "fallback" },
		["<S-Tab>"] = { "select_prev", "fallback" },
	},
	completion = {
		menu = { border = "rounded" },
		documentation = { auto_show = true, window = { border = "rounded" } },
	},
	signature = { enabled = true, window = { border = "rounded" } },
})

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
			coverage = "coverage/",
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

-- telescope keymaps
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
		yaml = { "prettier", "yamlfmt" },
		html = { "prettier" },
		css = { "prettier" },
		markdown = { "prettier" },
		python = { "black", "isort" },
		rust = { "rustfmt" },
		bash = { "shfmt" },
		sh = { "shfmt" },
		go = { "gofmt", "goimports" },
		java = { "google-java-format" },
		cpp = { "clang_format" },
		c = { "clang_format" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

-- oil.nvim
require("oil").setup({
	default_file_explorer = false, -- you want netrw too
	delete_to_trash = true,
	columns = { "icon" },
	lsp_file_methods = {
		enabled = true,
		autosave_changes = true,
	},
	view_options = { show_hidden = true, natural_order = true },
	win_options = { wrap = true },
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

-- undotree
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Undo Tree" })

-- mason (package manager for lsp/formatters/linters)
require("mason").setup({ ui = { border = "rounded" }, log_level = vim.log.levels.INFO })

-- harpoon
local harpoon = require("harpoon")
harpoon:setup()

-- basic keymaps for harpoon
vim.keymap.set("n", "<leader>ha", function()
	harpoon:list():add()
end, { desc = "Harpoon Add" })
vim.keymap.set("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon Menu" })

vim.keymap.set("n", "<C-h>", function()
	harpoon:list():select(1)
end)
vim.keymap.set("n", "<C-j>", function()
	harpoon:list():select(2)
end)
vim.keymap.set("n", "<C-k>", function()
	harpoon:list():select(3)
end)
vim.keymap.set("n", "<C-l>", function()
	harpoon:list():select(4)
end)

-- mini.diff setup (visuals & hunk actions)
local MiniDiff = require("mini.diff")
MiniDiff.setup({
	-- use signs in the gutter (minimalist approach)
	view = {
		style = "sign",
		signs = { add = "▎", change = "▎", delete = "" },
	},
})

-- hunk navigation (]h and [h)
vim.keymap.set("n", "]h", function()
	MiniDiff.goto_hunk("next")
end, { desc = "Next Hunk" })
vim.keymap.set("n", "[h", function()
	MiniDiff.goto_hunk("prev")
end, { desc = "Prev Hunk" })

-- hunk actions (stage and reset)
vim.keymap.set("n", "<leader>hs", function()
	MiniDiff.operator("apply")
end, { desc = "Stage Hunk" })
vim.keymap.set("n", "<leader>hr", function()
	MiniDiff.operator("reset")
end, { desc = "Reset Hunk" })
-- visual mode support (select lines then stage/reset)
vim.keymap.set("x", "<leader>hs", ':MiniDiff.operator("apply")<CR>', { desc = "Stage Selection" })
vim.keymap.set("x", "<leader>hr", ':MiniDiff.operator("reset")<CR>', { desc = "Reset Selection" })

-- overlay toggle (see exactly what was deleted/changed inline)
vim.keymap.set("n", "<leader>hv", MiniDiff.toggle_overlay, { desc = "Toggle Hunk View" })

-- fugitive setup
-- fugitive doesn't need a .setup() call, just mappings
vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git Status" })
vim.keymap.set("n", "<leader>gb", ":G blame<CR>", { desc = "Git Blame" })
vim.keymap.set("n", "<leader>gd", ":Gvdiffsplit<CR>", { desc = "Git Diff Split" })
-- push and pull
vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { desc = "Git Push" })
vim.keymap.set("n", "<leader>gP", ":Git pull<CR>", { desc = "Git Pull" })

-- opencode.nvim

-- Default configuration with all available options
require("opencode").setup({
	preferred_picker = "telescope",
	preferred_completion = "blink",
	default_global_keymaps = true,
	default_mode = "build",
	default_system_prompt = nil, -- Custom system prompt to use for all sessions. If nil, uses the default built-in system prompt
	keymap_prefix = "<leader>o",
	opencode_executable = "opencode",
	keymap = {
		editor = {
			["<leader>og"] = { "toggle" },
			["<leader>o/"] = { "quick_chat", mode = { "n", "x" } },
			["<leader>op"] = { "add_visual_selection", mode = { "v" } },
			["<leader>oz"] = { "toggle_zoom" },
			["<leader>ov"] = { "paste_image" },
			["<leader>od"] = { "diff_open" },
			["<leader>o]"] = { "diff_next" },
			["<leader>o["] = { "diff_prev" },
			["<leader>oc"] = { "diff_close" },
		},
	},
})
-- render-markdown for opencode
require("render-markdown").setup({
	anti_conceal = { enabled = false },
	file_types = { "markdown", "opencode_output" },
})
