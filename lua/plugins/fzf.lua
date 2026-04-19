vim.pack.add({ { src = "https://github.com/ibhagwan/fzf-lua" } })

-- FzfLua Setup
require("fzf-lua").setup({
	keymap = {
		builtin = {
			["<C-d>"] = "preview-page-down",
			["<C-u>"] = "preview-page-up",
		},
	},
})

vim.keymap.set("n", "<leader>;", "<cmd>FzfLua builtin<cr>", { desc = "FzfLua Pickers" })
vim.keymap.set("n", "<leader>f", "<cmd>FzfLua files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<C-p>", function()
	require("fzf-lua").files({
		profile = "fzf-vim",
		fzf_opts = { ["--border"] = "none" },
		winopts = { border = false },
	})
end, { desc = "Find files" })
vim.keymap.set("n", "<leader>s", "<cmd>FzfLua live_grep<cr>", { desc = "Find live grep" })
