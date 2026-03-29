vim.g.mapleader = " "
vim.opt.mouse = "a"
vim.opt.undofile = true
vim.opt.swapfile = true
vim.opt.autoread = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes:1"
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.laststatus = 3
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.completeopt = { "menuone", "popup", "noinsert" }
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.filetype.plugin = true
vim.opt.filetype.indent = true
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_preview = 1
vim.g.netrw_alto = 0

-------------------- autocmds
local aug = vim.api.nvim_create_augroup("UserConfig", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	group = aug,
	callback = function()
		vim.highlight.on_yank({ timeout = 100 })
	end,
})

-- no comment continuation
vim.api.nvim_create_autocmd("BufEnter", {
	group = aug,
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
	group = aug,
	callback = function()
		if vim.o.diff then
			return
		end
		local last = vim.api.nvim_buf_get_mark(0, '"')
		local line = vim.api.nvim_buf_line_count(0)
		if last[1] > 0 and last[1] <= line then
			pcall(vim.api.nvim_win_set_cursor, 0, last)
		end
	end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "TermLeave" }, {
	group = aug,
	callback = function()
		if vim.fn.mode() ~= "c" then
			vim.cmd("checktime")
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = aug,
	desc = "Enable 'q' to close temporary/utility windows",
	pattern = { "help", "qf", "man", "lspinfo", "checkhealth", "oil", "query" },
	callback = function(ev)
		vim.bo[ev.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = ev.buf, silent = true, desc = "Close window" })
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = aug,
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		require("go.format").goimports()
	end,
	group = format_sync_grp,
})

---------------- keymaps
local function map(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

map("v", "J", ":m '>+1<CR>gv=gv", "Move selectin down")
map("v", "K", ":m '<-2<CR>gv=gv", "Move selection up")
map("v", "<", "<gv", "Indent left (keep selection)")
map("v", ">", ">gv", "Indent right (keep selection)")
map("n", "<M-j>", "<cmd>resize +2<CR>")
map("n", "<M-k>", "<cmd>resize -2<CR>")
map("n", "<M-h>", "<cmd>vertical resize +5<CR>")
map("n", "<M-l>", "<cmd>vertical resize -5<CR>")
map("n", "G", "Gzz", "Go to end and center")
map("n", "<C-d>", "<C-d>zz", "Scroll down and center")
map("n", "<C-u>", "<C-u>zz", "Scroll up and center")
map("n", "n", "nzzzv", "Next search result (centered)")
map("n", "N", "Nzzzv", "Prev search result (centered)")
map({ "n", "v" }, "<leader>y", [["+y]], "Copy to system clipboard")
map({ "n", "v" }, "<leader>p", [["+p]], "Paste from system clipboard")
map({ "v", "x" }, "p", '"_dP', "Paste without overwriting register")
map("t", "<Esc>", "<C-\\><C-n>", "Exit terminal mode")
map("t", "<C-w>", "<C-\\><C-n>", "Exit terminal mode")
map("n", "<Esc>", "<cmd>noh<CR><Esc>", "Remove Highlight")
map("n", "<leader>e", "<cmd>25Lexplore<cr>", "Toggle Netrw")
map("n", "<leader>w", vim.cmd.write, "Save file")
map("n", "<leader>q", vim.cmd.quit, "Quit Neovim")
map("n", "<leader>r", vim.cmd.restart, "Restart Neovim")
map("n", "<C-q>", vim.cmd.copen, "Open QuickFix list")
map("n", "<leader>dv", function()
	vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
end, "Toggle diagnostic virtual text")
map("n", "<leader>dt", function()
	vim.diagnostic.enable(0, not vim.diagnostic.is_enabled(0))
end, "Toggle diagnostics")
map("n", "<leader>dq", function()
	vim.diagnostic.setqflist()
end, "Toggle diagnostics")
do
	local term_buf = nil

	function _G.toggle_terminal()
		if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
			local existing_win = nil
			for _, win in ipairs(vim.api.nvim_list_wins()) do
				if vim.api.nvim_win_get_buf(win) == term_buf then
					existing_win = win
					break
				end
			end

			if existing_win then
				vim.api.nvim_win_close(existing_win, true)
			else
				vim.cmd.split()
				vim.api.nvim_win_set_buf(0, term_buf)
				vim.cmd.startinsert()
			end
		else
			vim.cmd.split()
			vim.cmd.term()
			term_buf = vim.api.nvim_get_current_buf()
			vim.keymap.set("t", "<C-\\>", "<cmd>lua _G.toggle_terminal()<CR>", { buffer = term_buf })
			vim.cmd.startinsert()
		end
	end

	map("n", "<C-\\>", "<cmd>lua _G.toggle_terminal()<CR>", "Toggle Terminal")
end

---------------------- plugins
vim.pack.add({
	{ src = "https://github.com/vague-theme/vague.nvim", name = "vague" },
	{ src = "https://github.com/rose-pine/neovim", name = "rose-pine" },
	{ src = "https://github.com/nvim-mini/mini.nvim", name = "mini" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", name = "nvim-treesitter" },
	{ src = "https://github.com/neovim/nvim-lspconfig", name = "lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim", name = "mason" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim", name = "mason-lspconfig" },
	{ src = "https://github.com/stevearc/conform.nvim", name = "conform" },
	{ src = "https://github.com/saghen/blink.cmp", name = "blink.cmp" },
	{ src = "https://github.com/rafamadriz/friendly-snippets", name = "friendly-snippets" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim", name = "telescope" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", name = "telescope-fzf-native" },
	{ src = "https://github.com/nvim-lua/plenary.nvim", name = "plenary" },
	{ src = "https://github.com/mbbill/undotree", name = "undotree" },
	{ src = "https://github.com/stevearc/oil.nvim", name = "oil" },
	{ src = "https://github.com/sudo-tee/opencode.nvim", name = "opencode.nvim" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim", name = "render-markdown" },
	{ src = "https://github.com/ray-x/go.nvim", name = "go" },

	{ src = "https://github.com/mfussenegger/nvim-lint", name = "nvim-lint" },
})

vim.cmd.packloadall() -- ensure all plugins are loaded

require("rose-pine").setup()
require("vague").setup({
	transparent = true,
})
vim.cmd("colorscheme vague")

-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
vim.api.nvim_set_hl(0, "TabLineSel", { bg = "#e0e0e0", fg = "#16161d", bold = true })
for i = 1, 8 do
	map({ "n", "t" }, "<Leader>" .. i, "<Cmd>tabnext " .. i .. "<CR>")
end

require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons() --mock devicons (for Telescope)
require("mini.surround").setup()
require("mini.pairs").setup()
require("mini.statusline").setup()

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
	auto_install = true,
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
		preview = { treesitter = true },
		color_devicons = true,
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = { preview_width = 0.60 },
			height = 100,
			width = 400,
			prompt_position = "top",
		},
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
		path_displays = { "smart" },
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

map("n", "<C-p>", function()
	require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({
		hidden = true,
		previewer = false,
		layout_config = { width = 0.5, height = 0.5 },
	}))
end, "File Search")
map("n", "<leader>ff", function()
	require("telescope.builtin").find_files({ hidden = true })
end, "Find Files")
map("n", "<leader>fs", function()
	require("telescope.builtin").live_grep()
end, "Live Grep")
map("n", "<leader>/", function()
	require("telescope.builtin").current_buffer_fuzzy_find()
end, "Buffer Grep")
map("n", "<leader>fr", function()
	require("telescope.builtin").lsp_references()
end, "References")
map("n", "<leader>fm", function()
	require("telescope.builtin").man_pages()
end, "Man Pages")
map("n", "<leader>m", function()
	require("telescope.builtin").marks()
end, "Marks")
map("n", "<leader>;", function()
	require("telescope.builtin").builtin()
end, "Telescope")

-- oil.nvim
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
	view_options = { show_hidden = true, natural_order = true },
	float = {
		max_width = 0.3,
		max_height = 0.8,
		border = "rounded",
	},
})
vim.keymap.set("n", "-", "<cmd>Oil --float<cr>", { desc = "Open Oil Float" })

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
		python = { "black" },
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

-- manual format keybinding
vim.keymap.set("n", "<leader>fc", function()
	require("conform").format({ async = true, timeout_ms = 500 })
end, { desc = "Format Code" })

-- undotree
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Undo Tree" })

-- mason (package manager for lsp/formatters/linters)
require("mason").setup({ ui = { border = "rounded" }, log_level = vim.log.levels.INFO })

-- git
-- mini.git setup
require("mini.git").setup()
map("n", "<leader>gs", "<cmd>Git status<CR>", "Git Status")
map("n", "<leader>gc", "<cmd>Git commit -v<CR>", "Git Commit")
map("n", "<leader>gl", "<cmd>Git log --oneline -20<CR>", "Git Log")
map("n", "<leader>gd", "<cmd>Git diff<CR>", "Git Diff (Full)")
map("n", "<leader>gp", "<cmd>Git push<CR>", "Git Push")
map("n", "<leader>gP", "<cmd>Git pull<CR>", "Git Pull")

-- telescope git
map("n", "<leader>gb", function()
	require("telescope.builtin").git_bcommits(require("telescope.themes").get_ivy())
end, "Git BCommits")
map("n", "<leader>gf", function()
	require("telescope.builtin").git_files()
end, "Git Files")
map("n", "<leader>gB", function()
	require("telescope.builtin").git_branches({
		layout_strategy = "horizontal",
		layout_config = { width = 0.99, height = 0.99, preview_width = 0.70 },
	})
end, "Git Branches")
map("n", "<leader>gC", function()
	require("telescope.builtin").git_commits(require("telescope.themes").get_ivy())
end, "Git Commits")
map("n", "<leader>gS", function()
	require("telescope.builtin").git_status({
		layout_strategy = "horizontal",
		layout_config = { width = 0.99, height = 0.99, preview_width = 0.70 },
	})
end, "Git Status")

-- telescope diagnostics
map("n", "<leader>dd", function()
	require("telescope.builtin").diagnostics({ layout_strategy = "vertical", sorting_strategy = "ascending" })
end, "Diagnostics")

-- mini.diff setup (visuals & hunk actions)
local MiniDiff = require("mini.diff")
MiniDiff.setup({
	view = {
		style = "sign",
		signs = { add = "▎", change = "▎", delete = "" },
	},
	source = require("mini.diff").gen_source.git(),
})

-- hunk navigation (]h and [h)
vim.keymap.set("n", "]h", function()
	MiniDiff.goto_hunk("next")
end, { desc = "Next Hunk" })
vim.keymap.set("n", "[h", function()
	MiniDiff.goto_hunk("prev")
end, { desc = "Prev Hunk" })

-- hunk actions (stage and reset)
vim.keymap.set({ "n", "x" }, "<leader>hs", function()
	MiniDiff.operator("apply")
end, { desc = "Stage Hunk" })
vim.keymap.set({ "n", "x" }, "<leader>hr", function()
	MiniDiff.operator("reset")
end, { desc = "Reset Hunk" })

-- overlay toggle (see exactly what was deleted/changed inline)
vim.keymap.set("n", "<leader>hv", MiniDiff.toggle_overlay, { desc = "Toggle Hunk View" })

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

----------------- lsp settings

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, blink = pcall(require, "blink.cmp")
if ok and blink.get_lsp_capabilities then
	capabilities = vim.tbl_deep_extend("force", capabilities, blink.get_lsp_capabilities())
end

require("mason-lspconfig").setup({
	ensure_installed = {
		"ts_ls",
		"lua_ls",
		"pyright",
		"rust_analyzer",
		"bashls",
		"html",
		"cssls",
		"jsonls",
		"yamlls",
		"clangd",
		"gopls",
		"jdtls",
	},
	automatic_installation = true,
	handlers = {
		function(server)
			vim.lsp.config(server, { capabilities = capabilities })
		end,
		["gopls"] = function()
			vim.lsp.config("gopls", {
				capabilities = capabilities,
				settings = {
					gopls = {
						hints = {
							assignVariableTypes = false,
							compositeLiteralFields = false,
							constantValues = false,
							functionTypeParameters = false,
							parameterNames = false,
							rangeVariableTypes = false,
						},
					},
				},
			})
		end,
		["lua_ls"] = function()
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
			})
		end,
		["clangd"] = function()
			vim.lsp.config("clangd", {
				capabilities = capabilities,
				cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=never" },
			})
		end,
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local buf = args.buf

		local function map(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { buffer = buf, silent = true, desc = desc })
		end

		map("K", function()
			vim.lsp.buf.hover({ border = "rounded", max_height = 30, max_width = 100 })
		end, "Hover")
		map("<C-s>", function()
			vim.lsp.buf.signature_help({ border = "rounded", max_height = 30, max_width = 100 })
		end, "Signature Help")

		vim.lsp.inlay_hint.enable(false)
	end,
})

vim.diagnostic.config({
	virtual_text = true,
	underline = true,
	severity_sort = true,
	update_in_insert = false,
	float = { border = "rounded", max_width = 80 },
})

require("go").setup()

require("lint").linters_by_ft = {
	python = { "ruff" },
	javascript = { "eslint" },
	typescript = { "eslint" },
	javascriptreact = { "eslint" },
	typescriptreact = { "eslint" },
	rust = { "clippy" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
require("scratchpad")
