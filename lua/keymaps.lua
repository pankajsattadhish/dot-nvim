vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>")
vim.keymap.set("n", "<Esc>", "<cmd>noh<CR><Esc>")

vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<CR>")
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<CR>")
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +5<CR>")
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -5<CR>")

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "<leader>w", "<cmd>write<cr>")
vim.keymap.set("n", "<leader>q", "<cmd>quit<cr>")
vim.keymap.set("n", "<leader>r", "<cmd>restart<cr>")

vim.keymap.set("n", "<leader>t", "<cmd>tabnew | FzfLua files<cr>i")

vim.keymap.set("n", "<leader>u", function()
	vim.cmd.packadd("nvim.undotree")
	require("undotree").open()
end)

for i = 1, 8 do
	vim.keymap.set("n", "<leader>" .. i, "<Cmd>tabnext " .. i .. "<CR>")
end

vim.keymap.set({ "n", "v" }, "<leader>y", function()
	local bufname = vim.api.nvim_buf_get_name(0)
	if bufname == "" then
		vim.notify("No file saved yet", vim.log.levels.WARN)
		return
	end

	local path = vim.fn.fnamemodify(bufname, ":p")
	local mode = vim.api.nvim_get_mode().mode

	if mode:match("^[vV\22]") then
		local start_line = vim.fn.line("v")
		local end_line = vim.fn.line(".")
		if start_line > end_line then
			start_line, end_line = end_line, start_line
		end
		if start_line == end_line then
			path = path .. ":" .. start_line
		else
			path = path .. ":" .. start_line .. "-" .. end_line
		end
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
	end

	vim.fn.setreg("+", path)
	vim.notify("Copied to clipboard: " .. path, vim.log.levels.INFO)
end, { desc = "Yank file path with line range for opencode" })
