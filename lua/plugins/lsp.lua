-- =============================================================================
-- LANGUAGE SERVER PROTOCOL (LSP) CONFIGURATION
-- =============================================================================
-- LSP provides smart code features: autocomplete, go-to-definition, errors, etc.
-- This file sets up LSP servers and their keybindings.

return {
  -- Nvim-LSPConfig: Main plugin for configuring LSP servers in Neovim.
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" }, -- Load when opening files.
    dependencies = {
      "mason-org/mason-lspconfig.nvim", -- Bridges Mason (installer) and LSPConfig.
    },
    config = function()

       -- Function to set up LSP keybindings for a specific buffer.
       local function setup_keymaps(bufnr)
         -- Helper function to create keymaps with common options.
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
         -- Note: gd, gD, gr, gI, gy are handled by Snacks plugin instead.
         map("n", "gi", vim.lsp.buf.implementation, "Implementation") -- Go to implementation.
         map("n", "gt", vim.lsp.buf.type_definition, "Type Definition") -- Go to type definition.
         -- Open definition in vertical split.
         map(
           "n",
           "<leader>v",
           "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>",
           "Definition in Split"
         )

         -- Diagnostics Navigation ([ and ] prefix like Vim's quickfix).
         map("n", "[d", function()
           vim.diagnostic.jump({ count = -1 }) -- Jump to previous diagnostic.
         end, "Prev Diagnostic")
         map("n", "]d", function()
           vim.diagnostic.jump({ count = 1 }) -- Jump to next diagnostic.
         end, "Next Diagnostic")

         -- <leader>c = Code Actions (refactor, fix, etc.).
         map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action") -- Show fixes/refactors.
         map("n", "<leader>cr", vim.lsp.buf.rename, "Rename Symbol") -- Rename variable/function.
         map("n", "<leader>cd", vim.diagnostic.open_float, "Line Diagnostic") -- Show error details.
         -- <leader>cf (format) is handled by conform.lua plugin.

         -- <leader>l = LSP Management.
         map("n", "<leader>li", "<cmd>LspInfo<cr>", "LSP Info") -- Show LSP server status.
         map("n", "<leader>lr", "<cmd>LspRestart<cr>", "LSP Restart") -- Restart LSP server.
         map("n", "<leader>lh", function()
           vim.lsp.inlay_hint.enable( -- Toggle inlay hints (inline type info).
             not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
             { bufnr = bufnr }
           )
         end, "Toggle Inlay Hints")
       end

       -- LSP Attach Handler: Runs when an LSP server attaches to a buffer.
       -- Sets up keymaps and features for that buffer.

       vim.api.nvim_create_autocmd("LspAttach", {
         group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }), -- Unique group name.
         callback = function(args)
           local bufnr = args.buf -- Buffer number where LSP attached.
           local client = vim.lsp.get_client_by_id(args.data.client_id) -- The LSP client.
           if not client then
             return -- Safety check.
           end

           setup_keymaps(bufnr) -- Set up the keybindings for this buffer.
           vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc" -- Enable LSP completion for Ctrl+X Ctrl+O.

           -- Document Highlight: Highlight other occurrences of symbol under cursor.
           if client.server_capabilities.documentHighlightProvider then -- If server supports it.
             local group = -- Create unique group for this buffer's highlights.
               vim.api.nvim_create_augroup("LspDocumentHighlight_" .. bufnr, { clear = true })
             -- When cursor stays still, highlight references.
             vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
               buffer = bufnr,
               group = group,
               callback = vim.lsp.buf.document_highlight, -- Highlight references.
             })
             -- When cursor moves, clear the highlights.
             vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
               buffer = bufnr,
               group = group,
               callback = vim.lsp.buf.clear_references, -- Clear highlights.
             })
           end
         end,
       })

       -- Diagnostic Configuration: How error/warning messages appear.
       vim.diagnostic.config({
         virtual_text = false, -- Don't show inline text (use tiny-inline-diagnostic instead).
         underline = true, -- Underline problematic code.
         update_in_insert = false, -- Don't update diagnostics while typing.
         severity_sort = true, -- Sort by severity (errors first).
         float = { border = "rounded", source = true, header = "", prefix = "" }, -- Floating window style.
         signs = { -- Icons in the sign column (left side).
           text = {
             [vim.diagnostic.severity.ERROR] = "󰅚 ", -- Error icon.
             [vim.diagnostic.severity.WARN] = "󰀪 ", -- Warning icon.
             [vim.diagnostic.severity.INFO] = "󰋽 ", -- Info icon.
             [vim.diagnostic.severity.HINT] = "󰌶 ", -- Hint icon.
           },
           numhl = { -- Highlighting for line numbers.
             [vim.diagnostic.severity.ERROR] = "ErrorMsg", -- Error color.
             [vim.diagnostic.severity.WARN] = "WarningMsg", -- Warning color.
           },
         },
       })
    end,
  },
}
