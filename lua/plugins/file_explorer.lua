vim.pack.add({
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/refractalize/oil-git-status.nvim" },
})

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
