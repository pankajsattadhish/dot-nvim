require("mason").setup({
    ui = { border = "rounded" },
    log_level = vim.log.levels.INFO,
})

vim.diagnostic.config({
    virtual_text = true,
    underline = true,
    severity_sort = true,
    update_in_insert = false,
    float = { border = "rounded", max_width = 80 },
    jump = { float = true },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
local has_blink, blink = pcall(require, "blink.cmp")
if has_blink then
    capabilities = blink.get_lsp_capabilities(capabilities)
end

vim.lsp.config("*", { capabilities = capabilities })

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "gopls",
        "rust_analyzer",
        "pyright",
        "ruff",
        "ts_ls",
        "jsonls",
        "yamlls",
        "bashls",
        "clangd",
        "jdtls",
        "html",
        "cssls",
        "eslint",
    },
    automatic_enable = true,
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    desc = "LSP keymaps and inlay hints",
    callback = function(ev)
        local buf = ev.buf
        local function map(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = buf, silent = true, desc = desc })
        end

        map("K", function()
            vim.lsp.buf.hover({ border = "rounded" })
        end, "Hover")

        map("<C-s>", function()
            vim.lsp.buf.signature_help({ border = "rounded" })
        end, "Signature help")

        vim.lsp.inlay_hint.enable(false, { bufnr = buf })
    end,
})
