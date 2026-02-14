-- Auto-Detect Indent - "tpope/vim-sleuth"
-- Commenting - 		"numToStr/Comment.nvim"
-- Formatter - "stevearc/conform.nvim"

return {
	-- Sleuth: auto-detect indent. Lightweight, essential.
	{ "tpope/vim-sleuth" },

	-- Commenting (correct for TS/JSX/TSX because of context_commentstring)
	{
		"numToStr/Comment.nvim",
		dependencies = { "joosepalviste/nvim-ts-context-commentstring" },
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},

	-- Formatter
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" }, -- Load before writing files.
		cmd = { "ConformInfo" }, -- Command to show formatter info.
		keys = {
			{ -- Manual format keybinding.
				"<leader>f",
				function()
					require("conform").format({ async = true }, function(err, did_edit)
						if not err and did_edit then
							vim.notify("Formatted", vim.log.levels.INFO) -- Success message.
						end
					end)
				end,
				mode = { "n", "v" }, -- Normal and visual modes.
				desc = "Format", -- Description for which-key.
			},
		},
		opts = {
			formatters_by_ft = {
				go = { "goimports", "gofmt" },
				lua = { "stylua" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				json = { "prettier" },
				jsonc = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				python = { "isort", "black" },
				sh = { "shfmt" },
				bash = { "shfmt" },
				rust = { "rustfmt" },
			},
			default_format_opts = {
				lsp_format = "fallback", -- Use LSP formatting if no formatter available.
			},
		},
		init = function()
			-- Set vim's formatexpr to use conform for gq formatting.
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
}
