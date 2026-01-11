-- =============================================================================
-- FLASH: FAST JUMPING AND SEARCH
-- =============================================================================
-- Flash provides lightning-fast jumping to any visible location.
-- Type a few letters and jump directly to matching text.

return {
  -- Flash: Jump to locations with minimal keystrokes.
  "folke/flash.nvim",
  event = "VeryLazy", -- Load late in startup.
  ---@type Flash.Config -- Type hint for configuration.
  opts = {}, -- Use default options.
  -- stylua: ignore -- Tell formatter to ignore this section.
  keys = { -- Keybindings for Flash features.
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" }, -- Jump to any location.
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" }, -- Jump using treesitter nodes.
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" }, -- Remote jump in operator pending.
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" }, -- Search treesitter nodes.
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" }, -- Toggle in command mode.
  },
}
