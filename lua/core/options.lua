-- leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable built-in plugins
vim.g.loaded_netrw = 1 -- 1 means true, so disable it.
vim.g.loaded_netrwPlugin = 1

-- disable providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- editor behavior settings

-- Allow mouse clicks in all modes (normal, insert, visual, etc.)
vim.opt.mouse = "a"

-- Use the system clipboard, so copy/paste works with other programs.
vim.opt.clipboard = "unnamedplus"

-- Save undo history even after closing the file.
-- So you can undo changes from last time you opened the file!
vim.opt.undofile = true
-- Where to save the undo files. stdpath("data") is Neovim's data folder.
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- performance optimizations

-- How often Neovim checks for things like file changes (in milliseconds).
-- Lower means faster, but uses more CPU. 250ms is a good balance.
vim.opt.updatetime = 250

-- How long to wait for key combinations (like <leader> something).
-- 500ms is enough to type quickly but not too slow.
vim.opt.timeoutlen = 500

-- How long Neovim waits to redraw the screen for complex operations.
-- 10 seconds allows big files to load without giving up.
vim.opt.redrawtime = 10000

-- Similar to timeoutlen, but for special key codes (faster response).
vim.opt.ttimeoutlen = 10

-- Don't redraw the screen while running commands/macros.
-- Makes things faster, but screen might look weird for a split second.
-- Note: Keep false to avoid issues with Noice plugin.
vim.opt.lazyredraw = false

-- When resizing windows (splits), keep the content on screen stable.
vim.opt.splitkeep = "screen"

-- Use ripgrep (rg) for searching files. It's super fast!
vim.opt.grepprg = "rg --vimgrep"

-- How to show search results: file:line:column:message
vim.opt.grepformat = "%f:%l:%c:%m"

-- Ask for confirmation before quitting with unsaved changes.
vim.opt.confirm = true

-- Automatically reload files if they change outside Neovim.
vim.opt.autoread = true

-- ui/display settings

-- Use true colors (millions of colors) instead of old 256 colors.
vim.opt.termguicolors = true

-- Show line numbers on the left side.
vim.opt.number = true

-- Show relative line numbers (how many lines away from current line).
-- Great for jumping to lines quickly!
vim.opt.relativenumber = true

-- Keep 10 lines visible above/below cursor when scrolling.
vim.opt.scrolloff = 10

-- How wide the number column is (4 characters wide).
vim.opt.numberwidth = 4

-- Always show a column for signs (like error marks from LSP).
vim.opt.signcolumn = "yes:1"

-- "screenline,number" means highlight the screen line and show numbers.
vim.opt.cursorlineopt = "screenline,number"
-- Highlight the line where the cursor is.
vim.opt.cursorline = true

-- Show a vertical line at column 80 to remind you not to write too long lines.
vim.opt.colorcolumn = "80"

-- Wrap long lines to the next line instead of hiding them.
vim.opt.wrap = true

-- When wrapping, keep the indent (spaces) the same.
vim.opt.breakindent = true

-- Don't show mode in the status line (like -- INSERT --).
vim.opt.showmode = false

-- Don't show partial commands in the status line.
vim.opt.showcmd = false

-- Show cursor position in the status line.
vim.opt.ruler = true

-- Don't show tab bar at the top (we use buffers instead).
vim.opt.showtabline = 0

-- Height of the command line at the bottom (1 line).
vim.opt.cmdheight = 1

-- Height of the popup menu (10 items max).
vim.opt.pumheight = 10

-- What to show at end of buffer (empty space instead of ~).
vim.opt.fillchars = { eob = " " }

-- Make window borders rounded (looks nicer).
vim.opt.winborder = "rounded"

-- search settings

-- Highlight all matches of your search.
vim.opt.hlsearch = true

-- Show matches as you type (incremental search).
vim.opt.incsearch = true

-- Ignore case in searches (a = A).
vim.opt.ignorecase = true

-- But if you type capital letters, be case sensitive.
vim.opt.smartcase = true

-- Show live preview of substitute commands in a split window.
vim.opt.inccommand = "split"

-- indentation settings

-- Use spaces instead of tabs when pressing Tab.
vim.opt.expandtab = true

-- How many spaces for each indent level (2 spaces).
vim.opt.shiftwidth = 2

-- Automatically indent new lines smartly.
vim.opt.smartindent = true

-- =============================================================================
-- SPLIT WINDOW SETTINGS
-- =============================================================================
-- How windows split when you open new ones.

-- New horizontal splits open below current window.
vim.opt.splitbelow = true

-- New vertical splits open to the right of current window.
vim.opt.splitright = true

-- =============================================================================
-- FILE SETTINGS
-- =============================================================================
-- How Neovim handles saving and loading files.

-- Save files in UTF-8 encoding (supports all languages).
vim.opt.fileencoding = "utf-8"

-- Create backup files before saving.
vim.opt.backup = true

-- Where to put backup files.
vim.opt.backupdir = vim.fn.stdpath("data") .. "/backup"

-- Don't keep backup while editing (faster).
vim.opt.writebackup = false

-- Don't use swap files (they can cause issues).
vim.opt.swapfile = false

-- =============================================================================
-- COMPLETION SETTINGS
-- =============================================================================
-- How auto-completion works.

-- Options for completion menu: show menu, even with one item, don't select automatically.
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Don't hide text with conceal (like in markdown).
vim.opt.conceallevel = 0

-- =============================================================================
-- OTHER SETTINGS
-- =============================================================================
-- Miscellaneous options.

-- Show file name in window title.
vim.opt.title = true

-- Font for GUI version (size 17).
vim.opt.guifont = "monospace:h17"

-- =============================================================================
-- MODERN NEOVIM FEATURES (VERSION 0.10+)
-- =============================================================================
-- New features only available in Neovim 0.10 or later.
-- We check if the version is 0.10+ before enabling them.

if vim.fn.has("nvim-0.10") == 1 then -- If Neovim version is 0.10 or higher...
  -- Smooth scrolling when moving large distances (like Ctrl+D/U).
  vim.opt.smoothscroll = true

  -- How folded text looks (empty means use default).
  vim.opt.foldtext = ""
end

-- =============================================================================
-- FILETYPE DETECTION
-- =============================================================================
-- Tell Neovim how to recognize different file types.
-- File types help plugins know how to handle files (like syntax highlighting).

vim.filetype.add({
  -- By file extension (like .env for environment files).
  extension = {
    env = "dotenv", -- .env files are dotenv type.
  },
  -- By exact filename.
  filename = {
    [".env"] = "dotenv", -- File named .env.
    ["env"] = "dotenv", -- File named env.
  },
  -- By pattern in filename (using Lua patterns).
  pattern = {
    ["[jt]sconfig.*.json"] = "jsonc", -- Files like tsconfig.json or jsconfig.json.
    ["%.env%.[%w_.-]+"] = "dotenv", -- Files like .env.local or .env.production.
  },
})
