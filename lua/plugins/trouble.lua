vim.pack.add({
	"https://github.com/folke/trouble.nvim",
})

require("trouble").setup()

vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer diagnostics" })
vim.keymap.set("n", "<leader>xw", function()
	vim.lsp.buf.workspace_diagnostics()
	vim.cmd("Trouble diagnostics toggle")
end, { desc = "Workspace diagnostics (all files)" })

-- Auto-open Trouble for quickfix results (grep/make/cexpr), without
-- hijacking manual :copen / :lopen (location list buffers share buftype=quickfix)
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
	group = vim.api.nvim_create_augroup("TroubleQuickfix", { clear = true }),
	callback = function()
		vim.schedule(function()
			if vim.fn.len(vim.fn.getqflist()) > 0 then
				pcall(vim.cmd.cclose)
				vim.cmd([[Trouble qflist open]])
			end
		end)
	end,
})
