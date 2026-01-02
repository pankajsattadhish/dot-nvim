-- All visual/UI/Status elements.
return {
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    lazy = true,
    specs = {
      "folke/snacks.nvim",
      opts = function(_, opts)
        return vim.tbl_deep_extend("force", opts or {}, {
          picker = {
            actions = require("trouble.sources.snacks").actions,
            win = {
              input = {
                keys = {
                  ["<c-t>"] = { "trouble_open", mode = { "n", "i" } },
                },
              },
            },
          },
        })
      end,
    },
    keys = {
      { "<leader>dt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble (workspace)" },
      {
        "<leader>dT",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Trouble (buffer)",
      },
      { "<leader>dL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
      { "<leader>dQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },
      {
        "<leader>lt",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP References (Trouble)",
      },
      { "<leader>lT", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
    },
    config = function()
      require("trouble").setup({
        mode = "workspace_diagnostics",
        position = "bottom",
        height = 15,
        padding = false,
        action_keys = {
          close = "q",
          cancel = "<esc>",
          refresh = "r",
          jump = { "<cr>", "<tab>" },
          open_split = { "<c-x>" },
          open_vsplit = { "<c-v>" },
          open_tab = { "<c-t>" },
          jump_close = { "o" },
          toggle_mode = "m",
          toggle_preview = "P",
          hover = "K",
          preview = "p",
          close_folds = { "zM" },
          open_folds = { "zR" },
          toggle_fold = { "za" },
        },
        auto_jump = {},
        use_diagnostic_signs = true,
      })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    enabled = true,
    opts = {},
    dependencies = {
      "MunifTanjim/nui.nvim",
      -- "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          hover = {
            silent = true,
          },
        },
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
      })
    end,
  },
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
          set_arrow_to_diag_color = false,
          add_messages = true,
          throttle = 20,
          softwrap = 30,
          multilines = { enabled = false, always_show = false },
          show_all_diags_on_cursorline = false,
          enable_on_insert = false,
          enable_on_select = false,
          overflow = { mode = "wrap", padding = 0 },
          break_line = { enabled = false, after = 30 },
          format = nil,
          virt_texts = { priority = 2048 },
          severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
          },
          overwrite_events = nil,
        },
        disabled_ft = {},
      })
      vim.diagnostic.config({ virtual_text = false })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          component_separators = { left = "│", right = "│" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = { "NvimTree" }, -- Hide statusline in file explorer
            winbar = {},
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- This function runs when Nvim-Tree opens
      local function my_on_attach(bufnr)
        local api = require("nvim-tree.api")

        -- Load default mappings first
        api.config.mappings.default_on_attach(bufnr)

        local opts = { buffer = bufnr, noremap = true, silent = true, nowait = true }
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
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        -- Dynamic size based on direction
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4 -- Uses 40% of the screen width
          end
        end,
        hide_numbers = true,
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "vertical", -- Default direction
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
        },
      })

      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        -- ESC to go to Normal Mode in terminal
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
        -- Window navigation from inside terminal
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
      end

      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
    end,
    -- Custom Key Definitions
    keys = {
      {
        "<C-5>",
        "<cmd>ToggleTerm direction=vertical<cr>",
        desc = "Toggle Vertical Terminal",
        mode = { "n", "t" }, -- Works in Normal and Terminal mode
      },
      {
        "<C-'>", -- This is Ctrl + Shift + /
        "<cmd>ToggleTerm direction=horizontal<cr>",
        desc = "Toggle Horizontal Terminal",
        mode = { "n", "t" },
      },
      {
        "<C-/>",
        "<cmd>ToggleTerm direction=vertical<cr>",
        desc = "Toggle Vertical Terminal",
        mode = { "n", "t" },
      },
    },
  },
  {
    "tris203/precognition.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
