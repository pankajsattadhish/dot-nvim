vim.pack.add({ "https://github.com/ray-x/go.nvim" })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	once = true,
	callback = function()
		require("go").setup()
	end,
})
