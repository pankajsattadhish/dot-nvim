return {
  {
    "nvim-java/nvim-java",
    ft = "java",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      -- 1. Initialize nvim-java first
      require("java").setup()

      -- 2. Define capabilities and apply the fix for the ipairs 'nil' error

      -- Get the base capabilities from your blink.cmp (or similar) setup
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- *** CRITICAL FIX: Disable dynamic registration for common culprits ***
      -- The 'ipairs' bad argument error often occurs during dynamic registration
      -- for workspace or file change capabilities, where the server returns nil
      -- instead of an empty table. Disabling this bypasses the buggy logic path.

      if capabilities.workspace then
        -- Fix 1: didChangeConfiguration is a frequent trigger
        capabilities.workspace.didChangeConfiguration = {
          dynamicRegistration = false,
        }
        -- Fix 2: didChangeWatchedFiles can also trigger this
        capabilities.workspace.didChangeWatchedFiles = {
          dynamicRegistration = false,
        }
      end

      if capabilities.textDocument then
        -- Fix 3: Keeps your existing fix for the semantic tokens issue
        capabilities.textDocument.semanticTokens = {
          dynamicRegistration = false,
        }
      end
      -- *******************************************************************

      -- 3. Configure JDTLS
      vim.lsp.config("jdtls", {
        -- IMPORTANT: Removing 'cmd = { "jdtls" }' so nvim-java's internal function
        -- for starting JDTLS (which your LspInfo showed) is used.
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- Final safety measure: ensure provider is nil in the current session
          client.server_capabilities.semanticTokensProvider = nil

          -- Your Java-specific keymaps
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "Java: " .. desc })
          end
          map("n", "<leader>co", require("jdtls").organize_imports, "Organize Imports")
        end,
      })

      -- 4. Enable the client
      vim.lsp.enable("jdtls")

      -- Note: If the error persists, you must find where 'java_language_server'
      -- (Client ID: 1 from your LspInfo) is being configured and either disable
      -- its setup or apply these same 'capabilities' overrides to its config as well.
      -- The error could be coming from that specific, conflicting server.
    end,
  },
}
