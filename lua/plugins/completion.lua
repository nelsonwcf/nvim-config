return {
  {
    "saghen/blink.cmp",
    version = "1.*",   -- stable v1; release tag downloads the prebuilt Rust fuzzy matcher
    lazy = false,      -- blink lazy-loads internally; loading early lets LSP servers see its capabilities
    dependencies = { "rafamadriz/friendly-snippets" },  -- snippet collection for many languages
    opts = {
      keymap = { preset = "default" },  -- C-y accept, C-n/C-p move, C-space open, C-e close
      appearance = { nerd_font_variant = "normal" },  -- you use the non-Mono Nerd Font
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 300 },  -- docs beside the menu
      },
      signature = { enabled = true },  -- function parameter hints while typing arguments
      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          -- Neovim API completions when editing this config; ranked above everything else
          lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },  -- warn if the Rust matcher is missing
    },
  },
}
