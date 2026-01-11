-- =============================================================================
-- LAZY PLUGIN MANAGER CONFIGURATION
-- =============================================================================
-- This file sets up Lazy, the plugin manager for Neovim.
-- Lazy downloads and manages plugins automatically.
-- Plugins add features like syntax highlighting, file trees, etc.
-- Think of Lazy as a store that gets tools for Neovim.

-- =============================================================================
-- LAZY INSTALLATION
-- =============================================================================
-- First, we need to install Lazy itself if it's not already there.
-- Lazypath is where Lazy will be stored (in Neovim's data folder).
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if Lazy is already installed (fs_stat checks if the folder exists).
if not vim.uv.fs_stat(lazypath) then
  -- If not installed, download it using git clone.
  -- Git is like a way to download code from the internet.
  vim.fn.system({
    "git",  -- The git command.
    "clone",  -- Download a repository.
    "--filter=blob:none",  -- Download only the code, not big files.
    "https://github.com/folke/lazy.nvim.git",  -- The Lazy repository URL.
    "--branch=stable",  -- Get the stable version (not experimental).
    lazypath,  -- Save it to this path.
  })
end
-- Add Lazy to Neovim's runtime path so it can be loaded.
vim.opt.rtp:prepend(lazypath)

-- =============================================================================
-- TREE-SITTER-CLI BOOTSTRAP
-- =============================================================================
-- Tree-sitter is a tool for understanding code structure.
-- It needs tree-sitter-cli to work with some languages.
-- If tree-sitter-cli is not installed and we have cargo (Rust tool), install it.
if vim.fn.executable("tree-sitter") == 0 and vim.fn.executable("cargo") == 1 then
  -- Show a message that we're installing.
  vim.notify("Installing tree-sitter-cli via cargo...", vim.log.levels.INFO)
  -- Start a background job to install tree-sitter-cli.
  vim.fn.jobstart({ "cargo", "install", "--locked", "tree-sitter-cli" }, {
    on_exit = function(_, code)  -- When the job finishes...
      if code == 0 then  -- Code 0 means success.
        vim.notify("tree-sitter-cli installed successfully!", vim.log.levels.INFO)
      else  -- Non-zero means error.
        vim.notify("Failed to install tree-sitter-cli", vim.log.levels.WARN)
      end
    end,
  })
end

-- =============================================================================
-- LAZY SETUP
-- =============================================================================
-- Now set up Lazy with our plugins and settings.
require("lazy").setup({ import = "plugins" }, {
  -- =============================================================================
  -- INSTALL SETTINGS
  -- =============================================================================
  -- How Lazy installs plugins.
  install = {
    missing = true,  -- Install plugins that are missing.
    colorscheme = { "habamax" }  -- Use this colorscheme while installing.
  },

  -- =============================================================================
  -- CHECKER SETTINGS
  -- =============================================================================
  -- Check for plugin updates.
  checker = {
    enabled = true,  -- Turn on update checking.
    notify = false,  -- Don't show notifications for updates.
  },

  -- =============================================================================
  -- CHANGE DETECTION
  -- =============================================================================
  -- Detect when config files change and reload.
  change_detection = {
    enabled = true,  -- Watch for changes.
    notify = false,  -- Don't notify when reloading.
  },

  -- =============================================================================
  -- UI SETTINGS
  -- =============================================================================
  -- How the Lazy UI looks.
  ui = {
    -- border = "rounded"  -- Uncomment to make borders rounded (commented out now).
  },

  -- =============================================================================
  -- PERFORMANCE SETTINGS
  -- =============================================================================
  -- Make Neovim faster by disabling unused built-in plugins.
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",      -- File compression (we don't need it).
        "tarPlugin", -- Tar file support.
        "tohtml",    -- Convert to HTML (rarely used).
        "tutor",     -- Built-in tutorial.
        "zipPlugin", -- Zip file support.
      },
    },
  },
})
