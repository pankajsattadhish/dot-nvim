return {
  -- Fidget: LSP progress indicator
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      notification = {
        window = {
          winblend = 0,
        },
      },
    },
  },

  -- Tiny Inline Diagnostic: clean inline error/warning display
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "classic",
        transparent_bg = false,
        transparent_cursorline = false,
        hi = {
          error = "DiagnosticError",
          warn = "DiagnosticWarn",
          info = "DiagnosticInfo",
          hint = "DiagnosticHint",
          arrow = "NonText",
          background = "CursorLine",
          mixing_color = "None",
        },
        options = {
          show_source = { enabled = false, if_many = false },
          use_icons_from_diagnostic = false,
          add_messages = true,
          throttle = 20,
          softwrap = 30,
          multilines = { enabled = false, always_show = false },
          enable_on_insert = false,
          enable_on_select = false,
          overflow = { mode = "wrap", padding = 0 },
          break_line = { enabled = false },
          virt_texts = { priority = 2048 },
          severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
          },
          disabled_ft = {},
        },
      })

      -- Disable default virtual_text (we use tiny-inline)
      vim.diagnostic.config({ virtual_text = false })
    end,
  },
}
