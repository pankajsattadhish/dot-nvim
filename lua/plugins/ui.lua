return {
	-- Colorscheme
	{
		"vague-theme/vague.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("vague").setup({
				-- optional configuration here
			})

			vim.cmd("colorscheme vague")

			vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = "#DCD7BA", bold = true })
			-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		end,
	},
	{
		"webhooked/kanso.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- Default options:
			require("kanso").setup({
				bold = true, -- enable bold fonts
				italics = true, -- enable italics
				compile = false, -- enable compiling the colorscheme
				undercurl = true, -- enable undercurls
				commentStyle = { italic = true },
				functionStyle = {},
				keywordStyle = { italic = true },
				statementStyle = {},
				typeStyle = {},
				transparent = true, -- do not set background color
				dimInactive = false, -- dim inactive window `:h hl-NormalNC`
				terminalColors = true, -- define vim.g.terminal_color_{0,17}
				colors = { -- add/modify theme and palette colors
					palette = {},
					theme = { zen = {}, pearl = {}, ink = {}, all = {} },
				},
				overrides = function(colors) -- add/modify highlights
					return {}
				end,
				background = { -- map the value of 'background' option to a theme
					dark = "zen", -- try "zen", "mist" or "pearl" !
					light = "pearl", -- try "zen", "mist" or "ink" !
				},
				foreground = "default", -- "default" or "saturated" (can also be a table like background)
				minimal = false, -- reduced color palette for a more minimal look
			})

			-- setup must be called before loading
			-- vim.cmd("colorscheme kanso")
		end,
	},

	-- Fidget: LSP progress indicator
	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		opts = { notification = { window = { winblend = 0 } } },
	},

	-- Tiny Inline Diagnostic: clean inline error/warning display
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
		config = function()
			require("tiny-inline-diagnostic").setup({
				preset = "classic",
				transparent_bg = false,
				transparent_cursorline = false,
				hi = {
					error = "DiagnosticError",
					warn = "DiagnosticWarn",
					info = "DiagnosticInfo",
					hint = "DiagnosticHint",
					arrow = "NonText",
					background = "CursorLine",
					mixing_color = "None",
				},
				options = {
					show_source = { enabled = false, if_many = false },
					use_icons_from_diagnostic = false,
					add_messages = true,
					throttle = 20,
					softwrap = 30,
					multilines = { enabled = false, always_show = false },
					enable_on_insert = false,
					enable_on_select = false,
					overflow = { mode = "wrap", padding = 0 },
					break_line = { enabled = false },
					virt_texts = { priority = 2048 },
					severity = {
						vim.diagnostic.severity.ERROR,
						vim.diagnostic.severity.WARN,
						vim.diagnostic.severity.INFO,
						vim.diagnostic.severity.HINT,
					},
					disabled_ft = {},
				},
			})

			-- Disable default virtual_text (we use tiny-inline)
			vim.diagnostic.config({ virtual_text = false })
		end,
	},
}
