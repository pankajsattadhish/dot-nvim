vim.g.mapleader = " "
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.clipboard:append("unnamedplus")
vim.opt.isfname:append("@-@")
vim.opt.confirm = true
vim.opt.signcolumn = "yes:2"
vim.opt.laststatus = 3
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.completeopt = { "menu", "menuone", "fuzzy", "noinsert", "popup", "nosort", "noselect" }
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.winborder = "rounded"
vim.opt.foldmethod = "manual"
vim.opt.viewoptions = { "cursor", "folds" }

local aug = vim.api.nvim_create_augroup("UserConfig", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	group = aug,
	desc = "Highlight yanked text",
	callback = function()
		vim.highlight.on_yank({ timeout = 100 })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = aug,
	desc = "No comment line on new line",
	callback = function(ev)
		vim.bo[ev.buf].formatoptions = vim.bo[ev.buf].formatoptions:gsub("[cro]", "")
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
