vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
})

require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()
require("mini.surround").setup()
require("mini.pairs").setup()
require("mini.ai").setup()
require("mini.bracketed").setup()
require("mini.statusline").setup()

require("mini.diff").setup({
	view = {
		style = "sign",
		signs = { add = "▎", change = "▎", delete = "" },
	},
	source = require("mini.diff").gen_source.git({ index = false }),
})
vim.keymap.set({ "n", "x" }, "<leader>hs", function()
	require("mini.diff").operator("apply")
end, { desc = "Stage Hunk" })
vim.keymap.set({ "n", "x" }, "<leader>hr", function()
	require("mini.diff").operator("reset")
end, { desc = "Reset Hunk" })
vim.keymap.set("n", "<leader>hv", function()
	require("mini.diff").toggle_overlay()
end, { desc = "Toggle Hunk View" })
