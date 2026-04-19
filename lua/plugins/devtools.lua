vim.pack.add({
	{ src = "https://github.com/mbbill/undotree" },
	{ src = "https://github.com/ray-x/go.nvim" },
	{ src = "https://github.com/wakatime/vim-wakatime" },
})

vim.g.undotree_WindowLayout = 2
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Undo Tree" })

require("go").setup()
