vim.pack.add({
	{ src = "https://github.com/sudo-tee/opencode.nvim" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
})

-- opencode.nvim
require("opencode").setup({
	preferred_picker = "fzf",
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
