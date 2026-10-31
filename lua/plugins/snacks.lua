return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      indent = { enabled = true },    -- vertical indent guides + current scope highlight
      explorer = { enabled = true },  -- file tree; also replaces netrw for `nvim .`
    },
    keys = {
      { "<leader>e", function() Snacks.explorer() end, desc = "File explorer" },
    },
  },
}
