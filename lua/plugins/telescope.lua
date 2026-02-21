return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-ui-select.nvim",
			"echasnovski/mini.icons",
		},

		cmd = "Telescope",

		keys = {
			{
				"<C-p>",
				function()
					local builtin = require("telescope.builtin")
					local themes = require("telescope.themes")

					builtin.find_files(themes.get_dropdown({
						hidden = true,
						previewer = false,
						layout_config = {
							width = 0.5,
							height = 0.5,
						},
					}))
				end,
				desc = "File Search",
			},
			{
				"<leader>pf",
				function()
					require("telescope.builtin").find_files({ hidden = true })
				end,
				desc = "Project Files",
			},
			{
				"<leader>ps",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "Live Grep",
			},
			{
				"<leader>/",
				function()
					require("telescope.builtin").current_buffer_fuzzy_find()
				end,
				desc = "Buffer Live Grep",
			},
			{
				"<leader>pb",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>pr",
				function()
					require("telescope.builtin").lsp_references()
				end,
				desc = "References",
			},
			{
				"<leader>pm",
				function()
					require("telescope.builtin").man_pages()
				end,
				desc = "Man Pages",
			},
			{
				"<leader>pt",
				function()
					require("telescope.builtin").builtin()
				end,
				desc = "Telescope Builtin",
			},
			{
				"<leader>gb",
				function()
					require("telescope.builtin").git_bcommits((require("telescope.themes").get_ivy()))
				end,
				desc = "Git BCommits",
			},
			{
				"<leader>gf",
				function()
					require("telescope.builtin").git_files()
				end,
				desc = "Git Files",
			},
			{
				"<leader>gB",
				function()
					require("telescope.builtin").git_branches({
						layout_strategy = "horizontal",
						layout_config = {
							width = 0.99, -- full editor width
							height = 0.99, -- almost full height (adjust if needed)
							preview_width = 0.70,
						},
					})
				end,
				desc = "Git Branches",
			},
			{
				"<leader>gC",
				function()
					require("telescope.builtin").git_commits(require("telescope.themes").get_ivy())
				end,
				desc = "Git Commits",
			},
			{
				"<leader>gs",
				function()
					require("telescope.builtin").git_status({
						layout_strategy = "horizontal",
						layout_config = {
							width = 0.99, -- full editor width
							height = 0.99, -- almost full height (adjust if needed)
							preview_width = 0.70,
						},
					})
				end,
				desc = "Git Status Picker (Full Width)",
			},
			{
				"<leader>dd",
				function()
					require("telescope.builtin").diagnostics({
						layout_strategy = "vertical",
						sorting_strategy = "ascending",
					})
				end,
				desc = "Diagnostics",
			},
		},

		config = function()
			local telescope = require("telescope")

			local ignore_globs = {
				"--glob=!node_modules/*",
				"--glob=!.git/*",
				"--glob=!dist/*",
				"--glob=!build/*",
				"--glob=!.next/*",
			}

			telescope.setup({
				defaults = {
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",

					layout_config = {
						horizontal = {
							preview_width = 0.60,
						},
					},

					-- MERN repo optimization
					file_ignore_patterns = {
						"node_modules",
						".git/",
						"dist/",
						"build/",
						".next/",
						"coverage/",
						"%.lock",
						"package%-lock.json",
						"yarn.lock",
					},

					vimgrep_arguments = vim.tbl_flatten({
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden",
						ignore_globs,
					}),
				},

				pickers = {
					find_files = {
						hidden = true,
						find_command = vim.tbl_flatten({
							"rg",
							"--files",
							"--hidden",
							ignore_globs,
						}),
					},
				},

				extensions = {
					fzf = {},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})

			telescope.load_extension("fzf")
			telescope.load_extension("ui-select")
		end,
	},
}
