local map = vim.keymap.set

-- Move lines
map("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

map("n", "G", "Gzz")

-- Indent
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Paste without replacing register
map({ "v", "x" }, "p", '"_dP', { desc = "Paste (no yank)" })

-- Yanking and pasting using System Clipboard
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Smart Yank" })
map({ "n", "v" }, "<leader>P", [["+P]], { desc = "Smart Paste" })

-- Terminal exit
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal" })

-- Navigate windows in terminal mode
map("t", "<C-w>", "<C-\\><C-n><C-w>", { desc = "Navigate windows" })

-- File operations
map("n", "<leader>e", "<cmd>25Lexplore<cr>", { desc = "Lexplore" })
map("n", "<leader>w", vim.cmd.write, { desc = "Save" })
map("n", "<leader>q", vim.cmd.quit, { desc = "Quit" })

-- Center search
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "*", "*zzzv")
map("n", "#", "#zzzv")
map("n", "g*", "g*zz")
map("n", "g#", "g#zz")

-- Scroll centering
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("n", "<leader>*", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Rename" })

-- Diagnostics
map("n", "<leader>dv", function()
	local config = vim.diagnostic.config()
	vim.diagnostic.config({ virtual_text = not config.virtual_text })
end, { desc = "Diag Virt Txt" })

-- references
map("n", "]r", function()
	vim.cmd("cnext")
end, { desc = "Next Reference" })

map("n", "[r", function()
	vim.cmd("cprev")
end, { desc = "Prev Reference" })

-- Terminal toggle
local term_buf = nil
local term_win = nil
local term_orientation = nil -- "horizontal" or "vertical"

local function close_terminal()
	if term_win and vim.api.nvim_win_is_valid(term_win) then
		vim.api.nvim_win_close(term_win, true)
		term_win = nil
		term_orientation = nil
	end
end

local function open_terminal_horizontal()
	close_terminal()

	local height = math.floor(vim.o.lines * 0.4)
	vim.cmd("botright split")
	vim.cmd("resize " .. height)

	term_win = vim.api.nvim_get_current_win()
	term_orientation = "horizontal"

	if not term_buf or not vim.api.nvim_buf_is_valid(term_buf) then
		term_buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_win_set_buf(term_win, term_buf)
		vim.fn.termopen(vim.o.shell)
	else
		vim.api.nvim_win_set_buf(term_win, term_buf)
	end

	vim.cmd("startinsert")

	vim.opt_local.number = false
	vim.opt_local.relativenumber = false
	vim.opt_local.signcolumn = "no"
end

local function open_terminal_vertical()
	close_terminal()

	local width = math.floor(vim.o.columns * 0.4)
	vim.cmd("botright vsplit")
	vim.cmd("vertical resize " .. width)

	term_win = vim.api.nvim_get_current_win()
	term_orientation = "vertical"

	if not term_buf or not vim.api.nvim_buf_is_valid(term_buf) then
		term_buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_win_set_buf(term_win, term_buf)
		vim.fn.termopen(vim.o.shell)
	else
		vim.api.nvim_win_set_buf(term_win, term_buf)
	end

	vim.cmd("startinsert")

	vim.opt_local.number = false
	vim.opt_local.relativenumber = false
	vim.opt_local.signcolumn = "yes"
end

local function toggle_terminal_horizontal()
	if term_orientation == "horizontal" and term_win and vim.api.nvim_win_is_valid(term_win) then
		-- Horizontal is already open, close it
		close_terminal()
	else
		-- Open horizontal (will close vertical if open)
		open_terminal_horizontal()
	end
end

local function toggle_terminal_vertical()
	if term_orientation == "vertical" and term_win and vim.api.nvim_win_is_valid(term_win) then
		-- Vertical is already open, close it
		close_terminal()
	else
		-- Open vertical (will close horizontal if open)
		open_terminal_vertical()
	end
end

-- Keymaps for terminal toggle
map({ "n", "t" }, "<C-/>", toggle_terminal_horizontal, { desc = "Toggle Horizontal Terminal" })
map({ "n", "t" }, "<C-_>", toggle_terminal_horizontal, { desc = "Toggle Horizontal Terminal" })
map({ "n", "t" }, "<C-\\>", toggle_terminal_vertical, { desc = "Toggle Vertical Terminal" })

