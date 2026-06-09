local _99 = require("99")
local cwd = vim.uv.cwd()
local basename = vim.fs.basename(cwd)
_99.setup({
	-- provider = _99.Providers.ClaudeCodeProvider,  -- default: OpenCodeProvider
	logger = {
		level = _99.DEBUG,
		path = "/tmp/" .. basename .. ".99.debug",
		print_on_error = true,
	},
	model = "opencode/deepseek-v4-flash-free",
	provider_extra_args = { "--dangerously-skip-permissions" },
	tmp_dir = "/tmp",

	--- Completions: #rules and @files in the prompt buffer
	completion = {
		-- I am going to disable these until i understand the
		-- problem better.  Inside of cursor rules there is also
		-- application rules, which means i need to apply these
		-- differently
		-- cursor_rules = "<custom path to cursor rules>"

		--- A list of folders where you have your own SKILL.md
		--- Expected format:
		--- /path/to/dir/<skill_name>/SKILL.md
		---
		--- Example:
		--- Input Path:
		--- "scratch/custom_rules/"
		---
		--- Output Rules:
		--- {path = "scratch/custom_rules/vim/SKILL.md", name = "vim"},
		--- ... the other rules in that dir ...
		---
		-- custom_rules = {
		-- 	"scratch/custom_rules/",
		-- },

		--- Configure @file completion (all fields optional, sensible defaults)
		files = {
			-- enabled = true,
			-- max_file_size = 102400,     -- bytes, skip files larger than this
			-- max_files = 5000,            -- cap on total discovered files
			-- exclude = { ".env", ".env.*", "node_modules", ".git", ... },
		},
		source = "blink", -- "native" (default), "cmp", or "blink"
	},

	md_files = {
		"AGENT.md",
	},
})

vim.keymap.set("n", "<leader>9s", function()
	_99.search()
end, { desc = "Search with 99" })
vim.keymap.set("v", "<leader>9v", function()
	_99.visual()
end, { desc = "Visual selection with 99" })
vim.keymap.set("n", "<leader>9x", function()
	_99.stop_all_requests()
end, { desc = "Stop all 99 requests" })
vim.keymap.set("n", "<leader>9i", function()
	_99.info()
end, { desc = "Show 99 info" })
vim.keymap.set("n", "<leader>9l", function()
	_99.view_logs()
end, { desc = "View 99 logs" })
vim.keymap.set("n", "<leader>9o", function()
	_99.open()
end, { desc = "Open 99" })
vim.keymap.set("n", "<leader>9c", function()
	_99.clear_previous_requests()
end, { desc = "Clear 99 request history" })
