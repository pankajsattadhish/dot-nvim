return {
  -- Detects indentation automatically. Essential.
  { "tpope/vim-sleuth" },

  -- Diff viewer (Keep as per your preference)
  {
    "esmuellert/codediff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("codediff").setup({
        highlights = {
          line_insert = "#2a3325",
          line_delete = "#362c2e",
          char_insert = "#3d4f35",
          char_delete = "#4d3538",
        },
        keymaps = {
          view = { next_hunk = "]c", prev_hunk = "[c", next_file = "]f", prev_file = "[f" },
          explorer = { select = "<CR>", hover = "K", refresh = "R" },
        },
      })
    end,
  },

  -- Mini.nvim suite: focused, fast, and modular.
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.surround").setup()
      require("mini.pairs").setup()

      -- NEW: Standardized jumps. Use [b / ]b for buffers, [q / ]q for quickfix, etc.
      -- This fits the "Vim Language" perfectly.
      require("mini.bracketed").setup()

      -- NEW: Visualize indent levels (Very helpful for Python/Go)
      require("mini.indentscope").setup({
        symbol = "│",
        options = { try_as_border = true },
      })
    end,
  },

  { "echasnovski/mini.icons", opts = {}, lazy = true },

  -- Optimized Commenting: Essential for JSX/TSX/Vue
  {
    "numToStr/Comment.nvim",
    dependencies = { "joosepalviste/nvim-ts-context-commentstring" },
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },

  -- Tree-sitter Autotag: Pure productivity for web dev
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- Session Management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    -- Primeagen Tip: Map a key to restore session
    keys = {
      {
        "<leader>qs",
        function()
          require("persistence").load()
        end,
        desc = "Restore Session",
      },
    },
  },
}
