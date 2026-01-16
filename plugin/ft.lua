-- Treat .env and .envrc files as shell scripts.
-- This gives them proper syntax highlighting and shell-related features.
vim.filetype.add({
  filename = {
    [".env"] = "sh",
    [".envrc"] = "sh",
    ["*.env"] = "sh",
    ["*.envrc"] = "sh",
  }
})
