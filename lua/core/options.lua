-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Editor core settings
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.updatetime = 500
vim.opt.timeoutlen = 500
vim.opt.redrawtime = 10000
vim.opt.ttimeoutlen = 10
vim.opt.lazyredraw = true
vim.opt.splitkeep = "screen"

-- Search
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.inccommand = "split"

-- UI
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes:1"
vim.opt.cursorline = true
vim.opt.cursorlineopt = "screenline,number"
vim.opt.colorcolumn = "80"
vim.opt.scrolloff = 10
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showbreak = "↳ "
vim.opt.fillchars = { eob = " " }
vim.opt.pumheight = 10
vim.opt.cmdheight = 1
vim.opt.laststatus = 3

-- Lua function for diagnostics count
_G._diag = function()
  local sev = vim.diagnostic.severity
  local function c(s)
    return #vim.diagnostic.get(0, { severity = s })
  end

  local e = c(sev.ERROR)
  local w = c(sev.WARN)
  local i = c(sev.INFO)
  local h = c(sev.HINT)

  local t = {}
  if e > 0 then
    table.insert(t, " " .. e)
  end
  if w > 0 then
    table.insert(t, " " .. w)
  end
  if i > 0 then
    table.insert(t, " " .. i)
  end
  if h > 0 then
    table.insert(t, " " .. h)
  end

  return table.concat(t, " ")
end

_G._lsp = function()
  local ft = vim.bo.filetype
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    if client.config.filetypes and vim.tbl_contains(client.config.filetypes, ft) then
      return " " .. client.name
    end
  end
  return ""
end

_G._git = function()
  local d = vim.b.gitsigns_status_dict
  if not d then
    return ""
  end

  local added = d.added or 0
  local changed = d.changed or 0
  local removed = d.removed or 0

  local t = {}
  if added > 0 then
    table.insert(t, " " .. added)
  end
  if changed > 0 then
    table.insert(t, " " .. changed)
  end
  if removed > 0 then
    table.insert(t, " " .. removed)
  end

  return table.concat(t, " ")
end

vim.o.statusline = table.concat({
  " %f",
  " %m",
  " %r",
  "  ",
  " %{v:lua._diag()}",
  "  ",
  " %{v:lua._git()}",
  "  ",
  " %{v:lua._lsp()}",
  " %=",
  " Ln %l/%L",
  " Col %c",
  "  ",
  "%P",
})
vim.opt.title = true

-- Window / split behavior
vim.opt.splitbelow = true
vim.opt.splitright = true

-- File encoding
vim.opt.fileencoding = "utf-8"

-- Backup / swap
vim.opt.backup = true
vim.opt.backupdir = vim.fn.stdpath("data") .. "/backup"
vim.opt.swapfile = false

-- Completion
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Tabs/Indent (universal defaults, overridden in ftplugin/)
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true

-- Folds
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

-- Titles / fonts
vim.opt.guifont = "monospace:h17"

-- Smooth scrolling
vim.opt.smoothscroll = true

-- Filetype rules
vim.filetype.add({
  extension = { env = "dotenv" },
  filename = { [".env"] = "dotenv", ["env"] = "dotenv" },
  pattern = {
    ["[jt]sconfig.*.json"] = "jsonc",
    ["%.env%.[%w_.-]+"] = "dotenv",
  },
})
