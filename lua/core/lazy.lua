-- Lazypath is where Lazy will be stored (in Neovim's data folder).
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if Lazy is already installed (fs_stat checks if the folder exists).
if not vim.uv.fs_stat(lazypath) then
  -- If not installed, download it using git clone.
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
-- Add Lazy to Neovim's runtime path so it can be loaded.
vim.opt.rtp:prepend(lazypath)

-- It needs tree-sitter-cli to work with some languages.
-- If tree-sitter-cli is not installed and we have cargo (Rust tool), install it.
if vim.fn.executable("tree-sitter") == 0 and vim.fn.executable("cargo") == 1 then
  vim.notify("Installing tree-sitter-cli via cargo...", vim.log.levels.INFO)
  -- Start a background job to install tree-sitter-cli.
  vim.fn.jobstart({ "cargo", "install", "--locked", "tree-sitter-cli" }, {
    on_exit = function(_, code)
      if code == 0 then
        vim.notify("tree-sitter-cli installed successfully!", vim.log.levels.INFO)
      else
        vim.notify("Failed to install tree-sitter-cli", vim.log.levels.WARN)
      end
    end,
  })
end

-- Now set up Lazy with our plugins and settings.
require("lazy").setup({ import = "plugins" }, {
  -- How Lazy installs plugins.
  install = {
    missing = true,
    colorscheme = { "habamax" }
  },

  -- Check for plugin updates.
  checker = {
    enabled = true,
    notify = false,
  },

  -- Detect when config files change and reload.
  change_detection = {
    enabled = true,
    notify = false,
  },

  -- How the Lazy UI looks.
  ui = {
    border = "rounded"
  },

  -- Make Neovim faster by disabling unused built-in plugins.
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",      -- File compression (we don't need it).
        "tarPlugin", -- Tar file support.
        "tohtml",    -- Convert to HTML (rarely used).
        -- "tutor",     -- Built-in tutorial.
        "zipPlugin", -- Zip file support.
      },
    },
  },
})
