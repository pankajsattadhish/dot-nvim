
-- Clear highlight
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { silent = true })

-- Move lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Paste without replacing register
vim.keymap.set("v", "p", '"_dp')
vim.keymap.set("v", "P", '"_dP')

-- Terminal exit
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal" })

-- File operations
vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "Explorer" })
vim.keymap.set("n", "<leader>w", vim.cmd.write, { desc = "Save" })
vim.keymap.set("n", "<leader>q", vim.cmd.quit, { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", "<cmd>q!<CR>", { desc = "Force Quit" })

-- Line navigation
vim.keymap.set({ "n", "x", "o" }, "H", "^")
vim.keymap.set({ "n", "x", "o" }, "L", "g_")

-- Buffers
vim.keymap.set("n", "<leader>bn", vim.cmd.bnext)
vim.keymap.set("n", "<leader>bp", vim.cmd.bprevious)

-- Resize windows
vim.keymap.set("n", "+", function() vim.cmd("vertical resize +5") end)
vim.keymap.set("n", "_", function() vim.cmd("vertical resize -5") end)
vim.keymap.set("n", "=", function() vim.cmd("resize +5") end)
vim.keymap.set("n", "-", function() vim.cmd("resize -5") end)

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

-- Split line
vim.keymap.set("n", "X", function()
  vim.cmd([[keeppatterns substitute/\s*\%#\s*/\r/e]])
  vim.cmd("normal! ==^")
end, { silent = true })

-- Diagnostics
vim.keymap.set("n", "<leader>ds", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>dv", function()
  vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
end)


-- from primeagen

-- vim.api.nvim_set_keymap("n", "<leader>tf", "<Plug>PlenaryTestFile", { noremap = false, silent = false })
--
-- vim.keymap.set("n", "J", "mzJ`z")
-- vim.keymap.set("n", "=ap", "ma=ap'a")
-- vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")
--
-- vim.keymap.set("n", "<leader>vwm", function()
--     require("vim-with-me").StartVimWithMe()
-- end)
-- vim.keymap.set("n", "<leader>svwm", function()
--     require("vim-with-me").StopVimWithMe()
-- end)
-- vim.keymap.set("n", "<leader>lt", function()
--     vim.cmd [[ PlenaryBustedFile % ]]
-- end)
--
-- -- greatest remap ever
-- vim.keymap.set("x", "<leader>p", [["_dP]])
--
-- -- next greatest remap ever : asbjornHaland
-- vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])
--
-- vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")
--
-- -- This is going to get me cancelled
-- vim.keymap.set("i", "<C-c>", "<Esc>")
--
-- vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- vim.keymap.set("n", "<M-h>", "<cmd>silent !tmux-sessionizer -s 0 --vsplit<CR>")
-- vim.keymap.set("n", "<M-H>", "<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>")
--
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
--
-- vim.keymap.set("n", "<leader>p", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
--
-- vim.keymap.set(
--     "n",
--     "<leader>ee",
--     "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
-- )
--
-- vim.keymap.set(
--     "n",
--     "<leader>ea",
--     "oassert.NoError(err, \"\")<Esc>F\";a"
-- )
--
-- vim.keymap.set(
--     "n",
--     "<leader>ef",
--     "oif err != nil {<CR>}<Esc>Olog.Fatalf(\"error: %s\\n\", err.Error())<Esc>jj"
-- )
--
-- vim.keymap.set(
--     "n",
--     "<leader>el",
--     "oif err != nil {<CR>}<Esc>O.logger.Error(\"error\", \"error\", err)<Esc>F.;i"
-- )
--
-- vim.keymap.set("n", "<leader>ca", function()
--     require("cellular-automaton").start_animation("make_it_rain")
-- end)
--
-- vim.keymap.set("n", "<leader><leader>", function()
--     vim.cmd("so")
-- end)
