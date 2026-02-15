return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },

	config = function()
		local lint = require("lint")

		-- configure linters
		lint.linters_by_ft = {
			go = { "golangcilint" },
			python = { "ruff" },
			lua = { "luacheck" },
			rust = { "clippy" },
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			sh = { "shellcheck" },
			bash = { "shellcheck" },
			zsh = { "shellcheck" },
		}

		-- ESLint via stdin
		if lint.linters.eslint_d then
			lint.linters.eslint_d.args = {
				"--format",
				"json",
				"--stdin",
				"--stdin-filename",
				function()
					return vim.api.nvim_buf_get_name(0)
				end,
			}
		end

		-- Run lint on save
		vim.api.nvim_create_autocmd("BufWritePost", {
			callback = function()
				lint.try_lint()
			end,
		})

		-- Manual lint keymap
		vim.keymap.set("n", "<leader>cl", function()
			lint.try_lint()
		end, { desc = "Run Lint" })
	end,
}
