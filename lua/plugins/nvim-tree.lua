return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- This function runs when Nvim-Tree opens
    local function my_on_attach(bufnr)
      local api = require "nvim-tree.api"

      -- Load default mappings first
      api.config.mappings.default_on_attach(bufnr)

      local opts = { buffer = bufnr, noremap = true, silent = true, nowait = true }

    end
    require("nvim-tree").setup({
      on_attach = my_on_attach, -- Attach our custom key logic
      disable_netrw = true,
      hijack_netrw = true,
      sync_root_with_cwd = true,
      view = {
        width = 30,
        side = "left",
        preserve_window_proportions = true,
      },
      renderer = {
        root_folder_label = false,
        highlight_git = true,
        indent_markers = { enable = true },
        icons = {
          glyphs = {
            default = "󰈚",
            folder = {
              default = "",
              empty = "",
              empty_open = "",
              open = "",
              symlink = "",
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },
    })

    -- Keymap to toggle explorer
    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle Explorer" })
  end,
}
