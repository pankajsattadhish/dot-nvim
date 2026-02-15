return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-ui-select.nvim",
			"aznhe21/actions-preview.nvim",
		},

		cmd = "Telescope",

		keys = {
			{
				"<C-p>",
				function()
					local builtin = require("telescope.builtin")
					local themes = require("telescope.themes")

					local opts = themes.get_dropdown({
						previewer = false,
						layout_config = { width = 0.5, height = 0.5 },
					})

					local ok = pcall(
						builtin.git_files,
						vim.tbl_extend("force", opts, {
							show_untracked = true,
						})
					)

					if not ok then
						builtin.find_files(vim.tbl_extend("force", opts, { hidden = true }))
					end
				end,
				desc = "Fast File Switch",
			},
			{
				"<leader>pf",
				function()
					local builtin = require("telescope.builtin")
					local ok = pcall(builtin.git_files, { show_untracked = true })
					if not ok then
						builtin.find_files({ hidden = true })
					end
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
				"<leader>pr",
				function()
					require("telescope.builtin").lsp_references()
				end,
				desc = "References",
			},
			{
				"<leader>dd",
				function()
					require("telescope.builtin").diagnostics({
						layout_strategy = "vertical",
						layout_config = {
							width = 0.6,
							height = 0.6,
							preview_height = 0.4,
						},
						sorting_strategy = "ascending",
					})
				end,
				desc = "Diagnostics",
			},

			------------------------------------------------------------------
			-- CODE ACTIONS
			------------------------------------------------------------------
			{
				"<leader>ca",
				function()
					require("actions-preview").code_actions()
				end,
				desc = "Code Actions",
			},
		},

		config = function()
			local telescope = require("telescope")

			telescope.setup({
				defaults = {
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",

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

					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden",
						"--glob=!node_modules/*",
						"--glob=!.git/*",
						"--glob=!dist/*",
						"--glob=!build/*",
						"--glob=!.next/*",
					},
				},

				pickers = {
					find_files = {
						hidden = true,
						find_command = {
							"rg",
							"--files",
							"--hidden",
							"--glob=!node_modules/*",
							"--glob=!.git/*",
							"--glob=!dist/*",
							"--glob=!build/*",
							"--glob=!.next/*",
						},
					},
				},

				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})

			telescope.load_extension("fzf")
			telescope.load_extension("ui-select")

			require("actions-preview").setup({
				backend = { "telescope" },
			})

			------------------------------------------------------------------
			-- PROJECT ROOT (SET ONCE)
			------------------------------------------------------------------
			local markers = { ".git", "package.json" }
			local root = vim.fs.find(markers, { upward = true })[1]
			if root then
				vim.cmd("cd " .. vim.fs.dirname(root))
			end
		end,
	},
}
