vim.pack.add({
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/rcarriga/nvim-dap-ui",
	"https://github.com/theHamsta/nvim-dap-virtual-text",
	"https://github.com/jay-babu/mason-nvim-dap.nvim",
})

local dap = require("dap")
local dapui = require("dapui")

-- mason-nvim-dap: install debug adapters
require("mason-nvim-dap").setup({
	ensure_installed = { "delve", "codelldb", "js-debug-adapter" },
	automatic_installation = true,
})

-- DAP UI

dapui.setup({
	icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
	mappings = {
		expand = { "l", "<Right>" },
		collapse = { "h", "<Left>" },
	},
	layouts = {
		{
			elements = { "scopes", "breakpoints", "stacks", "watches" },
			size = 40,
			position = "right",
		},
		{
			elements = { "repl", "console" },
			size = 10,
			position = "bottom",
		},
	},
	controls = {
		element = "repl",
		enabled = true,
		icons = {
			pause = "",
			play = "",
			step_into = "",
			step_over = "",
			step_out = "",
			step_back = "",
			run_last = "",
			terminate = "",
		},
	},
})

-- nvim-dap-virtual-text: show variable values inline

require("nvim-dap-virtual-text").setup({
	virt_text_pos = "eol",
	highlight_changed_variables = true,
	show_stop_reason = true,
})

-- Automatically open/close DAP UI on debug session events

dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

-- Adaptér: Go (delve)

dap.adapters.delve = {
	type = "server",
	port = "${port}",
	executable = {
		command = "dlv",
		args = { "dap", "-l", "127.0.0.1:${port}" },
	},
}

dap.configurations.go = {
	{
		type = "delve",
		name = "Debug",
		request = "launch",
		program = "${file}",
	},
	{
		type = "delve",
		name = "Debug Test (package)",
		request = "launch",
		mode = "test",
		program = "${workspaceFolder}",
	},
	{
		type = "delve",
		name = "Debug Test (file)",
		request = "launch",
		mode = "test",
		program = "${file}",
	},
	{
		type = "delve",
		name = "Debug (with args)",
		request = "launch",
		program = "${file}",
		args = function()
			local args = vim.fn.input("Args: ")
			return vim.fn.split(args, " ")
		end,
	},
}

-- Adaptér: C/C++/Rust (codelldb — installed via mason)

dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
		args = { "--port", "${port}" },
	},
}

for _, lang in ipairs({ "c", "cpp", "rust" }) do
	dap.configurations[lang] = {
		{
			type = "codelldb",
			name = "Launch file",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
		},
		{
			type = "codelldb",
			name = "Launch (with args)",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			args = function()
				local args = vim.fn.input("Args: ")
				return vim.fn.split(args, " ")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
		},
		{
			type = "codelldb",
			name = "Attach to process",
			request = "attach",
			pid = function()
				local pid = vim.fn.input("PID: ")
				return tonumber(pid)
			end,
			cwd = "${workspaceFolder}",
		},
	}
end

-- Adaptér: JavaScript / TypeScript (via mason's js-debug-adapter)

dap.adapters["js-debug-adapter"] = {
	type = "server",
	port = "${port}",
	executable = {
		command = "js-debug-adapter",
		args = { "${port}" },
	},
}

for _, lang in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
	dap.configurations[lang] = {
		{
			type = "js-debug-adapter",
			name = "Launch file (node)",
			request = "launch",
			program = "${file}",
			cwd = "${workspaceFolder}",
			runtimeExecutable = "node",
		},
		{
			type = "js-debug-adapter",
			name = "Launch (with args)",
			request = "launch",
			program = "${file}",
			args = function()
				local args = vim.fn.input("Args: ")
				return vim.fn.split(args, " ")
			end,
			cwd = "${workspaceFolder}",
			runtimeExecutable = "node",
		},
		{
			type = "js-debug-adapter",
			name = "Debug Jest (workspace)",
			request = "launch",
			runtimeExecutable = "node",
			runtimeArgs = {
				"--",
				"${workspaceFolder}/node_modules/.bin/jest",
				"--runInBand",
			},
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
		},
	}
end

-- Sign column highlights for breakpoints etc.

vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#db4b4b" })
vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#ebb428" })
vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379" })

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "", numhl = "" })

-- DAP keymaps

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Conditional breakpoint" })
vim.keymap.set("n", "<leader>dl", function()
	dap.set_breakpoint(nil, nil, vim.fn.input("Log message: "))
end, { desc = "Logpoint" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue / start" })
vim.keymap.set("n", "<leader>dso", dap.step_over, { desc = "Step over" })
vim.keymap.set("n", "<leader>dsi", dap.step_into, { desc = "Step into" })
vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step out" })
vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate session" })
vim.keymap.set("n", "<leader>dr", function()
	dap.repl.toggle({ height = 12 })
end, { desc = "Toggle REPL" })
vim.keymap.set("n", "<leader>dui", dapui.toggle, { desc = "Toggle DAP UI" })
vim.keymap.set("n", "<leader>dh", dapui.eval, { desc = "Evaluate (hover)" })
