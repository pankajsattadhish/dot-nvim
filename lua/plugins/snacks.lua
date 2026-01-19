return {
  -- Snacks: All-in-one utility plugin.
  "folke/snacks.nvim",
  priority = 1000, -- Load early.
  lazy = false, -- Load immediately.
  ---@type snacks.Config -- Type hint for configuration.
  opts = {
    -- Bigfile: Optimizes performance for large files.
    bigfile = { enabled = true },
    -- Dashboard: Start screen (disabled, using alpha instead).
    dashboard = { enabled = false },
    -- Explorer: File explorer (disabled, using nvim-tree).
    explorer = { enabled = false },
    -- Indent: Shows indentation guides.
    indent = { enabled = true },
    -- Input: Enhanced input dialogs.
    input = { enabled = true },
    -- Notifier: Notification system.
    notifier = { enabled = true, timeout = 3000 }, -- Show notifications for 3 seconds.
    -- Picker: Fuzzy finder and selector.
    picker = {
      enabled = true, -- Enable the picker system.
      sources = {
        files = { hidden = true }, -- Include hidden files.
        gh_issue = {}, -- GitHub issues.
        gh_pr = {}, -- GitHub pull requests.
      },
    },
    -- Quickfile: Quick file operations.
    quickfile = { enabled = true },
    -- Scope: Highlights current scope.
    scope = { enabled = true },
    -- Scroll: Smooth scrolling (disabled).
    scroll = { enabled = false },
    -- Statuscolumn: Enhanced status column.
    statuscolumn = { enabled = true },
    -- Words: Word highlighting and navigation.
    words = { enabled = true },
    -- Styles: UI styling options.
    styles = { notification = {} }, -- Notification styling.
    -- GitHub integration.
    gh = {},
  },
  keys = {
    {
      "<leader>o",
      function()
        Snacks.picker.buffers({
          win = {
            input = {
              keys = { ["dd"] = "bufdelete", ["<c-d>"] = { "bufdelete", mode = { "n", "i" } } },
            },
            list = { keys = { ["dd"] = "bufdelete" } },
          },
        })
      end,
      desc = "Open Buffers",
    },
    {
      "<leader>bs",
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = "Buffer Structure",
    },

    {
      "<leader>z",
      function()
        Snacks.zen()
      end,
      desc = "Zen Mode",
    },
    {
      "<leader>Z",
      function()
        Snacks.zen.zoom()
      end,
      desc = "Zoom",
    },
    {
      "<leader>n",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Notifications",
    },
    -- { "<c-/>", function() Snacks.terminal() end, desc = "Terminal" },
    {
      "<c-_>",
      function()
        Snacks.terminal()
      end,
      desc = "which_key_ignore",
    },
    {
      "]]",
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = "Next Reference",
      mode = { "n", "t" },
    },
    {
      "[[",
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = "Prev Reference",
      mode = { "n", "t" },
    },

    -- <leader>b = Buffers
    {
      "<leader>bb",
      function()
        Snacks.picker.buffers({
          win = {
            input = {
              keys = { ["dd"] = "bufdelete", ["<c-d>"] = { "bufdelete", mode = { "n", "i" } } },
            },
            list = { keys = { ["dd"] = "bufdelete" } },
          },
        })
      end,
      desc = "Switch Buffer",
    },
    {
      "<leader>bd",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete Buffer",
    },
    {
      "<leader>bo",
      function()
        Snacks.bufdelete.other()
      end,
      desc = "Delete Other Buffers",
    },
    {
      "Q",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete Buffer",
    },

    -- <leader>c = Code
    {
      "<leader>cR",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename File",
    },

    -- <leader>d = Diagnostics / Debug
    {
      "<leader>dd",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "Workspace Diagnostics",
    },
    {
      "<leader>dD",
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = "Buffer Diagnostics",
    },
    {
      "<leader>dq",
      function()
        Snacks.picker.qflist()
      end,
      desc = "Quickfix List",
    },
    {
      "<leader>dl",
      function()
        Snacks.picker.loclist()
      end,
      desc = "Location List",
    },
    -- Debug keybindings defined in dap.lua

    -- <leader>f = Find / Files
    {
      "<leader>fw",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep live",
    },

    {
      "<leader>ft",
      function()
        Snacks.picker.grep_word()
      end,
      desc = "Grep Word",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent()
      end,
      desc = "Recent Files",
    },
    {
      "<leader>fc",
      function()
        Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Config Files",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.git_files()
      end,
      desc = "Git Files",
    },
    {
      "<leader>fp",
      function()
        Snacks.picker.projects()
      end,
      desc = "Projects",
    },

    -- <leader>g = Git
    {
      "<leader>gg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>gb",
      function()
        Snacks.picker.git_branches()
      end,
      desc = "Branches",
    },
    {
      "<leader>gl",
      function()
        Snacks.picker.git_log()
      end,
      desc = "Log",
    },
    {
      "<leader>gL",
      function()
        Snacks.picker.git_log_line()
      end,
      desc = "Log (line)",
    },
    {
      "<leader>gf",
      function()
        Snacks.picker.git_log_file()
      end,
      desc = "Log (file)",
    },
    {
      "<leader>gs",
      function()
        Snacks.picker.git_status()
      end,
      desc = "Status",
    },
    {
      "<leader>gS",
      function()
        Snacks.picker.git_stash()
      end,
      desc = "Stash",
    },
    {
      "<leader>gd",
      function()
        Snacks.picker.git_diff()
      end,
      desc = "Diff",
    },
    {
      "<leader>gB",
      function()
        Snacks.gitbrowse()
      end,
      desc = "Browse (GitHub)",
      mode = { "n", "v" },
    },

    -- Hunk operations defined in git.lua

    -- <leader>l = LSP
    {
      "<leader>ls",
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = "Document Symbols",
    },
    {
      "<leader>lS",
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = "Workspace Symbols",
    },
    -- Other LSP keybindings defined in lsp.lua

    -- <leader>s = Search
    {
      "<leader>ss",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>sw",
      function()
        Snacks.picker.grep_word()
      end,
      desc = "Word",
      mode = { "n", "x" },
    },
    {
      "<leader>sb",
      function()
        Snacks.picker.lines()
      end,
      desc = "Buffer Lines",
    },
    {
      "<leader>sB",
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = "Grep Buffers",
    },
    {
      "<leader>sh",
      function()
        Snacks.picker.help()
      end,
      desc = "Help",
    },
    {
      "<leader>sm",
      function()
        Snacks.picker.marks()
      end,
      desc = "Marks",
    },
    {
      "<leader>sj",
      function()
        Snacks.picker.jumps()
      end,
      desc = "Jumps",
    },
    {
      "<leader>sk",
      function()
        Snacks.picker.keymaps({ layout = "select" })
      end,
      desc = "Keymaps",
    },
    {
      "<leader>sc",
      function()
        Snacks.picker.commands()
      end,
      desc = "Commands",
    },
    {
      "<leader>sC",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Command History",
    },
    {
      "<leader>s/",
      function()
        Snacks.picker.search_history()
      end,
      desc = "Search History",
    },
    {
      "<leader>sr",
      function()
        Snacks.picker.registers()
      end,
      desc = "Registers",
    },
    {
      "<leader>sa",
      function()
        Snacks.picker.autocmds()
      end,
      desc = "Autocmds",
    },
    {
      "<leader>sH",
      function()
        Snacks.picker.highlights()
      end,
      desc = "Highlights",
    },
    {
      "<leader>si",
      function()
        Snacks.picker.icons()
      end,
      desc = "Icons",
    },
    {
      "<leader>sM",
      function()
        Snacks.picker.man()
      end,
      desc = "Man Pages",
    },
    {
      "<leader>sp",
      function()
        Snacks.picker.lazy()
      end,
      desc = "Plugins",
    },
    {
      "<leader>sn",
      function()
        Snacks.picker.notifications()
      end,
      desc = "Notifications",
    },
    {
      "<leader>su",
      function()
        Snacks.picker.undo()
      end,
      desc = "Undo History",
    },
    {
      "<leader>sR",
      function()
        Snacks.picker.resume()
      end,
      desc = "Resume Last",
    },
    {
      "<C-s>",
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = "Grep Buffers",
    },

    -- <leader>u = UI / Toggle
    {
      "<leader>uC",
      function()
        Snacks.picker.colorschemes()
      end,
      desc = "Colorschemes",
    },
    {
      "<leader>un",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Dismiss Notifications",
    },

    -- g = Goto (LSP navigation via Snacks picker)
    {
      "gd",
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = "Definition",
    },
    {
      "gD",
      function()
        Snacks.picker.lsp_declarations()
      end,
      desc = "Declaration",
    },
    {
      "gr",
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
      desc = "References",
    },
    {
      "gI",
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = "Implementation",
    },
    {
      "gy",
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = "Type Definition",
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Debug globals
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd

        -- Toggle mappings under <leader>u
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>ur")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.diagnostics():map("<leader>uD")
        Snacks.toggle
          .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle
          .option("background", { off = "light", on = "dark", name = "Dark Background" })
          :map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ui")
        Snacks.toggle.dim():map("<leader>ud")
      end,
    })
  end,
}
