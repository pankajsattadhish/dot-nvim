vim.pack.add({ "https://github.com/tpope/vim-fugitive" })

-- fugitive has no setup() — it adds :Git/:G commands and a filetype.
-- Use from command line:
--   :Git          status window
--   :Gvdiffsplit main   diff against main
--   :G blame       toggle blame
--   :G log         browse commit history
--   :Gread        discard changes to current file
--   :Git push     push
--   :Git fetch    fetch

vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git status" })
vim.keymap.set("n", "<leader>gd", "<cmd>Gvdiffsplit main<cr>", { desc = "Diff against main" })
