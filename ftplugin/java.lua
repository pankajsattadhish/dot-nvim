local jdtls = require('jdtls')

-- 1. Locate the JDTLS path in Mason
local mason_registry = require("mason-registry")
local jdtls_pkg = mason_registry.get_package("jdtls")
local jdtls_path = jdtls_pkg:get_install_path()
local jdtls_bin = jdtls_path .. "/bin/jdtls"

-- 2. Calculate workspace directory (unique per project)
-- This ensures Neovim remembers your project settings
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace-root/' .. project_name

-- 3. Define the config
local config = {
  cmd = {
    jdtls_bin,
    '-data', workspace_dir,
  },
  root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }),

  -- Here we modify settings specifically for Java
  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' }, -- Use standard decompiler
    },
  },

  -- 4. Attach capabilities (Autocompletion)
  capabilities = require("blink.cmp").get_lsp_capabilities(),

  -- 5. Attach Keymaps
  on_attach = function(client, bufnr)
    -- Enable standard LSP keymaps (gd, K, etc.)
    -- Note: Your core/lsp.lua might handle this, but jdtls is separate, so we ensure it here.
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "Java: " .. desc })
    end

    -- Java Specific Keymaps
    map("n", "<leader>co", jdtls.organize_imports, "Organize Imports")
    map("n", "<leader>ct", jdtls.test_class, "Test Class")
    map("n", "<leader>cm", jdtls.test_nearest_method, "Test Method")
    map("n", "<leader>cev", jdtls.extract_variable, "Extract Variable")
    map("v", "<leader>cem", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], "Extract Method")
  end,
}

-- 6. Start the Server
jdtls.start_or_attach(config)

-- return {
--   "mfussenegger/nvim-jdtls",
--   ft = "java", -- Only load this plugin for Java files
-- }
