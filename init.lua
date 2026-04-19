vim.g.mapleader = " "
vim.opt.mouse = "a"
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)
vim.opt.confirm = true
vim.opt.signcolumn = "yes:2"
vim.opt.laststatus = 3
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.completeopt = { "menu", "menuone", "fuzzy", "noinsert", "popup" }
vim.opt.expandtab = true

vim.diagnostic.config({
	virtual_text = true,
	underline = true,
	severity_sort = true,
	update_in_insert = false,
	float = { border = "rounded", max_width = 80 },
	jump = { float = true }, -- automatically open the diagnostic float if you jump with [d ]d
})

--------------- autocmds
local aug = vim.api.nvim_create_augroup("UserConfig", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	group = aug,
	desc = "Highlight yanked text",
	callback = function()
		vim.highlight.on_yank({ timeout = 100 })
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	group = aug,
	desc = "Restore cursor position",
	callback = function()
		if vim.o.diff then
			return
		end
		local last = vim.api.nvim_buf_get_mark(0, '"')
		local line = vim.api.nvim_buf_line_count(0)
		if last[1] > 0 and last[1] <= line then
			pcall(vim.api.nvim_win_set_cursor, 0, last)
		end
	end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "TermLeave" }, {
	group = aug,
	desc = "Reload file if changed externally",
	callback = function()
		if vim.fn.mode() ~= "c" then
			vim.cmd("checktime")
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = aug,
	desc = "Enable 'q' to close temporary/utility windows",
	pattern = { "help", "qf", "man", "lspinfo", "checkhealth", "oil", "query" },
	callback = function(ev)
		vim.bo[ev.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = ev.buf, silent = true, desc = "Close window" })
	end,
})

---------------- keymaps
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selectin down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<Esc>", "<cmd>noh<CR><Esc>", { desc = "Remove Highlight" })
vim.keymap.set("n", "<leader>w", vim.cmd.write, { desc = "Save" })
vim.keymap.set("n", "<leader>q", vim.cmd.quit, { desc = "Quit" })
vim.keymap.set("n", "<leader>r", vim.cmd.restart, { desc = "Restart" })
for i = 1, 8 do
	vim.keymap.set("n", "<leader>" .. i, "<Cmd>tabnext " .. i .. "<CR>")
end

require("plugins")
