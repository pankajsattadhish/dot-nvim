vim.pack.add({ "https://github.com/MeanderingProgrammer/render-markdown.nvim" })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	once = true,
	callback = function()
		require("render-markdown").setup({ anti_conceal = { enabled = false }, file_types = { "markdown" } })
	end,
})
