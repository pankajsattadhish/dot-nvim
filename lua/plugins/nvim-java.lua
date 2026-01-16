return {
  {
    "nvim-java/nvim-java",
    ft = "java",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      -- 1. Initialize nvim-java first
      require("java").setup()

      -- 2. Configure capabilities to disable problematic dynamic registration
      -- This fixes the 'ipairs' nil error by preventing the dynamic handshake
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      if capabilities.textDocument then
        capabilities.textDocument.semanticTokens = {
          dynamicRegistration = false,
        }
      end

      -- 3. Use Neovim 0.11+ syntax to enable jdtls
      -- This replaces the deprecated require('lspconfig').jdtls.setup()
      vim.lsp.config("jdtls", {
        cmd = { "jdtls" }, -- Managed by nvim-java automatically
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- Final safety: Disable the provider for this session
          client.server_capabilities.semanticTokensProvider = nil

          -- Your keymaps
          vim.keymap.set("n", "<leader>co", require("jdtls").organize_imports, {
            buffer = bufnr,
            desc = "Java: Organize Imports",
          })
        end,
      })

      -- 4. Activate the configuration
      vim.lsp.enable("jdtls")
    end,
  },
}
