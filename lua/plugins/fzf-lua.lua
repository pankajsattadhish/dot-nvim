vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/ibhagwan/fzf-lua",
})

vim.api.nvim_create_autocmd("CmdUndefined", {
	pattern = "FzfLua*",
	once = true,
	callback = function()
		require("fzf-lua").setup({
			keymap = {
				builtin = {
					["<C-d>"] = "preview-page-down",
					["<C-u>"] = "preview-page-up",
				},
			},
			winopts = { flags = "half" },
		})
	end,
})
vim.keymap.set("n", "<leader>;", "<cmd>FzfLua builtin<cr>", { desc = "FzfLua Pickers" })
vim.keymap.set("n", "<leader><BS>", "<cmd>FzfLua resume<cr>", { desc = "Last Picker" })
vim.keymap.set("n", "<leader>pf", "<cmd>FzfLua files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua oldfiles<cr>", { desc = "Find Recent/Old files" })
vim.keymap.set("n", "<C-p>", "<cmd>FzfLua files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>sp", "<cmd>FzfLua live_grep<cr>", { desc = "Find live grep" })
vim.keymap.set("n", "<leader>/", "<cmd>FzfLua live_grep<cr>", { desc = "Find live grep" })
vim.keymap.set("n", "<leader>dd", "<cmd>FzfLua diagnostics_workspace<cr>", { desc = "Diagnostics Workspace" })
vim.keymap.set("n", "<leader>m", "<cmd>FzfLua marks<cr>", { desc = "Search Marks" })
