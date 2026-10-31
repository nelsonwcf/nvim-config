return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",            -- async library neotest is built on
      "nvim-lua/plenary.nvim",            -- utility library
      "nvim-treesitter/nvim-treesitter",  -- finds test functions in the file
      "nvim-neotest/neotest-python",      -- pytest / unittest adapter
    },
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end, desc = "Run nearest test" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run tests in file" },
      { "<leader>ta", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run all tests" },
      { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Re-run last" },
      { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug nearest test" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle test tree" },
      {
        "<leader>to",
        function() require("neotest").output.open({ enter = true, auto_close = true }) end,
        desc = "Output of nearest test",
      },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
      { "]t", function() require("neotest").jump.next({ status = "failed" }) end, desc = "Next failed test" },
      { "[t", function() require("neotest").jump.prev({ status = "failed" }) end, desc = "Previous failed test" },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            runner = "pytest",
            dap = { justMyCode = false },  -- when debugging, allow stepping into library code
          }),
        },
      })
    end,
  },
}
