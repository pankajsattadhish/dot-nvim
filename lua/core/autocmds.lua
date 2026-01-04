local api = vim.api -- Short name for vim.api, which is Neovim's API.

-- disable auto-commenting new lines
api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

-- soft word wrapping for mail files
api.nvim_create_autocmd("Filetype", {
  pattern = "mail", -- Only for files with filetype "mail".
  callback = function()
    vim.opt.textwidth = 0 -- No automatic line breaking.
    vim.opt.wrapmargin = 0 -- No margin for wrapping.
    vim.opt.wrap = true -- Wrap long lines.
    vim.opt.linebreak = true -- Break at word boundaries.
    vim.opt.columns = 80 -- Window width 80 characters.
    vim.opt.colorcolumn = "80" -- Show line at column 80.
  end,
})

-- highlight on yank
api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank() -- Highlight the yanked text for a moment.
  end,
})

-- remember cursor position
api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"') -- Get the saved cursor position.
    local lcount = vim.api.nvim_buf_line_count(0) -- Total lines in file.
    if mark[1] > 0 and mark[1] <= lcount then -- If position is valid...
      pcall(vim.api.nvim_win_set_cursor, 0, mark) -- Go to that position.
    end
  end,
})

-- cursor line only in active window
local cursorGrp = api.nvim_create_augroup("CursorLine", { clear = true }) -- Group for these autocmds.
api.nvim_create_autocmd(
  { "InsertLeave", "WinEnter" },
  { -- When leaving insert or entering window...
    pattern = "*", -- For all files.
    command = "set cursorline", -- Turn on cursor line.
    group = cursorGrp, -- Put in the group.
  }
)
api.nvim_create_autocmd(
  { "InsertEnter", "WinLeave" }, -- When entering insert or leaving window...
  { pattern = "*", command = "set nocursorline", group = cursorGrp } -- Turn off cursor line.
)

-- enable spell checking
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { -- When reading or creating files...
  pattern = { "*.txt", "*.md", "*.tex" }, -- For these file types.
  callback = function()
    vim.opt.spell = true -- Turn on spell check.
    vim.opt.spelllang = "en" -- Use English dictionary.
  end,
})

-- close special buffers with q
api.nvim_create_autocmd("FileType", {
  group = api.nvim_create_augroup("close_with_q", { clear = true }), -- New group.
  pattern = { -- List of filetypes that get the 'q' keymap.
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false -- Don't list this buffer.
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true }) -- Add 'q' to close.
  end,
})

-- resize splits on terminal resize
api.nvim_create_autocmd("VimResized", {
  callback = function()
    vim.cmd("wincmd =") -- Equalize window sizes.
  end,
})

-- fix comment string for terraform/hcl
-- Terraform and HCL files use # for comments, not // or --.
-- This sets the correct comment format for those files.
api.nvim_create_autocmd("FileType", {
  group = api.nvim_create_augroup("FixTerraformCommentString", { clear = true }), -- Group for this.
  pattern = { "terraform", "hcl" }, -- For these file types.
  callback = function(ev)
    vim.bo[ev.buf].commentstring = "# %s" -- Use # for comments.
  end,
})

-- check for external file changes
-- When Neovim gets focus or you enter a buffer, check if the file changed outside.
-- Helps sync with other editors or tools.
api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, { -- On focus or buffer enter...
  callback = function()
    if vim.fn.mode() ~= "c" then -- If not in command mode...
      vim.cmd("checktime") -- Check for changes.
    end
  end,
})

-- open help in vertical split
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  command = "wincmd L",
})


