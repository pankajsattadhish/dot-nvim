-- =============================================================================
-- TREE-SITTER PLUGIN CONFIGURATION
-- =============================================================================
-- Tree-sitter is a tool that understands the structure of code.
-- It helps with syntax highlighting, folding, and navigation.
-- This plugin sets it up for many programming languages.

return {
  "nvim-treesitter/nvim-treesitter",  -- The main Tree-sitter plugin.
  build = ":TSUpdate",  -- Command to update the parsers after install.
  lazy = false,  -- Load immediately, not lazy (delayed).
  config = function()
    -- Set up Tree-sitter with a list of languages to support.
    require("nvim-treesitter").setup({
      ensure_install = {  -- Automatically install parsers for these languages.
        "bash",      -- Shell scripts.
        "c",         -- C programming.
        "html",      -- Web pages.
        "javascript", -- JS code.
        "json",      -- Data format.
        "lua",       -- Lua scripts (like this config).
        "luadoc",    -- Lua documentation.
        "luap",      -- Lua patterns.
        "markdown",  -- Text files with formatting.
        "markdown_inline", -- Inline markdown.
        "python",    -- Python code.
        "query",     -- Tree-sitter queries.
        "regex",     -- Regular expressions.
        "tsx",       -- TypeScript React.
        "typescript", -- TypeScript.
        "vue",       -- Vue.js framework.
        "vim",       -- Vim scripts.
        "vimdoc",    -- Vim documentation.
        "yaml",      -- Configuration files.
        "rust",      -- Rust programming.
        "go",        -- Go language.
        "gomod",     -- Go modules.
        "gowork",    -- Go workspaces.
        "gosum",     -- Go sums.
        "terraform", -- Infrastructure as code.
        "proto",     -- Protocol buffers.
        "zig",       -- Zig language.
      },
    })

    -- =============================================================================
    -- ENABLE TREE-SITTER HIGHLIGHTING
    -- =============================================================================
    -- For every file type, try to start Tree-sitter highlighting.
    -- This makes code look colorful and easy to read.
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)  -- Start Tree-sitter safely (pcall prevents errors).
      end,
    })
  end,
}
