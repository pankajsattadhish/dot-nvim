return {
  "folke/which-key.nvim",
  event = "VeryLazy",

  opts = {
    preset = "helix",
    delay = 200,

    sort = { "alphanum", "local", "order", "group", "mod" },

    icons = {
      rules = false,
      breadcrumb = " ",
      separator = "󱦰  ",
      group = "󰹍 ",
    },

    plugins = {
      spelling = { enabled = false },
    },

    win = {
      no_overlap = false,
      padding = { 1, 2 },
      title = true,
      title_pos = "center",
      zindex = 1000,
    },

    layout = {
      width = { min = 20 },
      spacing = 3,
    },

    ------------------------------------------------------------
    -- GROUP DEFINITIONS
    ------------------------------------------------------------
    spec = {
      mode = { "n", "v" },

      -- Leader groups
      { "<leader>a", group = "AI" },
      { "<leader>b", group = "Buffers" },
      { "<leader>c", group = "Code" },
      { "<leader>d", group = "Diagnostics/Debug" },
      { "<leader>D", group = "Database" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git (snacks)" },
      { "<leader>G", group = "Git (fugitive)" },
      { "<leader>h", group = "Harpoon" },
      { "<leader>l", group = "LSP" },
      { "<leader>s", group = "Search" },
      { "<leader>u", group = "UI" },

      -- Navigation
      { "[", group = "Prev" },
      { "]", group = "Next" },
      { "g", group = "Goto" },
    },
  },

  ------------------------------------------------------------
  -- Extra keymaps
  ------------------------------------------------------------
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Keymaps (buffer)",
    },
  },
}
