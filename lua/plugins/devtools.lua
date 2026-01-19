return {
  ---------------------------------------------------------------------------
  -- Refactoring: Treesitter-powered code refactors
  ---------------------------------------------------------------------------
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("refactoring").setup()
    end,
    keys = {
      -- Universal refactor picker
      {
        "<leader>rr",
        function()
          require("refactoring").select_refactor()
        end,
        mode = { "n", "x" },
        desc = "Refactor: Select",
      },

      -- Extract Function
      {
        "<leader>re",
        function()
          require("refactoring").refactor("Extract Function")
        end,
        mode = "x",
        desc = "Refactor: Extract Function",
      },

      -- Extract Variable
      {
        "<leader>rv",
        function()
          require("refactoring").refactor("Extract Variable")
        end,
        mode = "x",
        desc = "Refactor: Extract Variable",
      },
    },
  },
  ---------------------------------------------------------------------------
  -- Project root detection
  ---------------------------------------------------------------------------
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
      require("project_nvim").setup({
        manual_mode = false,
        detection_methods = { "lsp", "pattern" },
        patterns = {
          ".git",
          "Makefile",
          "package.json",
          "pom.xml",
          "build.gradle",
          "Cargo.toml",
          "go.mod",
          "pyproject.toml",
        },
        show_hidden = true,
      })
    end,
  },

  ---------------------------------------------------------------------------
  -- Git (CLI-first, Primeagen-approved)
  ---------------------------------------------------------------------------
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite" },
    keys = {
      { "<leader>Gs", "<cmd>Git<CR>", desc = "Fugitive: Status" },
      { "<leader>Gc", "<cmd>Git commit<CR>", desc = "Fugitive: Commit" },
      { "<leader>Gp", "<cmd>Git push<CR>", desc = "Fugitive: Push" },
      { "<leader>Gl", "<cmd>Git log<CR>", desc = "Fugitive: Log" },
    },
  },

  ---------------------------------------------------------------------------
  -- Sessions
  ---------------------------------------------------------------------------
  {
    "rmagatti/auto-session",
    event = "VimEnter",
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_restore_enabled = false,
        auto_session_suppress_dirs = {
          "~/",
          "~/Downloads",
          "/",
        },
      })
    end,
  },

  ---------------------------------------------------------------------------
  -- HTTP Client
  ---------------------------------------------------------------------------
  {
    "mistweaverco/kulala.nvim",
    ft = { "http" },
    config = function()
      require("kulala").setup({
        default_view = "body",
        default_env = "dev",
        debug = false,
        formatters = {
          json = { "jq", "." },
          xml = { "xmllint", "--format", "-" },
          html = { "xmllint", "--format", "--html", "-" },
        },
      })
    end,
    keys = {
      {
        "<leader>rr",
        function()
          require("kulala").run()
        end,
        desc = "Run HTTP Request",
      },
      {
        "<leader>ro",
        function()
          require("kulala").open()
        end,
        desc = "Open HTTP Response",
      },
      {
        "<leader>rt",
        function()
          require("kulala").toggle_view()
        end,
        desc = "Toggle HTTP View",
      },
    },
  },

  ---------------------------------------------------------------------------
  -- Database UI
  ---------------------------------------------------------------------------
  {
    "tpope/vim-dadbod",
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    keys = {
      { "<leader>Db", "<cmd>DBUIToggle<CR>", desc = "Database UI" },
    },
  },

  ---------------------------------------------------------------------------
  -- Markdown preview
  ---------------------------------------------------------------------------
  {
    "ellisonleao/glow.nvim",
    cmd = { "Glow" },
    ft = { "markdown" },
    config = function()
      require("glow").setup({
        style = "dark",
        width = 120,
      })
    end,
    keys = {
      { "<leader>mp", "<cmd>Glow<CR>", desc = "Markdown Preview" },
    },
  },

  ---------------------------------------------------------------------------
  -- Todo Comments (keep this)
  ---------------------------------------------------------------------------
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "VeryLazy",
    config = true,
    keys = {
      { "<leader>td", "<cmd>TodoTelescope<CR>", desc = "Todos" },
      { "<leader>tq", "<cmd>TodoQuickFix<CR>", desc = "Todos QuickFix" },
      { "<leader>tl", "<cmd>TodoLocList<CR>", desc = "Todos LocList" },
    },
  },
}
