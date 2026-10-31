return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "igorlfs/nvim-dap-view",
      "theHamsta/nvim-dap-virtual-text",
      "mfussenegger/nvim-dap-python",
    },
    keys = {
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "Debug: start / continue",
      },
      {
        "<F9>",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Debug: toggle breakpoint",
      },
      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
        desc = "Debug: step over",
      },
      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
        desc = "Debug: step into",
      },
      {
        "<S-F11>",
        function()
          require("dap").step_out()
        end,
        desc = "Debug: step out",
      },
      {
        "<F23>",
        function()
          require("dap").step_out()
        end,
        desc = "which_key_ignore",
      },
      {
        "<S-F5>",
        function()
          require("dap").terminate()
        end,
        desc = "Debug: stop",
      },
      {
        "<F17>",
        function()
          require("dap").terminate()
        end,
        desc = "which_key_ignore",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Start / continue",
      },
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle breakpoint",
      },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Condition: "))
        end,
        desc = "Conditional breakpoint",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Step over",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step into",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "Step out",
      },
      {
        "<leader>dC",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "Run to cursor",
      },
      {
        "<leader>dr",
        function()
          require("dap").restart()
        end,
        desc = "Restart",
      },
      {
        "<leader>dq",
        function()
          require("dap").terminate()
        end,
        desc = "Stop",
      },
      {
        "<leader>dv",
        function()
          require("dap-view").toggle()
        end,
        desc = "Toggle debug panels",
      },
      {
        "<leader>dw",
        function()
          require("dap-view").add_expr()
        end,
        desc = "Watch word under cursor",
      },
    },
    config = function()
      local dap = require("dap")

      require("nvim-dap-virtual-text").setup({})

      -- Use mason's debugpy; the debugged program still runs with the project's venv
      require("dap-python").setup(
        vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      )

      -- Rust: codelldb (mason puts it on PATH; talks DAP over stdio)
      dap.adapters.codelldb = {
        type = "executable",
        command = "codelldb",
      }

      dap.configurations.rust = {
        {
          name = "Build and debug",
          type = "codelldb",
          request = "launch",
          program = function()
            -- Build first so the debugger runs the current code
            local out = vim.fn.system({ "cargo", "build" })
            if vim.v.shell_error ~= 0 then
              vim.notify(out, vim.log.levels.ERROR)
              return dap.ABORT
            end
            -- Guess the binary name from the folder name; editable at the prompt
            local cwd = vim.fn.getcwd()
            return vim.fn.input(
              "Executable: ",
              cwd .. "/target/debug/" .. vim.fn.fnamemodify(cwd, ":t"),
              "file"
            )
          end,
          cwd = "${workspaceFolder}",
          sourceLanguages = { "rust" }, -- readable display of Vec, String, Option, etc.
          stopOnEntry = false,
        },
      }

      -- Open the panels when a session starts, close them when it ends
      local view = require("dap-view")
      dap.listeners.before.attach["dap-view"] = function()
        view.open()
      end
      dap.listeners.before.launch["dap-view"] = function()
        view.open()
      end
      dap.listeners.before.event_terminated["dap-view"] = function()
        view.close()
      end
      dap.listeners.before.event_exited["dap-view"] = function()
        view.close()
      end

      -- Sign column markers
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
      vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticOk", linehl = "Visual" })
    end,
  },
}
