-- =============================================================================
-- GIT PLUGINS CONFIGURATION
-- =============================================================================
-- This file sets up plugins for working with Git version control.
-- Git tracks changes in your code like a time machine.
-- These plugins show Git info in Neovim and help with Git commands.

return {
    -- =============================================================================
    -- GITSIGNS PLUGIN
    -- =============================================================================
    -- Gitsigns shows Git changes in the sign column (left side).
    -- Like little marks showing what lines were added, changed, or deleted.
    {
        "lewis6991/gitsigns.nvim",  -- The Gitsigns plugin.
        lazy = true,  -- Load only when needed.
        event = { "BufReadPre", "BufNewFile" },  -- Load when opening files.
        config = function()
            -- Set up Gitsigns with custom signs and options.
            require("gitsigns").setup({
                -- =============================================================================
                -- SIGNS FOR CHANGES
                -- =============================================================================
                -- Symbols to show in the sign column for different Git changes.
                signs = {
                    add = { text = "┃" },        -- Added lines.
                    change = { text = "┃" },     -- Changed lines.
                    delete = { text = "_" },     -- Deleted lines.
                    topdelete = { text = "‾" },  -- Top of deleted block.
                    changedelete = { text = "~" }, -- Changed and deleted.
                    untracked = { text = "┆" },  -- New files not in Git.
                },
                -- =============================================================================
                -- SIGNS FOR STAGED CHANGES
                -- =============================================================================
                -- Symbols for changes that are ready to commit.
                signs_staged = {
                    add = { text = "┃" },
                    change = { text = "┃" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                    untracked = { text = "┆" },
                },
                signcolumn = true,
                numhl = false,
                linehl = false,
                word_diff = false,
                watch_gitdir = { interval = 1000, follow_files = true },
                attach_to_untracked = true,
                current_line_blame = false,
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "eol",
                    delay = 1000,
                    ignore_whitespace = false,
                },
                current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
                sign_priority = 6,
                status_formatter = nil,
                update_debounce = 200,
                max_file_length = 40000,
                preview_config = {
                    border = "rounded",
                    style = "minimal",
                    relative = "cursor",
                    row = 0,
                    col = 1,
                },
                on_attach = function(bufnr)
                    local gs = require("gitsigns")
                    local map = function(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
                    end
                    -- Navigation
                    map("n", "]h", gs.next_hunk, "Next Hunk")
                    map("n", "[h", gs.prev_hunk, "Prev Hunk")
                end,
            })
        end,
        keys = {
            -- All under <leader>g for Git
            { "<leader>gh", function() require("gitsigns").preview_hunk() end, desc = "Preview Hunk" },
            { "<leader>gH", function() require("gitsigns").preview_hunk_inline() end, desc = "Preview Hunk Inline" },
            { "<leader>ga", function() require("gitsigns").stage_hunk() end, desc = "Stage Hunk" },
            { "<leader>gu", function() require("gitsigns").undo_stage_hunk() end, desc = "Undo Stage" },
            { "<leader>gr", function() require("gitsigns").reset_hunk() end, desc = "Reset Hunk" },
            { "<leader>gR", function() require("gitsigns").reset_buffer() end, desc = "Reset Buffer" },
            { "<leader>gx", function() require("gitsigns").blame_line() end, desc = "Blame Line" },
            { "<leader>gD", function() vim.cmd("Gitsigns diffthis HEAD") end, desc = "Diff HEAD" },
        },
    },
    {
        "sindrets/diffview.nvim",
        event = "VeryLazy",
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    },
    -- Git related plugins
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    -- Undo tree
    {
        "mbbill/undotree",
        keys = {
            { "<leader>uU", "<cmd>UndotreeToggle<CR>", desc = "Undo Tree" },
        },
    },
}
