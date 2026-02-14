-- Clear highlight
vim.keymap.set("n", "<leader>rh", ":nohlsearch<CR>")

-- Move lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Paste without replacing register
vim.keymap.set({ "v", "x" }, "p", '"_dP', { desc = "Paste (no yank)" })

-- Yanking and pasting using System Clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Smart Yank" })
vim.keymap.set({ "n", "v" }, "<leader>P", [["+P]], { desc = "Smart Paste" })

-- Terminal exit
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal" })

-- Navigate windows in terminal mode
vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>", { desc = "Navigate windows" })

-- File operations
vim.keymap.set("n", "<leader>e", "<cmd>25Lexplore<cr>", { desc = "Lexplore" })
vim.keymap.set("n", "<leader>w", vim.cmd.write, { desc = "Save" })
vim.keymap.set("n", "<leader>q", vim.cmd.quit, { desc = "Quit" })

-- Center search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "*", "*zzzv")
vim.keymap.set("n", "#", "#zzzv")
vim.keymap.set("n", "g*", "g*zz")
vim.keymap.set("n", "g#", "g#zz")

-- Scroll centering
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<leader>*", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Rename" })

-- Diagnostics
vim.keymap.set("n", "<leader>dv", function()
	local config = vim.diagnostic.config()
	vim.diagnostic.config({ virtual_text = not config.virtual_text })
end, { desc = "Diag Virt Txt" })

-- Toggle terminal
vim.keymap.set({ "n", "t" }, "<C-/>", function()
	require("snacks.terminal").toggle()
end, { desc = "Toggle Terminal" })

vim.keymap.set({ "n", "t" }, "<C-_>", function()
	require("snacks.terminal").toggle()
end, { desc = "Toggle Terminal" })
