-- =============================================================================
-- CORE CONFIGURATION LOADER
-- =============================================================================
-- This file loads all the core modules that set up Neovim's basic behavior.
-- It's like importing the essential building blocks of your editor setup.

-- Load options: Global settings like indentation, search, UI, etc.
require("core.options")

-- Load keymaps: Custom keybindings for navigation, editing, and commands.
require("core.keymaps")

-- Load autocmds: Automatic commands that run on events like file open/close.
require("core.autocmds")

-- Load lazy: Plugin manager setup and plugin loading.
require("core.lazy")
