return {
	-- MASON: The core package manager for external binaries
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		opts = {
			ui = { border = "rounded" },
		},
		config = function(_, opts)
			require("mason").setup(opts)
		end,
	},

	-- MASON-LSPCONFIG: Bridges Mason with nvim-lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("core.utils").get_lsp_capabilities()

			local function default_setup(server)
				lspconfig[server].setup({ capabilities = capabilities })
			end

			require("mason-lspconfig").setup({
				handlers = {
					-- The default handler: sets up any server not specifically mentioned below
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
						})
					end,

				-- Markdown: Fixed to attach even in single files without .git
				["marksman"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.marksman.setup({
						capabilities = capabilities,
						root_dir = function(fname)
							-- Looks for project markers, falls back to current directory so it ALWAYS starts
							return lspconfig.util.root_pattern(".git", ".marksman.toml", "README.md")(fname)
								or vim.fs.dirname(fname)
						end,
					})
				end,

				-- Tailwind CSS
				["tailwindcss"] = function()
					lspconfig.tailwindcss.setup({
						capabilities = capabilities,
						root_dir = lspconfig.util.root_pattern(
							"tailwind.config.js",
							"tailwind.config.ts",
							"tailwind.config.cjs",
							"postcss.config.js",
							"package.json",
							".git"
						),
						settings = {
							tailwindCSS = {
								experimental = {
									classRegex = {
										{ "cx\\(([^)]*)\\)", "(className|class)=[\"']([^\"']+)[\"']" },
									},
								},
							},
						},
					})
				end,

				-- ESLint (better IDE features than eslint_d)
				["eslint"] = function()
					lspconfig.eslint.setup({
						capabilities = capabilities,
						on_attach = function(client, bufnr)
							-- Auto-fix on save
							vim.api.nvim_create_autocmd("BufWritePre", {
								buffer = bufnr,
								command = "EslintFixAll",
							})
						end,
					})
				end,

					-- JavaScript / TypeScript / React
					["ts_ls"] = function()
						lspconfig.ts_ls.setup({
							capabilities = capabilities,

							root_dir = lspconfig.util.root_pattern(
								"package.json",
								"tsconfig.json",
								"jsconfig.json",
								".git"
							),

							settings = {
								typescript = {
									inlayHints = {
										includeInlayParameterNameHints = "literal",
										includeInlayFunctionParameterTypeHints = true,
										includeInlayVariableTypeHints = false,
										includeInlayPropertyDeclarationTypeHints = true,
										includeInlayEnumMemberValueHints = true,
									},
								},
								javascript = {
									inlayHints = {
										includeInlayParameterNameHints = "literal",
									},
								},
							},
						})
					end,

					-- Python
					["pyright"] = function()
						require("lspconfig").pyright.setup({
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

					-- C/C++
					["clangd"] = function()
						require("lspconfig").clangd.setup({
							capabilities = capabilities,
							cmd = {
								"clangd",
								"--background-index",
								"--clang-tidy",
								"--header-insertion=iwyu",
								"--completion-style=detailed",
								"--function-arg-placeholders",
								"--fallback-style=llvm",
							},
						})
					end,
					["lua_ls"] = function()
						require("lspconfig").lua_ls.setup({
							settings = {
								Lua = {
									diagnostics = {
										globals = { "vim" },
									},
									completion = {
										callSnippet = "Replace",
									},
									workspace = {
										library = {
											vim.fn.stdpath("config") .. "/lua",
											vim.fn.stdpath("data") .. "/site/pack/lazy/opt/nvim-lspconfig/lua",
											"${3rd}/love2d/library",
										},
									},
									telemetry = {
										enable = false,
									},
								},
							},
						})
					end,
				},
			})
		end,
	},

	-- MASON-TOOL-INSTALLER: Automates installation of all tools
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				-- LSP servers
				"ts_ls",
				"eslint",
				"tailwindcss",
				"pyright",
				"clangd",
				"html",
				"cssls",
				"marksman",
				"lua_ls",

				-- Linters
				"eslint_d",
				"ruff",
				"htmlhint",
				"stylelint",
				"luacheck",
				"markdownlint",

				-- Formatters
				"prettier",
				"black",
				"clang-format",
				"stylua",
				"google-java-format",
			},
		},
		config = function(_, opts)
			require("mason-tool-installer").setup(opts)
		end,
	},
}
