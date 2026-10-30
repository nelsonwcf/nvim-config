#!/usr/bin/env bash
# System dependencies for this Neovim config (Debian, including WSL).
# Safe to re-run: each step skips what is already installed.
set -euo pipefail

echo "==> apt packages"
sudo apt update
sudo apt install -y git curl unzip build-essential ripgrep fd-find \
  python3 python3-venv python3-pip nodejs npm

echo "==> fd (Debian installs it as fdfind)"
if ! command -v fd >/dev/null; then
  sudo ln -sf "$(command -v fdfind)" /usr/local/bin/fd
fi

if grep -qi microsoft /proc/version; then
  echo "==> WSL: win32yank for clipboard"
  if ! command -v win32yank.exe >/dev/null; then
    tmp=$(mktemp -d)
    curl -sLo "$tmp/win32yank.zip" \
      https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x64.zip
    unzip -p "$tmp/win32yank.zip" win32yank.exe | sudo tee /usr/local/bin/win32yank.exe >/dev/null
    sudo chmod +x /usr/local/bin/win32yank.exe
    rm -rf "$tmp"
  fi
fi

echo "==> tree-sitter CLI (prebuilt; Debian's is too old for nvim-treesitter)"
if ! command -v tree-sitter >/dev/null; then
  curl -sL https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz \
    | gunzip | sudo tee /usr/local/bin/tree-sitter >/dev/null
  sudo chmod +x /usr/local/bin/tree-sitter
fi

echo "==> Neovim"
if command -v nvim >/dev/null; then
  nvim --version | head -1
else
  echo "!! Neovim not found: build 0.12+ from source (see README)"
fi

echo "Done. Remember the manual steps in README.md."
