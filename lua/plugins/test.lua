-- =============================================================================
-- NEOTEST PLUGIN CONFIGURATION
-- =============================================================================
-- This file sets up Neotest, a plugin for Neovim that helps you run tests.
-- Tests are like little programs that check if your code works correctly.
-- Imagine writing code for a game, and tests make sure the game doesn't crash or do wrong things.
-- Neotest lets you run these tests right inside Neovim without leaving your editor.
-- It's useful for programmers who want to check their code quickly.

return {
  -- MAIN NEOTEST PLUGIN
  -- This is the main Neotest plugin that does all the test running.
  -- It uses "adapters" like tools to talk to different test systems.
  {
    "nvim-neotest/neotest", -- The main plugin name.
    dependencies = { -- Other plugins that Neotest needs to work properly.
      "nvim-neotest/nvim-nio", -- Helps with input/output for tests.
      "nvim-lua/plenary.nvim", -- A helper library, like a toolbox for plugins.
      "antoinemadec/FixCursorHold.nvim", -- Fixes a Neovim bug with waiting.
      "nvim-treesitter/nvim-treesitter", -- Helps understand code structure.
      "marilari88/neotest-vitest", -- Adapter for Vitest, a test runner for JavaScript.
    },

    -- =============================================================================
    -- KEYMAPS FOR NEOTEST
    -- =============================================================================
    -- Keymaps are like shortcuts on your keyboard to do things quickly.
    -- These start with <leader>t, meaning press your leader key (space) then 't' then the letter.
    -- For example, <leader>tr means space + t + r to run a test.
    keys = {
      -- Run the test that's closest to your cursor (like the one under your mouse).
      {
        "<leader>tr",
        function()
          require("neotest").run.run()
        end,
        desc = "Run Nearest Test",
      },

      -- Run all tests in the file you're looking at.
      {
        "<leader>tf",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run Current File",
      },

      -- Run ALL tests in your whole project. This might take time!
      {
        "<leader>ta",
        function()
          require("neotest").run.run({ suite = true })
        end,
        desc = "Run All Tests",
      },

      -- Show or hide a window that lists all tests and their results.
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Toggle Test Summary",
      },

      -- Open a window to see the output (messages) from the test that just ran.
      {
        "<leader>to",
        function()
          require("neotest").output.open()
        end,
        desc = "Open Test Output",
      },

      -- Show or hide a panel with test output, like a sidebar.
      {
        "<leader>tO",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "Toggle Output Panel",
      },

      -- Run the nearest test but with debugging, so you can step through the code slowly.
      {
        "<leader>td",
        function()
          require("neotest").run.run({ strategy = "dap" })
        end,
        desc = "Debug Nearest Test",
      },
    },

    -- =============================================================================
    -- CONFIGURATION FUNCTION
    -- =============================================================================
    -- This is where we tell Neotest how to work.
    -- It's like setting up the rules for the game.
    config = function()
      -- Require means "get" the neotest module so we can use it.
      require("neotest").setup({
        -- Adapters are like translators that help Neotest talk to different test systems.
        -- Each language has its own way of running tests, so we need adapters for each.
        adapters = {
          -- For JavaScript and TypeScript, using Vitest (a fast test runner).
          require("neotest-vitest"),

          -- For Python, which is another programming language.
          require("neotest-python"),

          -- For Rust, a language for fast and safe programs.
          require("neotest-rust"),

        },
      })
    end,
  },
}
