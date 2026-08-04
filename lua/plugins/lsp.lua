vim.pack.add({
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

require("mason").setup({
	ui = { border = "rounded" },
	log_level = vim.log.levels.INFO,
})

require("mason-tool-installer").setup({
	ensure_installed = {
		"stylua",
		"prettierd",
		"biome",
		"goimports",
		"gofumpt",
		"shfmt",
		"black",
		"ruff",
		"clang-format",
		"google-java-format",
	},
	auto_update = false,
	run_on_start = true,
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
		vim.lsp.inlay_hint.enable(false, { bufnr = ev.buf })
	end,
})
