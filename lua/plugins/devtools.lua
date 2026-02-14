-- Plugins:
-- Completion  - "saghen/blink.cmp"
-- TreeSitter  - "nvim-treesitter/nvim-treesitter"
-- Snippets - "L3MON4D3/LuaSnip"
-- UndoTree - "mbbill/undotree"

return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		version = "*", -- Use latest version.
		config = function()
			require("blink.cmp").setup({
				snippets = { preset = "luasnip" },
				signature = { enabled = true },
				appearance = {
					use_nvim_cmp_as_default = true,
					nerd_font_variant = "mono",
				},
				sources = {
					default = { "lsp", "path", "buffer", "snippets" },
					providers = {
						lazydev = {
							name = "LazyDev",
							module = "lazydev.integrations.blink",
							score_offset = 100,
						},
						cmdline = {
							min_keyword_length = 2,
						},
					},
				},
				keymap = {
					["<C-space>"] = { "show", "hide", "show_documentation", "hide_documentation" }, -- Toggle completion/docs.
					["<CR>"] = { "accept", "fallback" }, -- Accept completion or normal enter.
				},
				cmdline = {
					enabled = true,
					completion = { menu = { auto_show = true } },
				},
				completion = {
					menu = {
						border = "rounded",
						scrolloff = 1,
						scrollbar = false,
						draw = {
							padding = 1,
							gap = 1,
							columns = {
								{ "kind_icon" },
								{ "label", "label_description", gap = 1 },
								{ "kind" },
								{ "source_name" },
							},
						},
					},
					documentation = {
						window = {
							border = "rounded",
							scrollbar = false,
							winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
						},
						auto_show = true,
						auto_show_delay_ms = 500,
					},
				},
			})

			-- Load snippets from VSCode format (friendly-snippets).
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		build = ":TSUpdate",
		event = "BufReadPre",
		dependencies = { {
			"nvim-treesitter/nvim-treesitter-textobjects",
			branch = "master",
		} },
		config = function()
			require("nvim-treesitter.configs").setup({
				modules = {},
				ignore_install = {},
				ensure_installed = {
					"bash",
					"c",
					"html",
					"javascript",
					"json",
					"lua",
					"markdown",
					"markdown_inline",
					"python",
					"rust",
					"typescript",
					"vim",
					"vimdoc",
					"yaml",
				},
				sync_install = false,
				auto_install = true,
				highlight = { enable = true, additional_vim_regex_highlighting = false },
				indent = { enable = true },
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["ai"] = "@conditional.outer",
							["ii"] = "@conditional.inner",
							["al"] = "@loop.outer",
							["il"] = "@loop.inner",
							["iB"] = "@block.inner",
							["aB"] = "@block.outer",
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = "@class.outer",
							["]a"] = "@parameter.inner",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
							["[a"] = "@parameter.inner",
						},
					},
				},
			})
		end,
	},

	-- LuaSnip
	{ "L3MON4D3/LuaSnip", keys = {} }, -- No default keys, blink.cmp handles them.

	-- UndoTree
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>uu", "<cmd>UndotreeToggle<CR>", desc = "Undo Tree" },
		},
	},
}
