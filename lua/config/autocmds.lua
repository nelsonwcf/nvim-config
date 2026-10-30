-- Briefly highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- 2-space indentation for languages that conventionally use it (default is 4)
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("indent_2", { clear = true }),
  pattern = {
    "lua", "json", "jsonc", "yaml", "toml",
    "html", "css", "javascript", "typescript",
  },
  callback = function()
    vim.bo.shiftwidth = 2   -- width of >> / << and auto-indent
    vim.bo.tabstop = 2      -- width of a tab character / the Tab key
  end,
})
