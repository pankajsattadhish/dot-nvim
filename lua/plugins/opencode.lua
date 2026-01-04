return {
  -- OpenCode: AI coding assistant plugin.
  "NickvanDyke/opencode.nvim",
  dependencies = {
    -- Recommended for ask() and select() functions.
    -- Required when using 'snacks' as the provider.
    ---@module 'snacks' -- Loads Snacks types for intellisense.
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } }, -- Minimal Snacks setup.
  },
  config = function()
    ---@type opencode.Opts -- Type hint for configuration.
    vim.g.opencode_opts = {
      -- Your custom configuration goes here.
      -- See lua/opencode/config.lua for options, or use goto definition.
    }

    -- Required for opts.events.reload to work properly.
    vim.o.autoread = true -- Auto-reload files changed outside Neovim.

    -- Recommended keybindings for common OpenCode actions.
    vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode" }) -- Ask about selected code.
    vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end, { desc = "Execute opencode action…" }) -- Select from available actions.
    vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end, { desc = "Toggle opencode" }) -- Toggle AI chat window.

    -- Operator mappings to add text ranges to AI context.
    vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end, { expr = true, desc = "Add range to opencode" }) -- Add visual selection.
    vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end, { expr = true, desc = "Add line to opencode" }) -- Add current line.

    -- Scroll commands for AI chat (like page up/down).
    vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end, { desc = "opencode half page up" }) -- Scroll up.
    vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "opencode half page down" }) -- Scroll down.

    -- Smart commit keybinding.
    vim.keymap.set("n", "<leader>gc", function() require("opencode").ask("/smart-commit", { submit = true }) end, { desc = "Smart commit changes by feature" })

    -- Alternative keybindings if you use the opinionated Ctrl+A and Ctrl+X above.
    -- These restore the original increment/decrement functionality.
    vim.keymap.set("n", "+", "<C-a>", { desc = "Increment", noremap = true }) -- Number increment.
    vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement", noremap = true }) -- Number decrement.
  end,
}
