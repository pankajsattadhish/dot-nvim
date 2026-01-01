-- =============================================================================
-- KEYMAPS CONFIGURATION
-- =============================================================================
-- This file sets up custom keyboard shortcuts for Neovim.
-- Keymaps make it easier and faster to do common tasks.
-- Each keymap uses vim.keymap.set(mode, keys, action, options).
-- Mode: "n" normal, "v" visual, "i" insert, etc.
-- Keys: what you press, action: what happens, options: like description.

-- =============================================================================
-- VISUAL MODE LINE MOVEMENT
-- =============================================================================
-- In visual mode (when you select text), move lines up/down with J/K.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Lines Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Lines Up" })

-- =============================================================================
-- WRAPPED LINE NAVIGATION
-- =============================================================================
-- When lines wrap (long lines show on multiple screen lines), move by screen lines.
-- If you have a count (like 5k), move by real lines.
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Up (wrapped)" })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Down (wrapped)" })

-- =============================================================================
-- BETTER INDENTING
-- =============================================================================
-- In visual mode, indent and keep selection.
vim.keymap.set("v", "<", "<gv", { desc = "Indent Left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent Right" })

-- =============================================================================
-- SMART PASTE
-- =============================================================================
-- Paste without replacing the clipboard (don't yank the selected text).
vim.keymap.set("v", "p", '"_dp', { desc = "Paste (no yank)" })
vim.keymap.set("v", "P", '"_dP', { desc = "Paste Before (no yank)" })

-- =============================================================================
-- YANK BLOCK
-- =============================================================================
-- Copy everything inside { } brackets including the brackets.
vim.keymap.set("n", "YY", "va{Vy", { desc = "Yank Block {}" })

-- =============================================================================
-- QUICK EXIT INSERT MODE
-- =============================================================================
-- Press jj or jk quickly to exit insert mode (instead of ESC).
vim.keymap.set("i", "jj", "<ESC>", { desc = "Exit Insert" })
vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit Insert" })

-- =============================================================================
-- FILE OPERATIONS
-- =============================================================================
-- Quick save and quit commands.
vim.keymap.set("n", "<leader>w", ":write<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", ":quit<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", ":q!<CR>", { desc = "Force Quit" })

-- =============================================================================
-- LINE NAVIGATION
-- =============================================================================
-- H and L to go to start/end of line (like in some other editors).
vim.keymap.set({ "n", "x", "o" }, "H", "^", { desc = "Start of Line" })
vim.keymap.set({ "n", "x", "o" }, "L", "g_", { desc = "End of Line" })

-- =============================================================================
-- BUFFER NAVIGATION
-- =============================================================================
-- Buffers are like open files. Switch between them.
vim.keymap.set("n", "<Right>", ":bnext<CR>", { desc = "Next Buffer", silent = true })
vim.keymap.set("n", "<Left>", ":bprevious<CR>", { desc = "Prev Buffer", silent = true })
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Next Buffer", silent = true  })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Prev Buffer", silent = true  })

-- =============================================================================
-- BUFFER CLOSING
-- =============================================================================
-- Close the current buffer (file) safely.
-- Uses Snacks plugin if available, otherwise standard command.
vim.keymap.set("n", "<leader>x", function()
  if pcall(require, "snacks") then  -- Try to load Snacks plugin.
    Snacks.bufdelete()  -- Use Snacks to close buffer nicely.
  else
    vim.cmd("bdelete")  -- Fallback to standard close.
  end
end, { desc = "Close Buffer" })

-- =============================================================================
-- WINDOW RESIZING
-- =============================================================================
-- Make windows (splits) bigger or smaller.
vim.keymap.set("n", "+", ":vertical resize +5<CR>", { desc = "Increase Width", silent = true })
vim.keymap.set("n", "_", ":vertical resize -5<CR>", { desc = "Decrease Width", silent = true })
vim.keymap.set("n", "=", ":resize +5<CR>", { desc = "Increase Height", silent = true })
vim.keymap.set("n", "-", ":resize -5<CR>", { desc = "Decrease Height", silent = true })

-- =============================================================================
-- SEARCH CENTERING
-- =============================================================================
-- When searching, keep the match in the center of the screen.
vim.keymap.set("n", "n", "nzzzv", { desc = "Next Match (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev Match (centered)" })
vim.keymap.set("n", "*", "*zzzv", { desc = "Search Word (centered)" })
vim.keymap.set("n", "#", "#zzzv", { desc = "Search Word Back (centered)" })
vim.keymap.set("n", "g*", "g*zz", { desc = "Search Partial (centered)" })
vim.keymap.set("n", "g#", "g#zz", { desc = "Search Partial Back (centered)" })

-- =============================================================================
-- SCROLL CENTERING
-- =============================================================================
-- When scrolling, keep the cursor line in the center.
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = " Scroll Up (centered)" })

-- =============================================================================
-- SPLIT LINE
-- =============================================================================
-- Press X to split the current line at the cursor (add a line break).
vim.keymap.set(
  "n",
  "X",
  ":keeppatterns substitute/\\s*\\%#\\s*/\\r/e <bar> normal! ==^<cr>",
  { desc = "Split Line", silent = true }
)

-- =============================================================================
-- SELECT ALL
-- =============================================================================
-- Select all text in the file (like Ctrl+A in other editors).
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select All" })

-- =============================================================================
-- WINDOW NAVIGATION
-- =============================================================================
-- Move between windows (splits) with Ctrl+h/j/k/l.
-- Silent means no message in command line.
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })

-- =============================================================================
-- CLEAR SEARCH HIGHLIGHT
-- =============================================================================
-- Press Escape to stop highlighting search matches.
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear Highlight", silent = true })
