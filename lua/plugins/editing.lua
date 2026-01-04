-- =============================================================================
-- EDITING ENHANCEMENTS
-- =============================================================================
-- Plugins that improve text editing, formatting, and manipulation.

return {
  -- Vim-Sleuth: Automatically detects and sets indentation settings.
  -- Looks at existing files to determine tab vs spaces, width, etc.
  { "tpope/vim-sleuth" },

  -- EditorConfig: Respects .editorconfig files for consistent formatting.
  -- Different projects can have different style rules.
  { "editorconfig/editorconfig-vim" },

  -- VSCode Diff: Git diff viewer similar to VSCode.
  -- Shows file changes with syntax highlighting and navigation.
  {
    "esmuellert/vscode-diff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" }, -- Required UI library.
    config = function()
      require("vscode-diff").setup({
        highlights = { -- Colors for different change types.
          line_insert = "#2a3325", -- Background for added lines.
          line_delete = "#362c2e", -- Background for deleted lines.
          char_insert = "#3d4f35", -- Background for added characters.
          char_delete = "#4d3538", -- Background for deleted characters.
        },
        keymaps = { -- Navigation keys.
          view = { -- In diff view.
            next_hunk = "]c", -- Next change hunk.
            prev_hunk = "[c", -- Previous change hunk.
            next_file = "]f", -- Next file.
            prev_file = "[f", -- Previous file.
          },
          explorer = { -- In file explorer.
            select = "<CR>", -- Open file.
            hover = "K", -- Show file info.
            refresh = "R", -- Refresh.
          },
        },
      })
    end,
  },
  -- Mini.nvim: Collection of small, focused plugins.
  -- Provides textobjects, surroundings, pairs, and more.
  {
    "echasnovski/mini.nvim",
    config = function()
      -- Mini.ai: Enhanced textobjects for selecting text around objects.
      -- Examples: va) selects around parentheses, yinq yanks inside next quote.
      require("mini.ai").setup({ n_lines = 500 }) -- Look 500 lines for textobjects.

      -- Mini.surround: Easy add/delete/replace surroundings.
      -- Examples: saiw) surrounds word with parens, sd' deletes quotes.
      require("mini.surround").setup()

      -- Mini.pairs: Auto-close brackets, quotes, etc.
      require("mini.pairs").setup()

      -- Mini.statusline: Simple statusline (disabled, using lualine instead).
      -- Commented out because lualine provides more features.
      -- local statusline = require("mini.statusline")
      -- statusline.setup({
      --   use_icons = vim.g.have_nerd_font, -- Use icons if available.
      --   set_vim_settings = false, -- Don't override vim settings.
      -- })
      -- ---@diagnostic disable-next-line: duplicate-set-field
      -- statusline.section_location = function() -- Custom location format.
      --   return "%2l:%-2v" -- Line:column
      -- end
    end,
  },
  -- Mini.icons: Icon provider for mini plugins.
  -- Provides nerd font icons for file types, etc.
  {
    "echasnovski/mini.icons",
    enabled = true, -- Enable this plugin.
    opts = {}, -- Default options.
    lazy = true, -- Load when needed.
  },

  -- Comment: Smart commenting plugin.
  -- Comments/uncomments lines with context awareness.
  {
    "numToStr/Comment.nvim",
    opts = {}, -- Default options.
    lazy = false, -- Load immediately.
  },

  -- TS Context Commentstring: Uses treesitter to determine comment syntax.
  -- Comments correctly in embedded languages (JS in HTML, etc.).
  { "joosepalviste/nvim-ts-context-commentstring", lazy = true },

  -- TS Autotag: Auto-close/rename HTML/XML tags using treesitter.
  -- When you change <div> to <span>, it updates the closing tag too.
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" }, -- Load when opening files.
    opts = {}, -- Default options.
  },

  -- Persistence: Session management.
  -- Saves open buffers, windows, etc. and restores them.
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- Load before reading files.
    opts = {}, -- Default options.
  },

  -- Hardtime: Prevents inefficient vim habits.
  -- Shows hints when you use arrow keys or inefficient motions.
  {
    "m4xshen/hardtime.nvim",
    lazy = false, -- Load immediately.
    dependencies = { "MunifTanjim/nui.nvim" }, -- Required UI library.
    opts = {}, -- Default options (encourages good habits).
  },
}
