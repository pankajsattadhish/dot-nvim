return {
  {
    "mason-org/mason.nvim",
    lazy = false,
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")

      local function default_setup(server_name)
        lspconfig[server_name].setup({ capabilities = capabilities })
      end

      local handlers = {
        default_setup,

        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                  disable = { "inject-field", "undefined-field", "missing-fields" },
                },
                runtime = { version = "LuaJIT" },
                workspace = {
                  library = { vim.env.VIMRUNTIME },
                  checkThirdParty = false,
                },
                telemetry = { enable = false },
              },
            },
          })
        end,
      }

      mason_lspconfig.setup({ handlers = handlers })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = { "mason-org/mason-lspconfig.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- Language Servers
          "lua_ls",
          "gopls",
          "zls",
          "ts_ls",
          "rust-analyzer",
          "bashls",
          "pyright",
          "cssls",
          "html",
          "jsonls",
          "yamlls",
          -- Linters
          "eslint_d",
          "luacheck",
          "golangci-lint",
          "shellcheck",
          "markdownlint",
          "yamllint",
          "jsonlint",
          "htmlhint",
          "stylelint",
          "ruff",
          "mypy",
          -- Formatters
          "stylua",
          "goimports",
          "prettier",
          "black",
          "isort",
          "shfmt",
        },
      })
    end,
  },
}
