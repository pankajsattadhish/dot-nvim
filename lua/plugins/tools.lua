return {
  ------------------------------------------------------------
  -- MASON (install LSP/formatters/linters)
  ------------------------------------------------------------
  {
    "mason-org/mason.nvim",
    lazy = false,
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },

  ------------------------------------------------------------
  -- MASON + LSPCONFIG bridge
  ------------------------------------------------------------
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")
      local capabilities = require("core.utils").get_lsp_capabilities()

      -- Basic default handler
      local function default(server)
        lspconfig[server].setup({ capabilities = capabilities })
      end

      mason_lspconfig.setup({
        handlers = {
          default,

          ------------------------------------------------------------
          -- JavaScript / TypeScript / React
          ------------------------------------------------------------
          ["ts_ls"] = function()
            lspconfig.ts_ls.setup({
              capabilities = capabilities,
              settings = {
                typescript = { inlayHints = { includeInlayParameterNameHints = "all" } },
                javascript = { inlayHints = { includeInlayParameterNameHints = "all" } },
              },
            })
          end,

          ------------------------------------------------------------
          -- Python
          ------------------------------------------------------------
          ["pyright"] = function()
            lspconfig.pyright.setup({
              capabilities = capabilities,
              settings = {
                python = {
                  analysis = {
                    typeCheckingMode = "basic",
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                  },
                },
              },
            })
          end,

          ------------------------------------------------------------
          -- C/C++
          ------------------------------------------------------------
          ["clangd"] = function()
            lspconfig.clangd.setup({
              capabilities = capabilities,
              cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=iwyu",
              },
            })
          end,

          ------------------------------------------------------------
          -- HTML / CSS
          ------------------------------------------------------------
          ["html"] = default,
          ["cssls"] = default,

          ------------------------------------------------------------
          -- Java (using nvim-java plugin separately)
          ------------------------------------------------------------
          -- jdtls is NOT installed via mason
          -- nvim-java manages its own JDTLS installation
        },
      })
    end,
  },

  ------------------------------------------------------------
  -- Mason-Tool-Installer (install only needed tools)
  ------------------------------------------------------------
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          ------------------------------------------------------------
          -- LSP servers
          ------------------------------------------------------------
          "ts_ls",
          "pyright",
          "clangd",
          "html",
          "cssls",

          ------------------------------------------------------------
          -- Linters
          ------------------------------------------------------------
          "eslint_d", -- JS/TS/React
          "ruff", -- Python linter (also can format)
          "htmlhint", -- HTML
          "stylelint", -- CSS
          "luacheck", -- for your config

          ------------------------------------------------------------
          -- Formatters
          ------------------------------------------------------------
          "prettier", -- JS/TS/HTML/CSS
          "black", -- Python
          "clang-format", -- C++
          "stylua", -- Lua (config)
        },
      })
    end,
  },
}
