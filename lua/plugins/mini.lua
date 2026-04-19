vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.nvim" },
})

require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()
require("mini.surround").setup()
require("mini.pairs").setup()
require("mini.ai").setup()
require("mini.bracketed").setup()
-- require("mini.statusline").setup()

-- mini.diff setup (visuals & hunk actions)
local MiniDiff = require("mini.diff")
MiniDiff.setup({
	view = {
		style = "sign",
		signs = { add = "▎", change = "▎", delete = "" },
	},
	source = require("mini.diff").gen_source.git(),
})

-- hunk actions (stage and reset)

vim.keymap.set({ "n", "x" }, "<leader>hs", function()
	MiniDiff.operator("apply")
end, { desc = "Stage Hunk" })
vim.keymap.set({ "n", "x" }, "<leader>hr", function()
	MiniDiff.operator("reset")
end, { desc = "Reset Hunk" })

-- overlay toggle (see exactly what was deleted/changed inline)
vim.keymap.set("n", "<leader>hv", MiniDiff.toggle_overlay, { desc = "Toggle Hunk View" })
