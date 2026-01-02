-- All things related to in-buffer text manipulation.
return {
  -- Editor config and indentation detection
  { "tpope/vim-sleuth" },
  { "editorconfig/editorconfig-vim" },

  -- VSCode-style diff viewer
  {
    "esmuellert/vscode-diff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("vscode-diff").setup({
        highlights = {
          line_insert = "#2a3325",
          line_delete = "#362c2e",
          char_insert = "#3d4f35",
          char_delete = "#4d3538",
        },
        keymaps = {
          view = {
            next_hunk = "]c",
            prev_hunk = "[c",
            next_file = "]f",
            prev_file = "[f",
          },
          explorer = {
            select = "<CR>",
            hover = "K",
            refresh = "R",
          },
        },
      })
    end,
  },
  {
    "echasnovski/mini.nvim",
    config = function()
      -- Better Around/Inside textobjects
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require("mini.ai").setup({ n_lines = 500 })

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require("mini.surround").setup()

      require("mini.pairs").setup()

      -- Statusline is now handled by lualine, so disable mini.statusline
      -- local statusline = require("mini.statusline")
      -- statusline.setup({
      --   use_icons = vim.g.have_nerd_font,
      --   set_vim_settings = false,
      -- })
      -- ---@diagnostic disable-next-line: duplicate-set-field
      -- statusline.section_location = function()
      --   return "%2l:%-2v"
      -- end
    end,
  },
  {
    "echasnovski/mini.icons",
    enabled = true,
    opts = {},
    lazy = true,
  },
  {
    "numToStr/Comment.nvim",
    opts = {},
    lazy = false,
  },
  { "joosepalviste/nvim-ts-context-commentstring", lazy = true },
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
  },
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
  },
}
