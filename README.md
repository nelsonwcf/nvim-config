# nvim-config

Personal Neovim configuration (Lua, lazy.nvim). Targets Neovim 0.12+ on Debian 13 / WSL.

## New machine

1. Build and install Neovim 0.12+ from source: https://github.com/neovim/neovim/blob/master/BUILD.md
2. (Rust) Install rustup: https://rustup.rs
3. Clone this repo:
   ```bash
   git clone git@github.com:nelsonwcf/nvim-config.git ~/.config/nvim
   ```
4. Install system dependencies (apt packages, fd link, tree-sitter CLI, win32yank on WSL, Rust components):
   ```bash
   ~/.config/nvim/bootstrap.sh
   ```
5. Windows Terminal (WSL only):
   - Install a Nerd Font (e.g. CaskaydiaCove) from https://github.com/ryanoasis/nerd-fonts/releases/latest
     and set it under **Settings → Profiles → Defaults → Appearance → Font face**.
   - **Settings → Actions**: remove **F11** from *Toggle fullscreen* (Alt+Enter still works), so F11 reaches the debugger.
6. Start `nvim`. Plugins install on first launch; mason installs LSP servers, formatters and debuggers.
   Restart once after `:Mason` shows everything installed.

## External services

- AI: codecompanion talks to vLLM at `http://abraxas.local:8000` (model name `qwen`), configured in
  `lua/plugins/ai.lua`. Tool use needs vLLM started with tool calling enabled.

## Layout

- `init.lua`: entry point
- `lua/config/`: options, keymaps, autocmds, lazy.nvim bootstrap
- `lua/plugins/`: one file per area; each returns a list of plugin specs
- `lazy-lock.json`: pinned plugin versions (commit it)
- `bootstrap.sh`: system packages and tools outside Neovim
- `.stylua.toml`: Lua formatting (2 spaces)

## Keymaps

Leader is `Space`, local leader is `\`. Press `Space` and wait for the which-key menu; `Space f k` searches all keymaps.

### Core
| Key | Action |
|---|---|
| `Esc` | Clear search highlight |
| `Ctrl-h/j/k/l` | Move between windows |
| `J` / `K` (visual) | Move selected lines down / up |
| `<` / `>` (visual) | Indent, keeping the selection |
| `Esc Esc` (terminal) | Leave terminal mode |
| `zc` / `zo` / `za` / `zM` / `zR` | Close / open / toggle fold, fold all, open all |

### Find (`Space f`)
| Key | Action |
|---|---|
| `ff` / `fg` / `fw` | Files / grep project / grep word under cursor |
| `fb` / `fr` / `f/` | Buffers / recent files / search current buffer |
| `fh` / `fk` / `fc` | Help / keymaps / command history |
| `f.` | Resume last search |
| `fs` / `fS` / `fd` | LSP symbols in file / project, diagnostics in file |

### LSP
| Key | Action |
|---|---|
| `K` | Hover (type, docs) |
| `gd` | Go to definition (`Ctrl-o` back) |
| `grn` / `gra` | Rename / code action |
| `grr` / `gri` / `grt` | References / implementation / type definition |
| `gO` | Symbols in file |
| `[d` / `]d` / `Ctrl-w d` | Previous / next / show diagnostic |
| `Ctrl-s` (insert) | Signature help |

### Completion (blink.cmp)
| Key | Action |
|---|---|
| `Ctrl-space` / `Ctrl-e` | Open / close menu |
| `Ctrl-n` / `Ctrl-p` | Next / previous item |
| `Ctrl-y` | Accept |
| `Ctrl-b` / `Ctrl-f` | Scroll docs |
| `Ctrl-k` | Toggle signature |

### Code and toggles
| Key | Action |
|---|---|
| `Space c f` | Format buffer / selection |
| `Space u f` | Toggle format on save |
| `Space u b` | Toggle inline git blame |

### Git (`Space g`)
| Key | Action |
|---|---|
| `]h` / `[h` | Next / previous hunk |
| `gs` / `gr` / `gp` | Stage (toggle) / reset / preview hunk (also on visual selection) |
| `gb` | Blame line |
| `gg` / `gl` | Lazygit / lazygit log |
| `gv` / `gh` / `gH` | Diffview / file history / repo history (`:DiffviewClose`) |
| `gc` / `gC` / `gf` | Commits / file commits / changed files |

### Terminal
| Key | Action |
|---|---|
| `Ctrl-/` | Toggle terminal (`2 Ctrl-/` for a second one) |

### Debug (`Space d`, F-keys)
| Key | Action |
|---|---|
| `F5` / `dc` | Start / continue |
| `F9` / `db` | Toggle breakpoint |
| `dB` | Conditional breakpoint |
| `F10` / `do` | Step over |
| `F11` / `di` | Step into |
| `Shift-F11` / `dO` | Step out |
| `dC` / `dr` | Run to cursor / restart |
| `Shift-F5` / `dq` | Stop |
| `dv` / `dw` | Toggle panels / watch word under cursor |

### Test (`Space t`)
| Key | Action |
|---|---|
| `tt` / `tf` / `ta` / `tl` | Nearest / file / all / last |
| `td` | Debug nearest test |
| `ts` / `to` / `tO` / `tS` | Test tree / output / output panel / stop |
| `]t` / `[t` | Next / previous failed test |

### Run tasks (`Space r`)
| Key | Action |
|---|---|
| `rr` / `rt` / `rs` | Pick project task / task list / run shell command |

### AI (`Space a`)
| Key | Action |
|---|---|
| `aa` / `aA` | Toggle chat / add selection to chat |
| `ai` / `ap` | Inline edit (type instruction) / action palette |
| Chat: `Enter` or `Ctrl-s` | Send (normal mode, below the last `## Me`) |
| Chat: `?` | Chat keys |
| Chat: `#` / `/` / `@` | Variables (`#{buffer}`) / slash commands / tools and tool groups |
| Inline diff: `ga` / `gr` | Accept / reject |
| Tool approval: `g1`-`g4` | Always accept / accept / reject / cancel |
