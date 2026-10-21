# NeoVIM dotfiles

This is my personal configuration for neovim, using [LazyVim](https://github.com/LazyVim/LazyVim),
as a starting template.

## Install

The same configuration runs on macOS and Linux; platform differences are resolved at
runtime (Java comes from SDKMAN when it is installed, otherwise from `PATH`).

Link the repository into Neovim's config directory and start Neovim. Plugin versions
are pinned in `lazy-lock.json` and installed on first start.

```sh
ln -s "$PWD" ~/.config/nvim
nvim
```

Language servers, formatters and linters are installed by mason on first start, so
Neovim must be able to reach the network once.

## Host prerequisites

Not managed by this repository; install them with the system package manager, and
fall back to Homebrew only for what the package manager does not ship.

- `git`, and Neovim with LuaJIT
- `ripgrep`, `fd` for pickers and search
- `node`/`npm` for prettier, eslint, jest and markdown preview tooling
- `go` to build the cursortab completion server
- a rustup toolchain with the `rust-analyzer` component for Rust support and
  `htmx-lsp` (built from source by mason)
- `wl-clipboard` (Wayland) or `xclip` (X11) for the system clipboard
- a Nerd Font for the icons
