vim.g.mapleader = " "
vim.g.have_nerd_font = true

vim.opt.mouse = "a"
vim.opt.undofile = true
vim.opt.timeoutlen = 300
vim.opt.updatetime = 300

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"

vim.opt.showmatch = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.colorcolumn = "80"
vim.opt.scrolloff = 8
vim.opt.wrap = false

vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.winblend = 0

vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.laststatus = 3
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0

vim.opt.linebreak = true

vim.opt.termguicolors = true

vim.opt.timeoutlen = 1000 -- Sets wait time to 1 seconds

if vim.fn.executable("rg") == 1 then
	vim.opt.grepprg = "rg --vimgrep --smart-case"
	vim.opt.grepformat = "%f:%l:%c:%m"
end

------- keymaps

local function map(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

-- remove highlighting
map("n", "<Esc>", "<cmd>noh<CR><Esc>", "Remove Highlight")

-- similar to vscode's alt+arrow
map("v", "J", ":m '>+1<CR>gv=gv", "Move selectin down")
map("v", "K", ":m '<-2<CR>gv=gv", "Move selection up")

-- keeps it centered
map("n", "G", "Gzz", "Go to end and center")
map("n", "<C-d>", "<C-d>zz", "Scroll down and center")
map("n", "<C-u>", "<C-u>zz", "Scroll up and center")
map("n", "n", "nzzzv", "Next search result (centered)")
map("n", "N", "Nzzzv", "Prev search result (centered)")

-- keep selection after indenting
map("v", "<", "<gv", "Indent left (keep selection)")
map("v", ">", ">gv", "Indent right (keep selection)")

-- smart yank and paste
map({ "n", "v" }, "<leader>y", [["+y]], "Copy to system clipboard")
map({ "n", "v" }, "<leader>p", [["+p]], "Paste from system clipboard")
map({ "v", "x" }, "p", '"_dP', "Paste without overwriting register")

-- terminal esc
map("t", "<Esc><Esc>", "<C-\\><C-n>", "Exit terminal mode")
map("t", "<C-w>", "<C-\\><C-n><C-w>", "Terminal window navigation")

-- just for convenience
map("n", "<leader>e", "<cmd>25Lexplore<cr>", "Toggle Netrw")
map("n", "<leader>w", vim.cmd.write, "Save file")
map("n", "<leader>q", vim.cmd.quit, "Quit Neovim")
map("n", "<leader>r", vim.cmd.restart, "Restart Neovim")

-- diagnostics toggles
map("n", "<leader>dv", function()
	local current = vim.diagnostic.config().virtual_text
	vim.diagnostic.config({ virtual_text = not current })
end, "Toggle diagnostic virtual text")

map("n", "<leader>dt", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, "Toggle diagnostics")

-------------------- Autocmds

local aug = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = aug,
	callback = function()
		vim.highlight.on_yank({ timeout = 100 })
	end,
})

-- No comment continuation
vim.api.nvim_create_autocmd("BufEnter", {
	group = aug,
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- Restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
	group = aug,
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

-- Auto-reload external changes
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "TermLeave" }, {
	group = aug,
	callback = function()
		if vim.fn.mode() ~= "c" then
			vim.cmd("checktime")
		end
	end,
})

-- Quit using q
vim.api.nvim_create_autocmd("FileType", {
	group = aug,
	desc = "Enable 'q' to close temporary/utility windows",
	pattern = { "help", "qf", "man", "lspinfo", "checkhealth", "oil", "query" },
	callback = function(ev)
		vim.bo[ev.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = ev.buf, silent = true, desc = "Close window" })
	end,
})

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	group = aug,
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

-- Load files
require("plugins")
require("lsp")
