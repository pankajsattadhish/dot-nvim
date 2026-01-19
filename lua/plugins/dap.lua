return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },

    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- UI Setup
      dapui.setup({
        layouts = {
          {
            elements = { "scopes", "breakpoints", "stacks", "watches" },
            size = 40,
            position = "left",
          },
          {
            elements = { "repl", "console" },
            size = 0.25,
            position = "bottom",
          },
        },
      })

      -- Virtual text
      require("nvim-dap-virtual-text").setup({
        commented = true,
      })

      -- Auto open/close dap-ui
      dap.listeners.after.event_initialized["dapui"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui"] = function()
        dapui.close()
      end

      -- Universal Keymaps
      local map = function(key, fn, desc)
        vim.keymap.set("n", key, fn, { desc = desc })
      end

      map("<leader>db", dap.toggle_breakpoint, "Toggle Breakpoint")
      map("<leader>dc", dap.continue, "Continue")
      map("<leader>di", dap.step_into, "Step Into")
      map("<leader>do", dap.step_over, "Step Over")
      map("<leader>dO", dap.step_out, "Step Out")
      map("<leader>dr", dap.repl.toggle, "Toggle REPL")
      map("<leader>du", dapui.toggle, "Toggle DAP UI")
      map("<leader>de", function()
        dapui.eval()
      end, "Evaluate expression")

      -- Adapters -------------------------------------------------------------

      -- Node / JavaScript / TypeScript
      dap.adapters.node2 = {
        type = "executable",
        command = "node",
        args = {
          vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js",
        },
      }

      dap.configurations.javascript = {
        {
          name = "Launch File",
          type = "node2",
          request = "launch",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
      }

      dap.configurations.typescript = dap.configurations.javascript
      dap.configurations.javascriptreact = dap.configurations.javascript
      dap.configurations.typescriptreact = dap.configurations.javascript

      -- Python
      dap.adapters.python = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
        args = { "-m", "debugpy.adapter" },
      }

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch File",
          program = "${file}",
        },
      }

      -- Go
      dap.adapters.delve = {
        type = "server",
        port = "${port}",
        executable = { command = "dlv", args = { "dap", "-l", "127.0.0.1:${port}" } },
      }

      dap.configurations.go = {
        {
          type = "delve",
          name = "Debug File",
          request = "launch",
          program = "${file}",
        },
      }

      -- C / C++
      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = vim.fn.stdpath("data")
          .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
      }

      dap.configurations.cpp = {
        {
          name = "Launch Executable",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input("Executable path: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = false,
        },
      }

      dap.configurations.c = dap.configurations.cpp

      -- Rust (using lldb)
      dap.adapters.lldb = {
        type = "executable",
        command = "/usr/bin/lldb-vscode",
      }

      dap.configurations.rust = {
        {
          name = "Run Rust Binary",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to binary: ", vim.fn.getcwd() .. "/target/debug/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
    end,
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "mason.nvim", "nvim-dap" },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = {
          "python",
          "node2",
          "delve",
          "cppdbg",
          "codelldb",
        },
        automatic_installation = true,
      })
    end,
  },
}
