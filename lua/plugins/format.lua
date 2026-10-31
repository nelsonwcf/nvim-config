return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",  -- load just before the first save
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>cf",
        function() require("conform").format({ async = true }) end,
        mode = { "n", "v" },
        desc = "Format buffer / selection",
      },
      {
        "<leader>uf",
        function()
          vim.g.disable_autoformat = not vim.g.disable_autoformat
          vim.notify("Format on save: " .. (vim.g.disable_autoformat and "off" or "on"))
        end,
        desc = "Toggle format on save",
      },
    },
    opts = {
      formatters_by_ft = {
        python = { "ruff_organize_imports", "ruff_format" },  -- run in order
        lua = { "stylua" },
        rust = { "rustfmt" },
        sh = { "shfmt" },
        bash = { "shfmt" },
      },
      formatters = {
        shfmt = { prepend_args = { "-i", "4" } },  -- 4-space indent instead of tabs
      },
      -- No formatter listed (e.g. SQL)? Use the language server's formatting instead
      default_format_opts = { lsp_format = "fallback" },
      format_on_save = function()
        if vim.g.disable_autoformat then return end
        return { timeout_ms = 1000 }
      end,
    },
  },
}
