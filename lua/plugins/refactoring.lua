return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
    keys = {
      -- Select a refactor from a picker
      {
        "<leader>rr",
        function()
          require("refactoring").select_refactor()
        end,
        mode = { "n", "x" },
        desc = "Refactor: Select",
      },
      -- Extract Function (Visual Mode)
      {
        "<leader>re",
        function()
          require("refactoring").refactor("Extract Function")
        end,
        mode = "x",
        desc = "Refactor: Extract Function",
      },
      -- Extract Variable (Visual Mode)
      {
        "<leader>rv",
        function()
          require("refactoring").refactor("Extract Variable")
        end,
        mode = "x",
        desc = "Refactor: Extract Variable",
      },
    },
    config = true, -- Default config is usually fine
  },
}
