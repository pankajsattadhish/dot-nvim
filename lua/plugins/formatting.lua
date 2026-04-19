vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim" },
})

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

vim.keymap.set("n", "<leader>c", function()
	require("conform").format({ async = true, timeout_ms = 8000 })
end, { desc = "Format Code" })
