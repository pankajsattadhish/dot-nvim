local api = vim.api

-- Disable auto-comment continuation
api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

-- Highlight on yank
api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Remember cursor position
api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lines = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lines then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Cursorline only in active window
local group = api.nvim_create_augroup("CursorLine", { clear = true })
api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  command = "set cursorline",
  group = group,
})
api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  command = "set nocursorline",
  group = group,
})

-- Spell checking for text/markdown/tex
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.txt", "*.md", "*.tex" },
  callback = function()
    vim.opt.spell = true
    vim.opt.spelllang = "en"
  end,
})

-- Close special buffers with q
api.nvim_create_autocmd("FileType", {
  group = api.nvim_create_augroup("close_with_q", { clear = true }),
  pattern = {
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
  callback = function(ev)
    vim.bo[ev.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = ev.buf, silent = true })
  end,
})

-- Resize splits automatically
api.nvim_create_autocmd("VimResized", {
  callback = function()
    vim.cmd("wincmd =")
  end,
})

-- Fix commentstring for terraform/hcl
api.nvim_create_autocmd("FileType", {
  group = api.nvim_create_augroup("FixTerraformCommentString", { clear = true }),
  pattern = { "terraform", "hcl" },
  callback = function(ev)
    vim.bo[ev.buf].commentstring = "# %s"
  end,
})

-- External file change detection
api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})

-- Soft word wrapping for mail files
api.nvim_create_autocmd("Filetype", {
  pattern = "mail",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.textwidth = 0
    vim.opt_local.wrapmargin = 0
    vim.opt_local.colorcolumn = "80"
  end,
})

-- Auto-persist per project
vim.api.nvim_create_autocmd("User", {
  pattern = "PersistenceLoadPost",
  callback = function()
    pcall(function()
      require("harpoon"):load()
    end)
  end,
})
