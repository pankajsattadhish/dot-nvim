-- =============================================================================
-- GO FILETYPE SETTINGS
-- =============================================================================
-- Settings and commands specific to Go programming language files.

-- Use 4 spaces for tabs in Go (Go convention).
vim.o.tabstop = 4

-- GoModernize command: Automatically modernizes Go code using gopls.
-- Applies modern Go idioms and best practices.
vim.api.nvim_buf_create_user_command(0, "GoModernize", function()
    local bufnr = vim.api.nvim_get_current_buf() -- Current buffer number.
    local filepath = vim.api.nvim_buf_get_name(bufnr) -- File path of buffer.

    -- Check if buffer has a file (not just unsaved content).
    if filepath == "" then
        vim.notify("Buffer has no file path", vim.log.levels.ERROR)
        return
    end

    -- Save the buffer first to ensure modernize works on the latest content.
    vim.cmd("silent write")

    -- Command to run gopls modernize tool.
    local cmd = {
        "go", "run", -- Run Go program.
        "golang.org/x/tools/gopls/internal/analysis/modernize/cmd/modernize@latest", -- Modernize tool.
        "-fix", -- Apply fixes automatically.
        filepath, -- File to modernize.
    }

    vim.notify("GoModernize: running...", vim.log.levels.INFO) -- Show progress.

    -- Run the command asynchronously.
    vim.system(cmd, { text = true }, function(result)
        vim.schedule(function() -- Schedule UI updates on main thread.
            if result.code == 0 then -- Success (exit code 0).
                -- Reload the buffer to pick up changes.
                vim.cmd("checktime")
                local msg = result.stderr or "" -- Get any message from stderr.
                if msg ~= "" then
                    vim.notify("GoModernize: " .. msg, vim.log.levels.INFO)
                else
                    vim.notify("GoModernize: completed", vim.log.levels.INFO)
                end
            else -- Error (non-zero exit code).
                local err = result.stderr or result.stdout or "Unknown error"
                vim.notify("GoModernize failed: " .. err, vim.log.levels.ERROR)
            end
        end)
    end)
end, { desc = "Run gopls modernize -fix on current buffer" })
