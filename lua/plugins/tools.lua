return {
  -- Mason: Package manager for LSP servers, linters, formatters, etc.
  -- Provides :Mason command to install/manage tools.
  {
    "mason-org/mason.nvim",
    lazy = false, -- Load immediately.
    cmd = "Mason", -- Command to open Mason UI.
    config = function()
      require("mason").setup() -- Basic setup with defaults.
    end,
  },
  -- Mason-LSPConfig: Bridges Mason and LSPConfig.
  -- Automatically configures LSP servers installed by Mason.
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = false, -- Load immediately.
    dependencies = { "neovim/nvim-lspconfig" }, -- Requires LSPConfig.
    config = function()
      local mason_lspconfig = require("mason-lspconfig") -- Mason LSP bridge.
      local lspconfig = require("lspconfig") -- LSP configuration.
      local capabilities = require("core.utils").get_lsp_capabilities() -- Enhanced capabilities.

      -- Default setup function for most LSP servers.
      local function default_setup(server_name)
        lspconfig[server_name].setup({ capabilities = capabilities }) -- Basic setup.
      end

      -- Handlers for specific LSP servers that need custom config.
      local handlers = {
        default_setup, -- Use default for most servers.

        -- Custom setup for Lua language server.
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities, -- Enhanced completion features.
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" }, -- Recognize 'vim' global.
                  disable = { "inject-field", "undefined-field", "missing-fields" }, -- Reduce noise.
                },
                runtime = { version = "LuaJIT" }, -- Neovim uses LuaJIT.
                workspace = {
                  library = { vim.env.VIMRUNTIME }, -- Include Neovim runtime.
                  checkThirdParty = false, -- Skip third-party checks.
                },
                telemetry = { enable = false }, -- Disable telemetry.
              },
            },
          })
        end,
      }

      mason_lspconfig.setup({ handlers = handlers }) -- Apply configurations.
    end,
  },
  -- Mason Tool Installer: Auto-installs tools listed below.
  -- Ensures all development tools are available without manual installation.
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false, -- Load immediately to install tools.
    dependencies = { "mason-org/mason-lspconfig.nvim" }, -- Requires Mason.
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = { -- Auto-install these tools.
        --   -- Language Servers (provide autocomplete, go-to-definition, etc.)
          "lua_ls", -- Lua
        --   "gopls", -- Go
        --   "zls", -- Zig
          "ts_ls", -- TypeScript/JavaScript
          "rust-analyzer", -- Rust
          "bashls", -- Bash
          "pyright", -- Python
          "cssls", -- CSS
          "html", -- HTML
        --   "jsonls", -- JSON
        --   "yamlls", -- YAML
          -- "jdtls", -- Java
        --   -- Linters (check code quality and catch errors)
          "eslint_d", -- JavaScript/TypeScript
        --   "luacheck", -- Lua
        --   "golangci-lint", -- Go
        --   "shellcheck", -- Shell scripts
        --   "markdownlint", -- Markdown
        --   "yamllint", -- YAML
        --   "jsonlint", -- JSON
        --   "htmlhint", -- HTML
        --   "stylelint", -- CSS/SCSS
        --   "ruff", -- Python (fast)
        --   "mypy", -- Python type checking
        --   -- Formatters (auto-format code)
        --   "stylua", -- Lua
        --   "goimports", -- Go (imports + format)
        --   "prettier", -- Web languages
        --   "black", -- Python
        --   "isort", -- Python imports
        --   "shfmt", -- Shell scripts
        },
      })
    end,
  },
}
