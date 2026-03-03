vim.g.mapleader = " "
vim.g.have_nerd_font = true

vim.opt.mouse = "a"
vim.opt.undofile = true
vim.opt.autoread = true
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

vim.opt.timeoutlen = 1000 -- sets wait time to 1 seconds

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

-------------------- autocmds

local aug = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = aug,
	callback = function()
		vim.highlight.on_yank({ timeout = 100 })
	end,
})

-- no comment continuation
vim.api.nvim_create_autocmd("BufEnter", {
	group = aug,
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- restore cursor position
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

-- auto-reload external changes
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "TermLeave" }, {
	group = aug,
	callback = function()
		if vim.fn.mode() ~= "c" then
			vim.cmd("checktime")
		end
	end,
})

-- quit using q
vim.api.nvim_create_autocmd("FileType", {
	group = aug,
	desc = "Enable 'q' to close temporary/utility windows",
	pattern = { "help", "qf", "man", "lspinfo", "checkhealth", "oil", "query" },
	callback = function(ev)
		vim.bo[ev.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = ev.buf, silent = true, desc = "Close window" })
	end,
})

-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	group = aug,
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

-- gf for obsidian files
local function obsidian_gf()
	local line = vim.api.nvim_get_current_line()
	local col = vim.api.nvim_win_get_cursor(0)[2] + 1 -- Lua is 1-indexed

	local _, start_pos = line:sub(1, col):find(".*%[%[")
	local end_pos = line:find("%]%]", col)

	if start_pos and end_pos then
		local note_content = line:sub(start_pos + 1, end_pos - 1)
		local note_name = note_content:gsub("%.md$", ""):gsub("#.*", "")

		note_name = vim.trim(note_name)

		local vault_path = vim.fn.expand("~/library/vaults/personal")
		local find_cmd = string.format('find "%s" -iname "%s.md" -print -quit', vault_path, note_name)
		local target_file = vim.fn.system(find_cmd):gsub("\n", "")

		if target_file ~= "" then
			vim.cmd("edit " .. vim.fn.fnameescape(target_file))
		else
			vim.ui.input({ prompt = "Note not found. Create '" .. note_name .. ".md'? (y/n): " }, function(input)
				if input and input:lower() == "y" then
					local new_file = vault_path .. "/01_Notes/" .. note_name .. ".md"
					vim.cmd("edit " .. vim.fn.fnameescape(new_file))
					vim.api.nvim_buf_set_lines(0, 0, 0, false, { "# " .. note_name, "" })
				end
			end)
		end
	else
		-- Fallback for standard files/URLs
		local ok = pcall(vim.cmd, "normal! gf")
		if not ok then
			print("No wiki-link or file under cursor")
		end
	end
end

-- Keymaps for obsidian_gf
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.keymap.set("n", "gf", obsidian_gf, { buffer = true, desc = "Follow Obsidian Link" })
	end,
})

-- load files
require("plugins")
require("lsp")
require("floaterminal")
require("scratchpad")
