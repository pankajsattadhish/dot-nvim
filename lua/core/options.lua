-- leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable built-in plugins
-- vim.g.loaded_netrw = 1 -- 1 means true, so disable it.
-- vim.g.loaded_netrwPlugin = 1

-- disable providers
-- vim.g.loaded_node_provider = 0
-- vim.g.loaded_perl_provider = 0
-- vim.g.loaded_python3_provider = 0
-- vim.g.loaded_ruby_provider = 0

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
vim.opt.lazyredraw = true

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

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10

-- How wide the number column is (4 characters wide).
vim.opt.numberwidth = 4

-- Always show a column for signs (like error marks from LSP).
vim.opt.signcolumn = "yes:1"
vim.opt.cursorlineopt = "screenline,number"
vim.opt.cursorline = true
vim.opt.colorcolumn = "80"

vim.opt.wrap = true       -- Enable line wrapping
vim.opt.linebreak = true  -- Wrap lines at convenient points
vim.opt.list = false      -- Ensure 'list' is off
vim.opt.showbreak = '↳ ' -- Shows this character at the start of wrapped lines
-- vim.opt.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- When wrapping, keep the indent (spaces) the same.
vim.opt.breakindent = true

vim.opt.showmode = false
vim.opt.showcmd = false

-- Show cursor position in the status line.
vim.opt.ruler = true

-- Use a single statusline for all windows (global statusline).
vim.opt.laststatus = 3

-- Don't show tab bar at the top (we use buffers instead).
vim.opt.showtabline = 0

-- Height of the command line at the bottom (1 line).
vim.opt.cmdheight = 1

-- Height of the popup menu (10 items max).
vim.opt.pumheight = 10

-- What to show at end of buffer (empty space instead of ~).
vim.opt.fillchars = { eob = " " }

vim.opt.winborder = "rounded"

vim.opt.hlsearch = true

-- Show matches as you type (incremental search).
vim.opt.incsearch = true

vim.opt.ignorecase = true

-- Show live preview of substitute commands in a split window.
vim.opt.inccommand = "split"

-- Use spaces instead of tabs when pressing Tab.
vim.opt.expandtab = true

-- How many spaces for each indent level (2 spaces).
vim.opt.shiftwidth = 2

-- Automatically indent new lines smartly.
vim.opt.smartindent = true

-- New horizontal splits open below current window.
vim.opt.splitbelow = true

-- New vertical splits open to the right of current window.
vim.opt.splitright = true

-- Save files in UTF-8 encoding (supports all languages).
vim.opt.fileencoding = "utf-8"

-- Create backup files before saving.
vim.opt.backup = true

-- Where to put backup files.
vim.opt.backupdir = vim.fn.stdpath("data") .. "/backup"

-- Don't keep backup while editing (faster).
-- vim.opt.writebackup = false

-- Don't use swap files (they can cause issues).
vim.opt.swapfile = false

-- How auto-completion works.

-- Options for completion menu: show menu, even with one item, don't select automatically.
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Don't hide text with conceal (like in markdown).
vim.opt.conceallevel = 0

-- Show file name in window title.
vim.opt.title = true

-- Font for GUI version (size 17).
vim.opt.guifont = "monospace:h17"

  -- Smooth scrolling when moving large distances (like Ctrl+D/U).
  vim.opt.smoothscroll = true

  -- How folded text looks (empty means use default).
  vim.opt.foldtext = ""

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
