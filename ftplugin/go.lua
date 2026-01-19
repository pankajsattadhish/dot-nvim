vim.opt_local.expandtab = false
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4

-- GoModernize: Run gopls modernize -fix on current file
vim.api.nvim_buf_create_user_command(0, "GoModernize", function()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    vim.notify("No file name", vim.log.levels.ERROR)
    return
  end

  vim.cmd("silent write")

  vim.notify("GoModernize: running...", vim.log.levels.INFO)

  vim.system({
    "go",
    "run",
    "golang.org/x/tools/gopls/internal/analysis/modernize/cmd/modernize@latest",
    "-fix",
    file,
  }, { text = true }, function(res)
    vim.schedule(function()
      if res.code == 0 then
        vim.cmd("checktime")
        vim.notify("GoModernize: completed", vim.log.levels.INFO)
      else
        vim.notify(res.stderr or "GoModernize failed", vim.log.levels.ERROR)
      end
    end)
  end)
end, { desc = "Modernize Go code using gopls" })
