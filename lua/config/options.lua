-- Leader must be set before lazy.nvim loads plugins
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

-- Line numbers: absolute on current line, relative elsewhere
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"      -- always show the column for git/diagnostic signs, so text doesn't shift
opt.cursorline = true       -- highlight the current line

-- Indentation: 4 spaces (Python standard); per-language overrides come later
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true        -- insert spaces, not tab characters

-- Search
opt.ignorecase = true       -- case-insensitive search...
opt.smartcase = true        -- ...unless the pattern has an uppercase letter
opt.inccommand = "split"    -- live preview of :s substitutions

-- Display
opt.wrap = false
opt.scrolloff = 8           -- keep 8 lines visible above/below the cursor
opt.sidescrolloff = 8
opt.list = true             -- show invisible characters below
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Splits open right / below instead of left / above
opt.splitright = true
opt.splitbelow = true

-- Behavior
opt.undofile = true         -- undo history survives closing the file
opt.confirm = true          -- ask to save instead of failing on :q with unsaved changes
opt.updatetime = 250        -- faster CursorHold events (used by git signs, diagnostics)
opt.timeoutlen = 300        -- ms to wait for the next key in a mapping sequence

-- Clipboard: y/p/d use the Windows clipboard (via win32yank.exe on WSL)
opt.clipboard = "unnamedplus"

-- Disable remote-plugin providers (none of the plugins need them)
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
