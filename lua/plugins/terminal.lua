return {
  {
    "folke/snacks.nvim",
    keys = {
      -- Toggle a terminal split at the bottom; works from normal and terminal mode
      { "<C-/>", function() Snacks.terminal() end, mode = { "n", "t" }, desc = "Toggle terminal" },
      -- Many terminals (incl. Windows Terminal) send Ctrl-/ as Ctrl-_; map both
      { "<C-_>", function() Snacks.terminal() end, mode = { "n", "t" }, desc = "which_key_ignore" },
    },
  },
}
