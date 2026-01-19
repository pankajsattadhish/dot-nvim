-- Minimal, fast, production-safe linting setup using nvim-lint.

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },

  config = function()
    local lint = require("lint")

    ----------------------------------------------------------------------
    -- CONFIGURE LINTERS (EDITOR-SAFE SET ONLY)
    ----------------------------------------------------------------------
    lint.linters_by_ft = {
      go = { "golangcilint" }, -- Fast, all-in-one lint for Go
      python = { "ruff" }, -- Fast lint for Python
      lua = { "luacheck" }, -- Lua best practice linting
      rust = { "clippy" }, -- Rust compiler lints
      javascript = { "eslint_d" }, -- Fast JS lint
      typescript = { "eslint_d" }, -- Fast TS lint
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      sh = { "shellcheck" }, -- Shell scripts
      bash = { "shellcheck" },
      zsh = { "shellcheck" },
    }

    ----------------------------------------------------------------------
    -- LINTER SETTINGS (small fixes for stdin, filenames)
    ----------------------------------------------------------------------
    if lint.linters.eslint_d then
      lint.linters.eslint_d.args = {
        "--format",
        "json",
        "--stdin",
        "--stdin-filename",
        function()
          return vim.api.nvim_buf_get_name(0)
        end,
      }
    end

    if lint.linters.luacheck then
      lint.linters.luacheck.stdin = true
      lint.linters.luacheck.args = {
        "--formatter",
        "plain",
        "--codes",
        "--ranges",
        "--filename",
        function()
          return vim.api.nvim_buf_get_name(0)
        end,
        "-",
      }
    end

    ----------------------------------------------------------------------
    -- HELPERS
    ----------------------------------------------------------------------

    -- Do NOT lint giant files (UI freeze protection)
    local function too_big()
      local name = vim.api.nvim_buf_get_name(0)
      if name == "" then
        return false
      end
      local ok, stats = pcall(vim.loop.fs_stat, name)
      return ok and stats and stats.size > 1024 * 1024 -- 1 MB
    end

    local function should_lint(buf)
      buf = buf or 0
      if vim.b[buf].lint_enabled == false then
        return false
      end
      if vim.bo[buf].buftype ~= "" then
        return false
      end
      if too_big() then
        return false
      end
      local ft = vim.bo[buf].filetype
      return lint.linters_by_ft[ft] ~= nil
    end

    -- Debounce (avoid running linter too many times while typing)
    local timer = nil
    local function debounce(ms, fn)
      if timer then
        vim.fn.timer_stop(timer)
      end
      timer = vim.fn.timer_start(ms, function()
        vim.schedule(fn)
      end)
    end

    ----------------------------------------------------------------------
    -- AUTO LINT EVENTS
    ----------------------------------------------------------------------
    local group = vim.api.nvim_create_augroup("nvim_lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
      group = group,
      callback = function(args)
        if should_lint(args.buf) then
          if args.event == "BufWritePost" then
            lint.try_lint() -- On save: run immediately
          else
            debounce(80, lint.try_lint) -- On enter: light debounce
          end
        end
      end,
    })

    vim.api.nvim_create_autocmd("TextChanged", {
      group = group,
      callback = function(args)
        if should_lint(args.buf) then
          debounce(600, lint.try_lint) -- While typing: heavier debounce
        end
      end,
    })

    ----------------------------------------------------------------------
    -- COMMANDS + KEYMAPS
    ----------------------------------------------------------------------

    -- Toggle linting per buffer
    vim.api.nvim_create_user_command("LintToggle", function()
      local buf = vim.api.nvim_get_current_buf()
      vim.b[buf].lint_enabled = not vim.b[buf].lint_enabled
      vim.notify("Linting " .. (vim.b[buf].lint_enabled ~= false and "enabled" or "disabled"))
    end, { desc = "Toggle linting" })

    -- Manual lint command
    vim.api.nvim_create_user_command("Lint", function()
      if should_lint() then
        lint.try_lint()
        vim.notify("Linting...")
      else
        vim.notify("No linter configured", vim.log.levels.WARN)
      end
    end, { desc = "Run linter" })

    -- Clear diagnostics from nvim-lint
    vim.api.nvim_create_user_command("LintClear", function()
      local ns = lint.get_namespace(vim.bo.filetype)
      vim.diagnostic.reset(ns)
      vim.notify("Lint diagnostics cleared")
    end, { desc = "Clear lint diagnostics" })

    -- Keymaps (c = code, l = lint)
    vim.keymap.set("n", "<leader>cl", "<cmd>Lint<cr>", { desc = "Run Lint" })
    vim.keymap.set("n", "<leader>cL", "<cmd>LintToggle<cr>", { desc = "Toggle Lint" })
    vim.keymap.set("n", "<leader>cC", "<cmd>LintClear<cr>", { desc = "Clear Lint" })
  end,
}
