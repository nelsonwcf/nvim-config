# nvim-config

Personal Neovim configuration (Lua, lazy.nvim). Targets Neovim 0.12+ on Debian / WSL.

## New machine

1. Build and install Neovim 0.12+ from source: https://github.com/neovim/neovim/blob/master/BUILD.md
2. Clone this repo:
   ```bash
   git clone git@github.com:nelsonwcf/nvim-config.git ~/.config/nvim
   ```
3. Install system dependencies:
   ```bash
   ~/.config/nvim/bootstrap.sh
   ```
4. Install a Nerd Font in the terminal (on WSL: in Windows, then set it in Windows Terminal):
   https://github.com/ryanoasis/nerd-fonts/releases/latest
5. Start `nvim`. Plugins and tools install automatically on first launch.

## Layout

- `init.lua`: entry point
- `lua/config/`: options, keymaps, autocmds, lazy.nvim bootstrap
- `lua/plugins/`: one file per area; each returns a list of plugin specs
- `lazy-lock.json`: pinned plugin versions (commit it)
- `bootstrap.sh`: system packages and tools outside Neovim
