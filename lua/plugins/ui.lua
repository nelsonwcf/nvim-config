return {
  -- Colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,      -- load at startup, not on demand
    priority = 1000,   -- load before other plugins so they pick up its colors
    opts = { style = "night" },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  -- Statusline (bottom bar: mode, git branch, diagnostics, file, position)
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",  -- load right after startup finishes
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      vim.opt.showmode = false  -- lualine shows the mode; hide the built-in "-- INSERT --"
    end,
    opts = {
      options = {
        theme = "tokyonight",
        globalstatus = true,  -- one statusline for all splits
      },
    },
  },

  -- Popup showing available keys after pressing a prefix (e.g. <leader>)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = { preset = "modern" },
    keys = {
      {
        "<leader>?",
        function() require("which-key").show({ global = false }) end,
        desc = "Keymaps for this buffer",
      },
    },
  },
}
