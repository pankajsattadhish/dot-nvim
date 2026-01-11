-- =============================================================================
-- CUSTOM FILETYPE DETECTIONS
-- =============================================================================
-- Tell Neovim how to recognize file types that aren't detected automatically.
-- This affects syntax highlighting, LSP, and other filetype-specific features.

-- Treat .env and .envrc files as shell scripts.
-- This gives them proper syntax highlighting and shell-related features.
vim.filetype.add({
  filename = { -- Match by exact filename or pattern.
    [".env"] = "sh", -- .env files are shell scripts.
    [".envrc"] = "sh", -- .envrc files are shell scripts.
    ["*.env"] = "sh", -- Any file ending with .env.
    ["*.envrc"] = "sh", -- Any file ending with .envrc.
  }
})
