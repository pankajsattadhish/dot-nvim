return {
  -- 1. CODEIUM (Ghost Text - Free & Unlimited)
  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    config = function()
      vim.g.codeium_disable_bindings = 1

      -- Keymap to Accept
      vim.keymap.set("i", "<C-g>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true })

      -- Toggle Function
      vim.keymap.set("n", "<leader>ct", function()
        if vim.g.codeium_enabled == 0 then
          vim.g.codeium_enabled = 1
          print("Codeium Enabled")
        else
          vim.g.codeium_enabled = 0
          print("Codeium Disabled")
        end
      end, { noremap = true, silent = true, desc = "Toggle Codeium" })

      -- Other existing keymaps
      vim.keymap.set("i", "<M-]>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<M-[>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<C-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true, silent = true })
    end,
  },
  {
    "carlos-algms/agentic.nvim",
    event = "VeryLazy",
    opts = {
      -- Available by default: "claude-acp" | "gemini-acp" | "codex-acp" | "opencode-acp" | "cursor-acp"
      provider = "opencode-acp", -- setting the name here is all you need to get started
    },

    -- these are just suggested keymaps; customize as desired
    keys = {
      {
        "<leader>at",
        function()
          require("agentic").toggle()
        end,
        mode = { "n", "v", "i" },
        desc = "Toggle Agentic Chat",
      },
      {
        "<leader>as",
        function()
          require("agentic").add_selection_or_file_to_context()
        end,
        mode = { "n", "v" },
        desc = "Add file or selection to Agentic to Context",
      },
      {
        "<leader>an",
        function()
          require("agentic").new_session()
        end,
        mode = { "n", "v", "i" },
        desc = "New Agentic Session",
      },
    },
  },
}
