return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "FzfLua",  -- load when :FzfLua is used...
    keys = {         -- ...or when one of these keys is pressed
      { "<leader>ff", "<cmd>FzfLua files<cr>",           desc = "Find files" },
      { "<leader>fg", "<cmd>FzfLua live_grep<cr>",       desc = "Grep in project" },
      { "<leader>fw", "<cmd>FzfLua grep_cword<cr>",      desc = "Grep word under cursor" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>",         desc = "Open buffers" },
      { "<leader>fr", "<cmd>FzfLua oldfiles<cr>",        desc = "Recent files" },
      { "<leader>f/", "<cmd>FzfLua blines<cr>",          desc = "Search in current buffer" },
      { "<leader>fh", "<cmd>FzfLua helptags<cr>",        desc = "Help pages" },
      { "<leader>fk", "<cmd>FzfLua keymaps<cr>",         desc = "Keymaps" },
      { "<leader>fc", "<cmd>FzfLua command_history<cr>", desc = "Command history" },
      { "<leader>f.", "<cmd>FzfLua resume<cr>",          desc = "Resume last search" },
    },
    opts = {},
  },
}
