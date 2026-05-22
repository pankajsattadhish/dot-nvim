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

require("treesitter-context").setup() -- / require("treesitter-context").setup({ max_lines = 3 })
