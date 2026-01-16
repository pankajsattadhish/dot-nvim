-- In visual mode move lines up/down with J/K.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Lines Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Lines Up" })

-- When lines wrap (long lines show on multiple screen lines), move by screen lines.
-- If you have a count (like 5k), move by real lines.
vim.keymap.set("n", "j", "gj", { desc = "Move Down" })
vim.keymap.set("n", "k", "gk", { desc = "Move Up" })

-- BETTER INDENTING
-- In visual mode, indent and keep selection.
vim.keymap.set("v", "<", "<gv", { desc = "Indent Left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent Right" })

-- SMART PASTE
-- Paste without replacing the clipboard (don't yank the selected text).
vim.keymap.set("v", "p", '"_dp', { desc = "Paste (no yank)" })
vim.keymap.set("v", "P", '"_dP', { desc = "Paste Before (no yank)" })

-- YANK BLOCK
-- Copy everything inside { } brackets including the brackets.
vim.keymap.set("n", "YY", "va{Vy", { desc = "Yank Block {}" })

-- QUICK EXIT INSERT MODE
-- Press jj or jk quickly to exit insert mode (instead of ESC).
vim.keymap.set("i", "jj", "<ESC>", { desc = "Exit Insert" })
vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit Insert" })

-- FILE OPERATIONS
-- Quick save and quit commands.
vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "Netrw Explorer" })
vim.keymap.set("n", "<leader>w", ":write<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", ":quit<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", ":q!<CR>", { desc = "Force Quit" })

-- LINE NAVIGATION
-- H and L to go to start/end of line (like in some other editors).
vim.keymap.set({ "n", "x", "o" }, "H", "^", { desc = "Start of Line" })
vim.keymap.set({ "n", "x", "o" }, "L", "g_", { desc = "End of Line" })

-- BUFFER NAVIGATION
-- Buffers are like open files. Switch between them.
vim.keymap.set("n", "<Right>", ":bnext<CR>", { desc = "Next Buffer", silent = true })
vim.keymap.set("n", "<Left>", ":bprevious<CR>", { desc = "Prev Buffer", silent = true })
-- vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Next Buffer", silent = true })
-- vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Prev Buffer", silent = true })

-- WINDOW RESIZING
-- Make windows (splits) bigger or smaller.
vim.keymap.set("n", "+", ":vertical resize +5<CR>", { desc = "Increase Width", silent = true })
vim.keymap.set("n", "_", ":vertical resize -5<CR>", { desc = "Decrease Width", silent = true })
vim.keymap.set("n", "=", ":resize +5<CR>", { desc = "Increase Height", silent = true })
vim.keymap.set("n", "-", ":resize -5<CR>", { desc = "Decrease Height", silent = true })

-- SEARCH CENTERING
-- When searching, keep the match in the center of the screen.
vim.keymap.set("n", "n", "nzzzv", { desc = "Next Match (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev Match (centered)" })
vim.keymap.set("n", "*", "*zzzv", { desc = "Search Word (centered)" })
vim.keymap.set("n", "#", "#zzzv", { desc = "Search Word Back (centered)" })
vim.keymap.set("n", "g*", "g*zz", { desc = "Search Partial (centered)" })
vim.keymap.set("n", "g#", "g#zz", { desc = "Search Partial Back (centered)" })

-- SCROLL CENTERING
-- When scrolling, keep the cursor line in the center.
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = " Scroll Up (centered)" })

-- SPLIT LINE
-- Press X to split the current line at the cursor (add a line break).
vim.keymap.set(
  "n",
  "X",
  ":keeppatterns substitute/\\s*\\%#\\s*/\\r/e <bar> normal! ==^<cr>",
  { desc = "Split Line", silent = true }
)

-- BUFFER CLOSING
-- Close the current buffer (file) safely.
-- Uses Snacks plugin if available, otherwise standard command.
vim.keymap.set("n", "<leader>x", function()
  if pcall(require, "snacks") then -- Try to load Snacks plugin.
    Snacks.bufdelete() -- Use Snacks to close buffer nicely.
  else
    vim.cmd("bdelete") -- Fallback to standard close.
  end
end, { desc = "Close Buffer" })

-- Select all text in the file (like Ctrl+A in other editors).
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select All" })

-- Move between windows (splits) with Ctrl+h/j/k/l.
-- Silent means no message in command line.
-- vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
-- vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
-- vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
-- vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })

-- Press Escape to stop highlighting search matches.
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear Highlight", silent = true })


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
