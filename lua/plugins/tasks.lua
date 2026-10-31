return {
  {
    "stevearc/overseer.nvim",
    cmd = { "OverseerRun", "OverseerToggle", "OverseerShell" },
    keys = {
      { "<leader>rr", "<cmd>OverseerRun<cr>", desc = "Run task (pick from project)" },
      { "<leader>rt", "<cmd>OverseerToggle<cr>", desc = "Toggle task list" },
      { "<leader>rs", "<cmd>OverseerShell<cr>", desc = "Run shell command as task" },
    },
    opts = {},
  },
}
