vim.g.mapleader = " "
vim.g.have_nerd_font = true

vim.opt.mouse = "a"
vim.opt.undofile = true
vim.opt.timeoutlen = 300
vim.opt.updatetime = 300

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.inccommand = "split"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.colorcolumn = "80"
vim.opt.scrolloff = 8
vim.opt.wrap = false

vim.opt.pumheight = 10

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.laststatus = 3
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0

-- folds
vim.opt.foldlevel = 99
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = true
vim.opt.foldmethod = "expr"

vim.opt.conceallevel = 2
vim.opt.showmode = false
vim.wildmenu = true
