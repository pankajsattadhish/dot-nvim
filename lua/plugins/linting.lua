-- =============================================================================
-- CODE LINTING
-- =============================================================================
-- Runs linters to check code quality and catch errors.
-- Shows warnings and suggestions inline in the editor.

return {
  -- Nvim-lint: Asynchronous linting engine.
  -- Runs linters and shows results as diagnostics.
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" }, -- Load when opening files.
  config = function()
    local lint = require("lint") -- Main linting module.
    local lint_progress = {} -- Track running linters per buffer.

    -- Custom linter configurations
    local golangcilint = lint.linters.golangcilint
    golangcilint.ignore_exitcode = true
    golangcilint.args = { "run", "--out-format=json", "--issues-exit-code=0" }

    local luacheck = lint.linters.luacheck
    luacheck.args = {
      "--formatter", "plain", "--codes", "--ranges", "--filename",
      function() return vim.api.nvim_buf_get_name(0) end, "-"
    }
    luacheck.stdin = true

    if lint.linters.eslint_d then
      lint.linters.eslint_d.args = {
        "--format", "json", "--stdin", "--stdin-filename",
        function() return vim.api.nvim_buf_get_name(0) end
      }
    end

    -- Which linters to run for each file type.
    -- Multiple linters can be specified per language.
    lint.linters_by_ft = {
      go = { "golangcilint" }, -- Go: comprehensive linter.
      javascript = { "eslint_d" }, -- JS: style and error checking.
      typescript = { "eslint_d" }, -- TS: same as JS.
      javascriptreact = { "eslint_d" }, -- React JS.
      typescriptreact = { "eslint_d" }, -- React TS.
      vue = { "eslint_d" }, -- Vue.js.
      svelte = { "eslint_d" }, -- Svelte.
      html = { "htmlhint" }, -- HTML validation.
      css = { "stylelint" }, -- CSS linting.
      scss = { "stylelint" }, -- SCSS linting.
      less = { "stylelint" }, -- LESS linting.
      lua = { "luacheck" }, -- Lua code quality.
      python = { "ruff", "mypy" }, -- Python: fast linter + type checker.
      sh = { "shellcheck" }, -- Shell script checking.
      bash = { "shellcheck" }, -- Bash scripts.
      zsh = { "shellcheck" }, -- Zsh scripts.
      fish = { "fish" }, -- Fish shell.
      ruby = { "rubocop" }, -- Ruby style guide.
      eruby = { "erb_lint" }, -- ERB templates.
      rust = { "clippy" }, -- Rust lints.
      yaml = { "yamllint" }, -- YAML validation.
      ["yaml.docker-compose"] = { "yamllint" }, -- Docker Compose.
      json = { "jsonlint" }, -- JSON validation.
      jsonc = { "jsonlint" }, -- JSON with comments.
      markdown = { "markdownlint", "vale" }, -- Markdown style + prose.
      dockerfile = { "hadolint" }, -- Dockerfile best practices.
      terraform = { "tflint", "tfsec" }, -- Terraform lint + security.
      tf = { "tflint", "tfsec" }, -- Short form.
      sql = { "sqlfluff" }, -- SQL linting.
      proto = { "buf_lint" }, -- Protocol buffer linting.
      make = { "checkmake" }, -- Makefile checking.
      c = { "cppcheck", "cpplint" }, -- C: static analysis + style.
      cpp = { "cppcheck", "cpplint" }, -- C++: same as C.
    }

    -- Performance optimizations
    local debounce_timer = nil
    local function debounce_lint(ms)
      if debounce_timer then vim.fn.timer_stop(debounce_timer) end
      debounce_timer = vim.fn.timer_start(ms or 250, function()
        vim.schedule(lint.try_lint)
      end)
    end

    local function is_file_too_large()
      local max_size = 1024 * 1024
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(0))
      return ok and stats and stats.size > max_size
    end

    local function should_lint(bufnr)
      bufnr = bufnr or 0
      if vim.bo[bufnr].buftype ~= "" and vim.bo[bufnr].buftype ~= "acwrite" then
        return false
      end
      if is_file_too_large() then return false end
      local linters = lint.linters_by_ft[vim.bo[bufnr].filetype]
      return linters and #linters > 0
    end

    -- Auto-lint configuration: when to run linters automatically.
    local lint_augroup = vim.api.nvim_create_augroup("nvim_lint", { clear = true })

    -- Lint on entering buffer or after saving.
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
      group = lint_augroup,
      callback = function(args)
        if should_lint(args.buf) then
          if args.event == "BufWritePost" then
            lint.try_lint() -- Immediate lint on save.
          else
            debounce_lint(100) -- Debounced lint on enter.
          end
        end
      end,
    })

    -- Lint after text changes (with longer debounce).
    vim.api.nvim_create_autocmd({ "TextChanged" }, {
      group = lint_augroup,
      callback = function(args)
        if should_lint(args.buf) and vim.bo.filetype ~= "TelescopePrompt" then
          debounce_lint(1000) -- 1 second debounce for typing.
        end
      end,
    })

    -- Commands and keybindings
    vim.api.nvim_create_user_command("LintInfo", function()
      local ft = vim.bo.filetype
      local linters = lint.linters_by_ft[ft] or {}
      local running = lint_progress[vim.api.nvim_get_current_buf()] or false

      print(string.format("Filetype: %s", ft))
      print(string.format("Configured linters: %s", #linters > 0 and table.concat(linters, ", ") or "none"))
      print(string.format("Status: %s", running and "running..." or "idle"))

      local installed, missing = {}, {}
      for _, linter in ipairs(linters) do
        local cmd = lint.linters[linter] and lint.linters[linter].cmd
        if cmd then
          if vim.fn.executable(cmd) == 1 then
            table.insert(installed, linter)
          else
            table.insert(missing, linter)
          end
        end
      end
      if #installed > 0 then print(string.format("Installed: %s", table.concat(installed, ", "))) end
      if #missing > 0 then print(string.format("Missing: %s", table.concat(missing, ", "))) end
    end, { desc = "Show linting information" })

    vim.api.nvim_create_user_command("LintToggle", function()
      local bufnr = vim.api.nvim_get_current_buf()
      vim.b[bufnr].lint_enabled = not vim.b[bufnr].lint_enabled
      vim.notify(string.format("Linting %s", vim.b[bufnr].lint_enabled and "enabled" or "disabled"), vim.log.levels.INFO)
    end, { desc = "Toggle linting" })

    vim.keymap.set("n", "<leader>ll", function()
      if should_lint() then
        lint.try_lint()
        vim.notify("Linting...", vim.log.levels.INFO)
      else
        vim.notify("No linters configured", vim.log.levels.WARN)
      end
    end, { desc = "Lint" })

    vim.keymap.set("n", "<leader>lI", "<cmd>LintInfo<cr>", { desc = "Lint Info" })
    vim.keymap.set("n", "<leader>lL", "<cmd>LintToggle<cr>", { desc = "Toggle Lint" })
    vim.keymap.set("n", "<leader>lC", function()
      local ns = require("lint").get_namespace(vim.bo.filetype)
      vim.diagnostic.reset(ns)
      vim.notify("Lint cleared", vim.log.levels.INFO)
    end, { desc = "Clear Lint" })
  end,
}
