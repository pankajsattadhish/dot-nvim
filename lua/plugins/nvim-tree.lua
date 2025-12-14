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

      -- REMOVE the default <C-k> mapping (which shows file info)
      -- so that we can use it to move up to the code window
      vim.keymap.del('n', '<C-k>', { buffer = bufnr })

      -- Explicitly tell Nvim-Tree to use our global window navigation
      vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
      vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
      vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
      vim.keymap.set('n', '<C-l>', '<C-w>l', opts)
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
