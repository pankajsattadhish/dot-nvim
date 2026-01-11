-- =============================================================================
-- WHICH KEY: KEYBINDING HINTS
-- =============================================================================
-- Shows popup with available keybindings when you press a leader key.
-- Helps you discover and remember keyboard shortcuts.

return {
  -- WhichKey: Displays keybinding hints in a popup menu.
  "folke/which-key.nvim",
  event = "VeryLazy", -- Load late in startup.
  opts = {
    preset = "helix", -- UI style inspired by Helix editor.
    delay = 200, -- Wait 200ms before showing popup.
    sort = { "alphanum", "local", "order", "group", "mod" }, -- How to sort keys.
    icons = {
      rules = false, -- Don't use icon rules.
      breadcrumb = " ", -- Icon for breadcrumb trail.
      separator = "󱦰  ", -- Icon for separating groups.
      group = "󰹍 ", -- Icon for group indicators.
    },
    plugins = {
      spelling = { enabled = false }, -- Disable spelling suggestions.
    },
    win = { -- Window appearance settings.
      no_overlap = false, -- Allow overlapping with other windows.
      padding = { 1, 2 }, -- Extra padding for cleaner look.
      title = true, -- Show title in window.
      title_pos = "center", -- Center the title.
      zindex = 1000, -- High z-index to appear above other UI.
      -- bo = { filetype = "whichkey" }, -- Optional buffer options.
    },
    layout = {
      width = { min = 20 }, -- Minimum width.
      spacing = 3, -- Spacing between items.
    },
    spec = { -- Define key groups and individual keybindings.
      mode = { "n", "v" }, -- Apply to normal and visual modes.
      -- Main groups organized alphabetically by first letter.
      { "<leader>a", group = "AI" }, -- AI-related commands.
      { "<leader>aa", function() require("opencode").ask("@this: ", { submit = true }) end, desc = "Ask" }, -- Ask AI about current file.
      { "<leader>as", function() require("opencode").select() end, desc = "Select Action" }, -- Select AI action.
      { "<leader>at", function() require("opencode").toggle() end, desc = "Toggle" }, -- Toggle AI features.
      { "<leader>b", group = "Buffers" }, -- Buffer management.
      { "<leader>c", group = "Code" }, -- Code actions (format, refactor).
      { "<leader>d", group = "Diagnostics/Debug" }, -- Error checking and debugging.
      { "<leader>f", group = "Find" }, -- File and text search.
      { "<leader>g", group = "Git" }, -- Version control.
      { "<leader>l", group = "LSP" }, -- Language server features.
      { "<leader>s", group = "Search" }, -- Advanced search.
      { "<leader>u", group = "UI" }, -- User interface toggles.
      -- { "<leader>w", group = "Windows" }, -- Window management.
      -- Navigation groups using [ and ] keys.
      { "[", group = "Prev" }, -- Previous item (error, hunk, etc.).
      { "]", group = "Next" }, -- Next item.
      { "g", group = "Goto" }, -- Go to definition, references, etc.
      -- Hidden groups (don't show in menu).
      -- { "<leader>v", hidden = true }, -- Definition in split (standalone key).
    },
  },
  keys = { -- Additional keybindings for WhichKey.
    {
      "<leader>?", -- Show keymap hints for current buffer.
      function()
        require("which-key").show({ global = false }) -- Show buffer-local keys only.
      end,
      desc = "Keymaps (buffer)",
    },
  },
}
