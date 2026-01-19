return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-python",
      "rouge8/neotest-rust",
      "nvim-neotest/neotest-go",
    },

    keys = {
      {
        "<leader>tr",
        function()
          require("neotest").run.run()
        end,
        desc = "Run nearest test",
      },
      {
        "<leader>tf",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run file tests",
      },
      {
        "<leader>ta",
        function()
          require("neotest").run.run({ suite = true })
        end,
        desc = "Run all tests",
      },
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Toggle test summary",
      },
      {
        "<leader>to",
        function()
          require("neotest").output.open({ enter = true })
        end,
        desc = "Open test output",
      },
      {
        "<leader>tO",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "Toggle output panel",
      },
      {
        "<leader>td",
        function()
          require("neotest").run.run({ strategy = "dap" })
        end,
        desc = "Debug nearest test",
      },
    },

    config = function()
      local neotest = require("neotest")

      neotest.setup({
        adapters = {
          -- Vitest
          require("neotest-vitest")({
            -- Optional but recommended
            -- You can remove this whole block if not needed
            vitestCommand = "vitest",
            filter_dir = function(name)
              return name ~= "node_modules"
            end,
          }),

          -- Python
          require("neotest-python")({
            dap = { justMyCode = false },
            args = { "--maxfail=1", "--disable-warnings" },
            runner = "pytest",
          }),

          -- Rust
          require("neotest-rust")({
            args = { "--nocapture" },
          }),

          -- Go
          require("neotest-go")({
            experimental = { test_table = true },
            args = { "-count=1", "-timeout=60s" },
          }),
        },
      })
    end,
  },
}
