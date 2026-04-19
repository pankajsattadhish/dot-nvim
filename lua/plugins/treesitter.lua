vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

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
