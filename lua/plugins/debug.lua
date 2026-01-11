-- =============================================================================
-- SEARCH, REPLACE, AND REFACTORING
-- =============================================================================
-- Advanced search and replace across files, plus code refactoring tools.

return {
  -- Spectre: Powerful search and replace across files.
  -- Like sed or grep but interactive and visual.
  "windwp/nvim-spectre",
  dependencies = { "nvim-lua/plenary.nvim" }, -- Required utility library.
  keys = { -- Keybindings for Spectre operations.
    {
      "<leader>sS", -- Open full search and replace interface.
      function()
        require("spectre").open()
      end,
      desc = "Search & Replace",
    },
    {
      "<leader>sW", -- Replace word under cursor across files.
      function()
        require("spectre").open_visual({ select_word = true })
      end,
      desc = "Replace Word",
    },
    {
      "<leader>sF", -- Search and replace within current file.
      function()
        require("spectre").open_file_search()
      end,
      desc = "Replace in File",
    },
  },
  { -- Refactoring: Code refactoring tools using treesitter.
    -- Extract functions, variables, and perform other refactoring operations.
    {
      "ThePrimeagen/refactoring.nvim",
      dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" }, -- Requires treesitter and plenary.
      keys = { -- Keybindings for refactoring operations.
        -- Select a refactor from a picker menu.
        {
          "<leader>rr",
          function()
            require("refactoring").select_refactor() -- Show available refactors.
          end,
          mode = { "n", "x" }, -- Normal and visual modes.
          desc = "Refactor: Select",
        },
        -- Extract selected code into a new function.
        {
          "<leader>re",
          function()
            require("refactoring").refactor("Extract Function") -- Create function from selection.
          end,
          mode = "x", -- Visual mode only.
          desc = "Refactor: Extract Function",
        },
        -- Extract selected expression into a variable.
        {
          "<leader>rv",
          function()
            require("refactoring").refactor("Extract Variable") -- Create variable from selection.
          end,
          mode = "x", -- Visual mode only.
          desc = "Refactor: Extract Variable",
        },
      },
      config = true, -- Use default configuration (usually fine).
    },
  },
}
