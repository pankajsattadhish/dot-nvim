vim.pack.add({ "https://github.com/vague-theme/vague.nvim" })

require("vague").setup({ transparent = true })

-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "TabLineSel", { bg = "#e0e0e0", fg = "#16161d", bold = true })

vim.cmd.colorscheme("vague")
