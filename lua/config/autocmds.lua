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

local is_file_buf = function(bufnr)
	return vim.bo[bufnr].buftype == "" and vim.fn.bufname(bufnr) ~= ""
end

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = aug,
	desc = "Restore persisted folds and cursor",
	callback = function(ev)
		if is_file_buf(ev.buf) then
			pcall(vim.cmd.loadview)
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufWinLeave", "VimLeavePre" }, {
	group = aug,
	desc = "Persist folds and cursor",
	callback = function(ev)
		local bufnr = ev.event == "VimLeavePre" and vim.api.nvim_get_current_buf() or ev.buf
		if is_file_buf(bufnr) then
			pcall(vim.cmd.mkview)
		end
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

vim.api.nvim_create_autocmd("BufEnter", {
	group = aug,
	desc = "Set CWD to project root",
	callback = function()
		local root = vim.fs.root(0, { ".git", "Makefile", "package.json", "Cargo.toml", "go.mod" })
		if root then
			vim.fn.chdir(root)
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
	pattern = { "help", "qf", "man", "lspinfo", "checkhealth", "query" },
	callback = function(ev)
		vim.bo[ev.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = ev.buf, silent = true, desc = "Close window" })
	end,
})

