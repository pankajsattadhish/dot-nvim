local api = vim.api

-- Disable auto-comment continuation
api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- Highlight on yank
api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ timeout = 120 })
	end,
})

-- Restore cursor position
api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = api.nvim_buf_get_mark(0, '"')
		local lines = api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lines then
			pcall(api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Cursorline only in active window
local cursor_grp = api.nvim_create_augroup("CursorLineToggle", { clear = true })

api.nvim_create_autocmd({ "WinEnter", "InsertLeave" }, {
	group = cursor_grp,
	callback = function()
		vim.wo.cursorline = true
	end,
})

api.nvim_create_autocmd({ "WinLeave", "InsertEnter" }, {
	group = cursor_grp,
	callback = function()
		vim.wo.cursorline = false
	end,
})

-- Spell checking for writing files

api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.md", "*.txt", "*.tex" },
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.spelllang = "en"
	end,
})

-- Close temporary buffers with 'q'
local close_q = api.nvim_create_augroup("CloseWithQ", { clear = true })

api.nvim_create_autocmd("FileType", {
	group = close_q,
	pattern = {
		"help",
		"qf",
		"man",
		"lspinfo",
		"checkhealth",
		"oil",
	},
	callback = function(ev)
		vim.bo[ev.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = ev.buf, silent = true })
	end,
})

-- Equalize splits on resize
api.nvim_create_autocmd("VimResized", {
	callback = function()
		vim.cmd("wincmd =")
	end,
})

-- External file change detection
api.nvim_create_autocmd({ "FocusGained", "BufEnter", "TermLeave" }, {
	callback = function()
		if vim.fn.mode() ~= "c" then
			vim.cmd("checktime")
		end
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("ProjectRoot", { clear = true }),
	callback = function()
		local markers = { ".git", "package.json" }
		local root = vim.fs.find(markers, { upward = true })[1]
		if root then
			vim.cmd("cd " .. vim.fs.dirname(root))
		end
	end,
})
