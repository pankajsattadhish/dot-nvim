vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

require("conform").setup({
	format_after_save = {
		timeout_ms = 8000,
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "biome", "prettierd" },
		javascriptreact = { "biome", "prettierd" },
		typescript = { "biome", "prettierd" },
		typescriptreact = { "biome", "prettierd" },
		graphql = { "prettierd" },
		go = { "goimports", "gofmt" },
		json = { "biome", "prettierd" },
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
		elm = { "elm-format" },
	},
	formatters = {
		sql_formatter = {
			prepend_args = { "--language", "postgresql" },
		},
		biome = {
			condition = function(_, ctx)
				return vim.fs.root(ctx.filename, { "biome.json" }) ~= nil
			end,
		},
		prettierd = {
			condition = function(_, ctx)
				return vim.fs.root(ctx.filename, { "biome.json" }) == nil
			end,
		},
	},
})

vim.keymap.set("n", "<leader>lf", function()
	require("conform").format({ async = true, timeout_ms = 30000 })
end, { desc = "Format Code" })
