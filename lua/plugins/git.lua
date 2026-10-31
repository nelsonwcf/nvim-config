return {
  -- Change markers in the sign column + hunk actions
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function(buf)
        local gs = require("gitsigns")
        local map = function(mode, keys, fn, desc)
          vim.keymap.set(mode, keys, fn, { buffer = buf, desc = desc })
        end
        map("n", "]h", function() gs.nav_hunk("next") end, "Next hunk")
        map("n", "[h", function() gs.nav_hunk("prev") end, "Previous hunk")
        map("n", "<leader>gs", gs.stage_hunk, "Stage / unstage hunk")
        map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
        map("v", "<leader>gs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage selection")
        map("v", "<leader>gr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset selection")
        map("n", "<leader>gp", gs.preview_hunk_inline, "Preview hunk")
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line")
        map("n", "<leader>tb", gs.toggle_current_line_blame, "Toggle inline blame")
      end,
    },
  },

  -- lazygit in a floating window (snacks themes it to match the colorscheme)
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit log" },
    },
  },

  -- Side-by-side diffs and history
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Diff view (uncommitted changes)" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "History of this file" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "History of repo" },
    },
    opts = {},
  },

  -- Git pickers
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>gc", "<cmd>FzfLua git_commits<cr>", desc = "Commits (repo)" },
      { "<leader>gC", "<cmd>FzfLua git_bcommits<cr>", desc = "Commits (this file)" },
      { "<leader>gf", "<cmd>FzfLua git_status<cr>", desc = "Changed files" },
    },
  },
}
