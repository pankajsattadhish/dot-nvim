return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    lazy = true,
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      local function setup_keymaps(bufnr)
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
        end

        -- Hover & Signature Help (no prefix - quick access).
        map("n", "K", function()
          vim.lsp.buf.hover({ border = "rounded", max_height = 25, max_width = 120 })
        end, "Hover") -- Show documentation for symbol under cursor.
        map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature Help") -- Function parameters.
        map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature Help") -- Same in insert mode.

        -- Navigation (g prefix) - Go to definitions, references, etc.
        map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
        map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
        map("n", "gr", vim.lsp.buf.references, "Find References")
        map("n", "gi", vim.lsp.buf.implementation, "Implementation") -- Go to implementation.
        map("n", "gt", vim.lsp.buf.type_definition, "Type Definition") -- Go to type definition.

        -- Diagnostics Navigation ([ and ] prefix like Vim's quickfix).
        map("n", "[d", function()
          vim.diagnostic.jump({ count = -1 }) -- Jump to previous diagnostic.
        end, "Prev Diagnostic")
        map("n", "]d", function()
          vim.diagnostic.jump({ count = 1 }) -- Jump to next diagnostic.
        end, "Next Diagnostic")

        -- <leader>c = Code Actions (refactor, fix, etc.).
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action") -- Show fixes/refactors.
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol") -- Rename variable/function.

        -- <leader>l = LSP Management.
        map("n", "<leader>li", vim.cmd.LspInfo, "LSP Info")
        map("n", "<leader>lr", vim.cmd.LspRestart, "LSP Restart")
      end

      -- LSP Attach Handler: Runs when an LSP server attaches to a buffer.

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then
            return
          end

          setup_keymaps(bufnr)

          -- Document Highlight: Highlight other occurrences of symbol under cursor.
          if client.server_capabilities.documentHighlightProvider then -- If server supports it.
            local group =
              vim.api.nvim_create_augroup("LspDocumentHighlight_" .. bufnr, { clear = true })
            -- When cursor stays still, highlight references.
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = bufnr,
              group = group,
              callback = vim.lsp.buf.document_highlight,
            })
            -- When cursor moves, clear the highlights.
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = bufnr,
              group = group,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      -- Diagnostic Configuration: How error/warning messages appear.
      vim.diagnostic.config({
        virtual_text = false, -- Don't show inline text (use tiny-inline-diagnostic instead).
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded", source = true, header = "", prefix = "" },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
          },
        },
      })
    end,
  },
}
