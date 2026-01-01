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
      no_overlap = false, -- Allow overlapping with other windows if needed
      padding = { 1, 2 }, -- Extra padding for cleaner look
      title = true,
      title_pos = "center",
      zindex = 1000, -- Force menu to be ABOVE Noice and Snacks
      -- bo = { filetype = "whichkey" },
    },
    layout = {
      width = { min = 20 },
      spacing = 3,
    },
    spec = {
      mode = { "n", "v" },
      -- Main groups (alphabetical)
      { "<leader>a", group = "AI" },
      { "<leader>b", group = "Buffers" },
      { "<leader>c", group = "Code" },
      { "<leader>d", group = "Diagnostics/Debug" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>l", group = "LSP" },
      { "<leader>s", group = "Search" },
      { "<leader>u", group = "UI" },
      { "<leader>w", group = "Windows" },
      -- Navigation groups
      { "[", group = "Prev" },
      { "]", group = "Next" },
      { "g", group = "Goto" },
      -- Hidden (standalone keymaps)
      { "<leader>v", hidden = true },
    },
  },
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
