return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    -- ==========================================
    -- HARPOON MAPPINGS (Prefix: <leader>h)
    -- ==========================================

    -- 1. ADD: <leader>ha (Harpoon Add)
    vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon: Add File" })

    -- 2. MENU: <leader>hm (Harpoon Menu)
    -- (Keeping Ctrl+e as a backup because it's super fast)
    vim.keymap.set("n", "<leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
      { desc = "Harpoon: Menu" })
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: Menu" })

    -- 3. CYCLE: alt+n (Left/Prev) and alt+p (Right/Next)
    vim.keymap.set("n", "<M-n>", function() harpoon:list():prev() end, { desc = "Harpoon: Prev File" })
    vim.keymap.set("n", "<M-p>", function() harpoon:list():next() end, { desc = "Harpoon: Next File" })

    -- 4. DIRECT JUMP: <leader>h 1/2/3/4
    vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon: File 1" })
    vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon: File 2" })
    vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon: File 3" })
    vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon: File 4" })
  end,
}
