local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, blink = pcall(require, "blink.cmp")
if ok and blink.get_lsp_capabilities then
	capabilities = vim.tbl_deep_extend("force", capabilities, blink.get_lsp_capabilities())
end
M.capabilities = capabilities

require("mason-lspconfig").setup({
	ensure_installed = {
		"ts_ls",
		"lua_ls",
		"pyright",
		"rust_analyzer",
		"bashls",
		"html",
		"cssls",
		"jsonls",
		"yamlls",
		"clangd",
		"gopls",
	},
	automatic_installation = true,
	handlers = {
		function(server)
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
		["clangd"] = function()
			vim.lsp.config("clangd", {
				capabilities = capabilities,
				cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=never" },
			})
		end,
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local buf = args.buf
		local function map(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { buffer = buf, silent = true, desc = desc })
		end
		map("K", function()
			vim.lsp.buf.hover({ border = "rounded", max_height = 30, max_width = 100 })
		end, "Hover")
		map("<C-s>", function()
			vim.lsp.buf.signature_help({ border = "rounded", max_height = 30, max_width = 100 })
		end, "Signature Help")
		-- map("gd", vim.lsp.buf.definition, "Definition")
		-- map("gr", vim.lsp.buf.references, "References")
		-- map("gi", vim.lsp.buf.implementation, "Implementation")
		-- map("<leader>rn", vim.lsp.buf.rename, "Rename")
		-- map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
	end,
})

vim.diagnostic.config({
	virtual_text = true,
	underline = true,
	severity_sort = true,
	update_in_insert = false,
	float = { border = "rounded", max_width = 80 },
})

return M
