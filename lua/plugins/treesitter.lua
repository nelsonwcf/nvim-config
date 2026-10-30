return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,          -- this plugin does not support lazy-loading
    build = ":TSUpdate",   -- update parsers whenever the plugin updates
    config = function()
      -- Parsers to install (skipped if already installed)
      require("nvim-treesitter").install({
        "python", "lua", "vim", "vimdoc", "query",
        "bash", "json", "yaml", "toml",
        "markdown", "markdown_inline", "regex",
        "html", "css", "javascript", "typescript",
        "dockerfile", "gitcommit", "diff",
      })

      -- Enable treesitter features for every buffer that has a parser
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
        callback = function(args)
          if pcall(vim.treesitter.start, args.buf) then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            vim.wo.foldmethod = "expr"
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          end
        end,
      })

      -- Open files fully unfolded; fold manually with zc / zo / za
      vim.opt.foldlevelstart = 99
    end,
  },
}
