return {
  -- Installer for external tools: LSP servers, formatters, linters, debuggers
  {
    "mason-org/mason.nvim",
    opts = {}, -- also puts mason's bin directory on Neovim's PATH
  },

  -- The list of tools mason should keep installed (installs missing ones at startup)
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "ty",                   -- Python LSP / type checker (Rust)
        "ruff",                 -- Python linter + formatter (Rust)
        "lua-language-server",  -- Lua LSP
        "bash-language-server", -- Bash LSP
        "shellcheck",           -- Bash Linter (used by bash-language-server)
        "shfmt",                -- Bash formatter
        "sqruff",               -- SQL linter + formatter + LSP (Rust)
        "stylua",               -- Lua formatter (Rust)
      },
    },
  },

  -- Teaches lua-language-server about Neovim's API (vim.*), for editing this config
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } },
    },
  },

  -- Ready-made server configs; Neovim's built-in client does the rest
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason-org/mason.nvim" },
    config = function()
      vim.diagnostic.config({
        virtual_text = true,  -- show messages at the end of the line
        severity_sort = true, -- errors above warnings
        float = { border = "rounded" },
      })

      vim.lsp.config("rust_analyzer", {
        settings = {
          ["rust-analyzer"] = { check = { command = "clippy" } },
        },
      })

      vim.lsp.enable({ "ty", "ruff", "lua_ls", "rust_analyzer", "bashls", "sqruff" })

      -- Runs each time a server attaches to a buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          -- ruff and ty both offer hover; keep ty's (types + docs)
          if client and client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
          end

          local map = function(keys, fn, desc)
            vim.keymap.set("n", keys, fn, { buffer = args.buf, desc = desc })
          end
          map("gd", vim.lsp.buf.definition, "Go to definition")
          map("<leader>fs", "<cmd>FzfLua lsp_document_symbols<cr>", "Symbols in file")
          map("<leader>fS", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", "Symbols in project")
          map("<leader>fd", "<cmd>FzfLua diagnostics_document<cr>", "Diagnostics in file")
        end,
      })
    end,
  },
}
