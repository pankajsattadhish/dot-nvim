-- =============================================================================
-- UTILITY FUNCTIONS
-- =============================================================================
-- This file has helper functions that can be used in other parts of the config.
-- Utilities are like tools that make common tasks easier.
-- M is a table (like a box) that holds all the functions we export.

local M = {}

-- =============================================================================
-- TOGGLE GO TEST FILE
-- =============================================================================
-- This function switches between a Go file and its test file.
-- For example, if you're in main.go, it opens main_test.go, and vice versa.
-- Useful for Go programmers who work with tests a lot.
M.toggle_go_test = function()
    -- Get the full path of the current file.
    local current_file = vim.fn.expand("%:p")
    -- Check if the file ends with '_test.go' (it's a test file).
    if string.match(current_file, "_test.go$") then
        -- If it's a test file, make the non-test version (remove '_test').
        local non_test_file = string.gsub(current_file, "_test.go$", ".go")
        -- Check if the non-test file exists.
        if vim.fn.filereadable(non_test_file) == 1 then
            -- Open the non-test file.
            vim.cmd.edit(non_test_file)
        else
            -- If not found, show a message.
            print("No corresponding non-test file found")
        end
    else
        -- If it's not a test file, make the test version (add '_test').
        local test_file = string.gsub(current_file, ".go$", "_test.go")
        -- Check if the test file exists.
        if vim.fn.filereadable(test_file) == 1 then
            -- Open the test file.
            vim.cmd.edit(test_file)
        else
            -- If not found, show a message.
            print("No corresponding test file found")
        end
    end
end

-- =============================================================================
-- GET HIGHLIGHTED LINE NUMBERS
-- =============================================================================
-- This function gets the line numbers of selected text in visual mode.
-- It formats them like "L80" or "L80-85" and copies to clipboard.
-- Useful for sharing code snippets with line references.
M.get_highlighted_line_numbers = function()
    -- Get the first and last line of the visual selection.
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")

    -- If no selection, show error and stop.
    if start_line == 0 or end_line == 0 then
        print("No visual selection found")
        return
    end

    -- Make sure start is before end (in case you selected backwards).
    if start_line > end_line then
        start_line, end_line = end_line, start_line
    end

    -- Collect all line numbers in a table (list).
    local line_numbers = {}
    for i = start_line, end_line do
        table.insert(line_numbers, i)
    end

    -- Format the result string.
    local result
    if start_line == end_line then
        -- If only one line, like "L80".
        result = string.format("L%d", start_line)
    else
        -- If multiple lines, like "L80-85".
        result = string.format("L%d-%d", start_line, end_line)
    end

    -- Show the result in a message.
    print("Line numbers: " .. result)

    -- Copy the result to the system clipboard.
    vim.fn.setreg("+", result)

    -- Return the list of line numbers.
    return line_numbers
end

-- =============================================================================
-- COPY FILE PATH AND LINE NUMBER
-- =============================================================================
-- This function copies the current file path and line number to the clipboard.
-- If you're in a Git repository, it makes a GitHub web URL.
-- Useful for sharing links to specific lines in code.
M.copyFilePathAndLineNumber = function()
    -- Get the full path of the current file.
    local current_file = vim.fn.expand("%:p")
    -- Get the current line number.
    local current_line = vim.fn.line(".")
    -- Check if we're in a Git repository.
    local is_git_repo = vim.fn.system("git rev-parse --is-inside-work-tree"):match("true")

    if is_git_repo then
        -- Get the repository URL from Git.
        local current_repo = vim.fn.systemlist("git remote get-url origin")[1]
        -- Get the current branch name.
        local current_branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1]

        -- Change the Git URL to a web URL (for GitHub).
        current_repo = current_repo:gsub("git@github.com:", "https://github.com/")
        current_repo = current_repo:gsub("%.git$", "")

        -- Remove the system path up to the repo root, keep relative path.
        local repo_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
        if repo_root then
            current_file = current_file:sub(#repo_root + 2)
        end

        -- Make the full GitHub URL with file, branch, and line.
        local url = string.format("%s/blob/%s/%s#L%s", current_repo, current_branch, current_file, current_line)
        -- Copy to clipboard.
        vim.fn.setreg("+", url)
        -- Show success message.
        print("Copied to clipboard: " .. url)
    else
        -- If not in Git, just copy the file path with line.
        vim.fn.setreg("+", current_file .. "#L" .. current_line)
        print("Copied full path to clipboard: " .. current_file .. "#L" .. current_line)
    end
end

-- =============================================================================
-- RETURN THE MODULE
-- =============================================================================
-- Send back the table M so other files can use these functions.
return M
