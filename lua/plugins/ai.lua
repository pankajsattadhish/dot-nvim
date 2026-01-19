return {
  -- 1. CODEIUM (Ghost Text - Free & Unlimited)
   {
     "Exafunction/codeium.vim",
     -- Only load when manually triggered to save resources
     cmd = "Codeium",
     config = function()
       -- Disable default bindings to avoid conflicts
       vim.g.codeium_disable_bindings = 1
       -- Disable by default for performance
       vim.g.codeium_enabled = 1

       -- Keymap to toggle Codeium on/off
       vim.keymap.set("n", "<leader>ct", function()
         if vim.g.codeium_enabled == 0 then
           vim.g.codeium_enabled = 1
           print("Codeium Enabled")
         else
           vim.g.codeium_enabled = 0
           print("Codeium Disabled")
         end
       end, { noremap = true, silent = true, desc = "Toggle Codeium" })

       -- Accept suggestion (only works when Codeium is enabled)
       vim.keymap.set("i", "<C-g>", function()
         return vim.fn["codeium#Accept"]()
       end, { expr = true, silent = true, desc = "Accept Codeium Suggestion" })

       -- Cycle through suggestions
       vim.keymap.set("i", "<M-]>", function()
         return vim.fn["codeium#CycleCompletions"](1)
       end, { expr = true, silent = true, desc = "Next Codeium Suggestion" })

       vim.keymap.set("i", "<M-[>", function()
         return vim.fn["codeium#CycleCompletions"](-1)
       end, { expr = true, silent = true, desc = "Previous Codeium Suggestion" })

       -- Clear current suggestion
       vim.keymap.set("i", "<C-x>", function()
         return vim.fn["codeium#Clear"]()
       end, { expr = true, silent = true, desc = "Clear Codeium Suggestion" })
     end,
   },
   -- Agentic disabled for performance - too resource intensive
   -- {
   --   "carlos-algms/agentic.nvim",
   --   event = "VeryLazy",
   --   opts = {
   --     -- Available by default: "claude-acp" | "gemini-acp" | "codex-acp" | "opencode-acp" | "cursor-acp"
   --     provider = "opencode-acp", -- setting the name here is all you need to get started
   --   },
   --
   --   -- these are just suggested keymaps; customize as desired
   --   keys = {
   --     {
   --       "<leader>at",
   --       function()
   --         require("agentic").toggle()
   --       end,
   --       mode = { "n", "v", "i" },
   --       desc = "Toggle Agentic Chat",
   --     },
   --     {
   --       "<leader>as",
   --       function()
   --         require("agentic").add_selection_or_file_to_context()
   --       end,
   --       mode = { "n", "v" },
   --       desc = "Add file or selection to Agentic to Context",
   --     },
   --     {
   --       "<leader>an",
   --       function()
   --         require("agentic").new_session()
   --       end,
   --       mode = { "n", "v", "i" },
   --       desc = "New Agentic Session",
   --     },
   --   },
   -- },
}
