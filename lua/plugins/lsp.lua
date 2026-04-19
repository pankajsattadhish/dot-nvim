vim.pack.add({
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
})

require("mason").setup({ ui = { border = "rounded" }, log_level = vim.log.levels.INFO })

local capabilities = vim.lsp.protocol.make_client_capabilities()
local has_blink, blink = pcall(require, "blink.cmp")
if has_blink then
	capabilities = blink.get_lsp_capabilities(capabilities)
end

require("mason-lspconfig").setup({
	automatic_installation = true,
	handlers = {
		function(server)
			vim.lsp.enable(server)
			vim.lsp.config(server, { capabilities = capabilities })
		end,
		["lua_ls"] = function()
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
			})
		end,
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP keymaps and inlay hints",
	callback = function(ev)
		local buf = ev.buf
		local function map(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { buffer = buf, silent = true, desc = desc })
		end

		map("K", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end, "Hover")
		map("<C-k>", function()
			vim.lsp.buf.signature_help({ border = "rounded" })
		end, "Signature help")

		vim.lsp.inlay_hint.enable(false)
	end,
})
