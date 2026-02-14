local map = vim.keymap.set

-- Move lines
map("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

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

-- Toggles

-- toggle wrap
map("n", "<leader>tw", function()
	vim.opt.wrap = not vim.opt.wrap:get()
end, { desc = "Toggle wrap" })

-- toggle diagnostic
map("n", "<leader>td", function()
	if vim.diagnostic.is_enabled() then
		vim.diagnostic.enable(false)
	else
		vim.diagnostic.enable()
	end
end, { desc = "Toggle diagnostics" })

-- toggle indent lines
local ibl_enabled = true
map("n", "<leader>ti", function()
	ibl_enabled = not ibl_enabled
	if ibl_enabled then
		require("ibl").setup()
	else
		vim.cmd("IBLDisable")
	end
end, { desc = "Toggle indent lines" })

-- toggle inlay hints
map("n", "<leader>th", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints" })

-- toggle spell
map("n", "<leader>ts", function()
	vim.opt.spell = not vim.opt.spell:get()
end, { desc = "Toggle spell" })

-- references
map({ "n", "t" }, "]r", function()
	vim.cmd("cnext")
end, { desc = "Next Reference" })

map({ "n", "t" }, "[r", function()
	vim.cmd("cprev")
end, { desc = "Prev Reference" })


