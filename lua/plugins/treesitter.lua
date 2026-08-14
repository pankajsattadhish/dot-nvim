vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

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
		"go",
		"markdown",
		"org",
		"python",
		"rust",
		"typescript",
		"vim",
		"yaml",
	},
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
	},
	indent = { enable = true },
})
