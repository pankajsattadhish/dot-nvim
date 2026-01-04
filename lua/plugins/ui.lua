-- =============================================================================
-- USER INTERFACE AND VISUAL ELEMENTS
-- =============================================================================
-- This file configures plugins that enhance Neovim's user interface.
-- Includes status lines, diagnostics, notifications, file trees, terminals, etc.

return {
  -- Trouble: Pretty diagnostics, references, and quickfix list.
  -- Shows errors/warnings in a nice panel instead of quickfix.
  {
    "folke/trouble.nvim",
    cmd = "Trouble", -- Load on command (lazy).
    opts = {}, -- Use default options.
    lazy = true, -- Don't load until needed.
    specs = { -- Modify Snacks plugin config.
      "folke/snacks.nvim",
      opts = function(_, opts)
        return vim.tbl_deep_extend("force", opts or {}, {
          picker = { -- Snacks picker configuration.
            actions = require("trouble.sources.snacks").actions, -- Add Trouble actions.
            win = {
              input = {
                keys = {
                  ["<c-t>"] = { "trouble_open", mode = { "n", "i" } }, -- Ctrl+T to open Trouble.
                },
              },
            },
          },
        })
      end,
    },
    -- Keybindings for Trouble commands.
    keys = {
      { "<leader>dt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble (workspace)" }, -- All workspace diagnostics.
      {
        "<leader>dT",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Trouble (buffer)",
      }, -- Current buffer only.
      { "<leader>dL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" }, -- Location list.
      { "<leader>dQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" }, -- Quickfix list.
      {
        "<leader>lt",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP References (Trouble)",
      }, -- LSP references in right panel.
      { "<leader>lT", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" }, -- Document symbols.
    },
    config = function()
      require("trouble").setup({
        mode = "workspace_diagnostics", -- Default to workspace diagnostics.
        position = "bottom", -- Show at bottom of screen.
        height = 15, -- Height in lines.
        padding = false, -- No padding around items.
        action_keys = { -- Keybindings within Trouble window.
          close = "q", -- Close window.
          cancel = "<esc>", -- Cancel.
          refresh = "r", -- Refresh list.
          jump = { "<cr>", "<tab>" }, -- Jump to item.
          open_split = { "<c-x>" }, -- Open in split.
          open_vsplit = { "<c-v>" }, -- Open in vertical split.
          open_tab = { "<c-t>" }, -- Open in new tab.
          jump_close = { "o" }, -- Jump and close.
          toggle_mode = "m", -- Change mode.
          toggle_preview = "P", -- Toggle preview.
          hover = "K", -- Show hover info.
          preview = "p", -- Preview item.
          close_folds = { "zM" }, -- Close all folds.
          open_folds = { "zR" }, -- Open all folds.
          toggle_fold = { "za" }, -- Toggle fold.
        },
        auto_jump = {}, -- Don't auto-jump on open.
        use_diagnostic_signs = true, -- Use diagnostic signs.
      })
    end,
  },
  -- Noice: Improved UI for messages, cmdline, and popups.
  -- Replaces default Neovim UI with better looking, more functional versions.
  {
    "folke/noice.nvim",
    event = "VeryLazy", -- Load late in startup.
    enabled = true, -- Plugin is enabled.
    opts = {}, -- Use default options.
    dependencies = {
      "MunifTanjim/nui.nvim", -- Required UI library.
      -- "rcarriga/nvim-notify", -- Optional notification replacement.
    },
    config = function()
      require("noice").setup({
        lsp = { -- LSP-related UI improvements.
          override = { -- Override default LSP functions with Noice versions.
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true, -- Better markdown rendering.
            ["vim.lsp.util.stylize_markdown"] = true, -- Stylize markdown.
            ["cmp.entry.get_documentation"] = true, -- Better completion docs.
          },
          hover = {
            silent = true, -- Don't show messages when hovering.
          },
        },
        presets = { -- Pre-configured UI improvements.
          bottom_search = true, -- Classic bottom search cmdline.
          command_palette = true, -- Command palette style for cmdline.
          long_message_to_split = true, -- Long messages go to split window.
          inc_rename = false, -- Disable incremental rename dialog.
          lsp_doc_border = true, -- Add borders to LSP documentation.
        },
      })
    end,
  },
  -- Fidget: LSP progress indicator.
  -- Shows a spinner in corner when LSP is working (loading, indexing, etc.).
  {
    "j-hui/fidget.nvim",
    event = "LspAttach", -- Load when LSP attaches to buffer.
    opts = {
      notification = {
        window = {
          winblend = 0, -- No transparency for notifications.
        },
      },
    },
  },
  -- Tiny Inline Diagnostic: Shows diagnostics inline with code.
  -- Instead of signs in gutter, shows error/warning text next to code.
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Load late.
    priority = 1000, -- Load early.
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "classic", -- Classic appearance.
        transparent_bg = false, -- Don't make background transparent.
        transparent_cursorline = false, -- Don't make cursorline transparent.
        hi = { -- Highlight groups for diagnostics.
          error = "DiagnosticError", -- Error color.
          warn = "DiagnosticWarn", -- Warning color.
          info = "DiagnosticInfo", -- Info color.
          hint = "DiagnosticHint", -- Hint color.
          arrow = "NonText", -- Arrow color.
          background = "CursorLine", -- Background highlight.
          mixing_color = "None", -- No mixing color.
        },
        options = {
          show_source = { enabled = false, if_many = false }, -- Don't show source.
          use_icons_from_diagnostic = false, -- Use custom icons.
          set_arrow_to_diag_color = false, -- Don't color arrows.
          add_messages = true, -- Show diagnostic messages.
          throttle = 20, -- Update every 20ms.
          softwrap = 30, -- Soft wrap at 30 chars.
          multilines = { enabled = false, always_show = false }, -- No multiline.
          show_all_diags_on_cursorline = false, -- Show all on current line.
          enable_on_insert = false, -- Don't show in insert mode.
          enable_on_select = false, -- Don't show when selecting.
          overflow = { mode = "wrap", padding = 0 }, -- Wrap overflow.
          break_line = { enabled = false, after = 30 }, -- Don't break lines.
          format = nil, -- No custom formatting.
          virt_texts = { priority = 2048 }, -- Virtual text priority.
          severity = { -- Which severities to show.
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
          },
          disabled_ft = {}, -- No disabled filetypes.
        },
      })
      vim.diagnostic.config({ virtual_text = false }) -- Disable default virtual text.
    end,
  },
  -- Lualine: Status line at bottom of Neovim.
  -- Shows mode, filename, git branch, diagnostics, etc.
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Icons for filetypes.
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto", -- Auto-detect from colorscheme.
          globalstatus = true, -- Single statusline for all windows.
          component_separators = { left = "│", right = "│" }, -- Separators between components.
          section_separators = { left = "", right = "" }, -- Separators between sections.
          disabled_filetypes = {
            statusline = { "" }, -- Hide in file explorer.
            winbar = {}, -- No winbar.
          },
        },
        sections = { -- Active window statusline.
          lualine_a = { "mode" }, -- Current mode (NORMAL, INSERT, etc.).
          lualine_b = { "branch", "diff", "diagnostics" }, -- Git branch, changes, errors.
          lualine_c = { "filename" }, -- Current file name.
          lualine_x = { "encoding", "fileformat", "filetype" }, -- File encoding, format, type.
          lualine_y = { "progress" }, -- Percentage through file.
          lualine_z = { "location" }, -- Line and column number.
        },
        inactive_sections = { -- Inactive windows statusline.
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" }, -- Just show filename.
          lualine_x = { "location" }, -- Just show position.
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },
  -- NvimTree: File explorer sidebar.
  -- Browse files and folders like a tree view.
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- File type icons.
    config = function()
      -- Function called when NvimTree attaches to a buffer.
      local function my_on_attach(bufnr)
        local api = require("nvim-tree.api")

        -- Load default key mappings first.
        api.config.mappings.default_on_attach(bufnr)
      end
      require("nvim-tree").setup({
        on_attach = my_on_attach, -- Use our custom attach function.
        disable_netrw = true, -- Disable built-in netrw.
        hijack_netrw = true, -- Use NvimTree instead of netrw.
        sync_root_with_cwd = true, -- Sync tree root with current working directory.
        view = {
          width = 30, -- Width of the tree window.
          side = "left", -- Show on left side.
          preserve_window_proportions = true, -- Keep proportions when resizing.
        },
        renderer = {
          root_folder_label = false, -- Don't label root folder.
          highlight_git = true, -- Highlight git status.
          indent_markers = { enable = true }, -- Show indent lines.
          icons = {
            glyphs = { -- Custom icons for different file types.
              default = "󰈚", -- Default file icon.
              folder = {
                default = "", -- Closed folder.
                empty = "", -- Empty folder.
                empty_open = "", -- Empty open folder.
                open = "", -- Open folder.
                symlink = "", -- Symlink folder.
              },
              git = { -- Git status icons.
                unstaged = "✗", -- Modified.
                staged = "✓", -- Staged.
                unmerged = "", -- Merge conflict.
                renamed = "➜", -- Renamed.
                untracked = "★", -- New file.
                deleted = "", -- Deleted.
                ignored = "◌", -- Ignored.
              },
            },
          },
        },
      })

      -- Toggle the file explorer.
      vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle Explorer" })
      -- Focus current file in explorer.
      vim.keymap.set("n", "<leader>E", "<cmd>NvimTreeFindFile<CR>", { desc = "Focus current file" })
    end,
  },
  -- ToggleTerm: Terminal windows inside Neovim.
  -- Open terminals in splits or floating windows.
  {
    "akinsho/toggleterm.nvim",
    version = "*", -- Latest version.
    config = function()
      require("toggleterm").setup({
        -- Size depends on direction.
        size = function(term)
          if term.direction == "horizontal" then
            return 15 -- 15 lines high.
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4 -- 40% of screen width.
          end
        end,
        hide_numbers = true, -- Hide line numbers in terminal.
        shade_terminals = true, -- Shade terminal background.
        start_in_insert = true, -- Start in insert mode.
        insert_mappings = true, -- Allow insert mode mappings.
        persist_size = true, -- Remember terminal size.
        direction = "vertical", -- Default to vertical split.
        close_on_exit = true, -- Close terminal when process exits.
        shell = vim.o.shell, -- Use Neovim's shell setting.
        float_opts = {
          border = "curved", -- Curved border for floating terminals.
        },
      })

      -- Set keymaps when terminal opens.
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        -- Escape to normal mode in terminal.
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
        -- Window navigation from terminal.
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
      end

      -- Auto-set keymaps for all terminals.
      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
    end,
    -- Keybindings to toggle terminals.
    keys = {
      {
        "<C-5>", -- Ctrl+5
        "<cmd>ToggleTerm direction=vertical<cr>",
        desc = "Toggle Vertical Terminal",
        mode = { "n", "t" }, -- Works in normal and terminal modes.
      },
      {
        "<C-'>", -- Ctrl + single quote (might be Ctrl+Shift+/)
        "<cmd>ToggleTerm direction=horizontal<cr>",
        desc = "Toggle Horizontal Terminal",
        mode = { "n", "t" },
      },
      {
        "<C-/>", -- Ctrl + /
        "<cmd>ToggleTerm direction=vertical<cr>",
        desc = "Toggle Vertical Terminal",
        mode = { "n", "t" },
      },
    },
  },
  -- Precognition: Shows upcoming motions as virtual text.
  -- Helps learn vim motions by showing hints.
  {
    "tris203/precognition.nvim",
    event = "VeryLazy", -- Load very late.
    opts = {}, -- Default options.
  },
}
