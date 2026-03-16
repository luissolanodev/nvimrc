# nvim config

Personal Neovim configuration built on [LazyVim](https://www.lazyvim.org/).

## Screenshots

![Editor](screenshots/editor.png)
*Editor with Tokyo Night (night) theme and bufferline*

![File Explorer](screenshots/explorer.png)
*Snacks file explorer with Nerd Font icons*

![Completion](screenshots/completion.png)
*blink.cmp completion with LSP suggestions*

> Add screenshots to a `screenshots/` directory at the repo root to populate the images above.

## Installation

### Prerequisites

- Neovim >= 0.9
- Git
- A [Nerd Font](https://www.nerdfonts.com/) (optional, for icons)
- `ripgrep` — required by Telescope for live grep
- `node` / `npm` — required by several LSP servers (e.g. intelephense)

### Install

> **Backup your existing config first:**
> ```sh
> mv ~/.config/nvim ~/.config/nvim.bak
> mv ~/.local/share/nvim ~/.local/share/nvim.bak
> ```

Clone the repo into your Neovim config directory:

```sh
git clone git@github.com:luissolanodev/nvimrc.git ~/.config/nvim
```

Then launch Neovim. [lazy.nvim](https://github.com/folke/lazy.nvim) will bootstrap itself and install all plugins automatically:

```sh
nvim
```

### Nerd Font icons

To enable icons, set the following environment variable in your shell profile:

```sh
export TERM_HAS_NERD_FONT=1
```

## Structure

```
.
├── init.lua                  # Entry point
├── lua/
│   ├── config/
│   │   ├── lazy.lua          # Plugin manager bootstrap & setup
│   │   ├── options.lua       # Editor options
│   │   ├── keymaps.lua       # Custom keybindings
│   │   └── utils.lua         # Utility functions (e.g. Nerd Font detection)
│   └── plugins/              # Plugin specs & overrides
│       ├── lspconfig.lua     # LSP servers (intelephense/PHP)
│       ├── telescope.lua     # Fuzzy finder
│       ├── blink.lua         # Completion engine
│       ├── bufferline.lua    # Buffer tabs
│       ├── claudecode.lua    # Claude Code AI integration
│       ├── snacks_explorer.lua # File explorer
│       ├── tokyonight.lua    # Colorscheme
│       └── flash.lua         # Motion (disabled)
├── stylua.toml               # Lua formatter config
└── lazy-lock.json            # Plugin lockfile
```

## Key Bindings

Leader key is `,`.

### Buffers

| Key | Action |
|-----|--------|
| `<C-j>` | Previous buffer |
| `<C-k>` | Next buffer |
| `<C-x>` | Delete buffer |

### Files & Search

| Key | Action |
|-----|--------|
| `<C-p>` | Find files (project root) |
| `<leader>n` | Open file explorer (root) |

### Claude Code

| Key | Action |
|-----|--------|
| `<leader>ac` | Toggle Claude panel |
| `<leader>af` | Focus Claude |
| `<leader>ar` | Resume session |
| `<leader>aC` | Continue |
| `<leader>am` | Select model |
| `<leader>ab` | Add current buffer |
| `<leader>as` | Send selection / add file |
| `<leader>aa` | Accept diff |
| `<leader>ad` | Deny diff |

## Notable Plugins

| Plugin | Purpose |
|--------|---------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager |
| [LazyVim](https://github.com/LazyVim/LazyVim) | Base distribution |
| [blink.cmp](https://github.com/Saghen/blink.cmp) | Completion |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | LSP/tool installer |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatting |
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | Colorscheme (night) |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Buffer tabs |
| [snacks.nvim](https://github.com/folke/snacks.nvim) | File explorer + utilities |
| [claudecode.nvim](https://github.com/coder/claudecode.nvim) | Claude Code integration |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git decorations |
| [vimtex](https://github.com/lervag/vimtex) | LaTeX support |

## Language Support

- **TypeScript/JavaScript** — via LazyVim TypeScript extra
- **PHP** — intelephense LSP
- **LaTeX** — vimtex + LazyVim TeX extra
- **Lua** — lazydev.nvim for Neovim API completion

## Icon Support

Icons are conditionally enabled based on the `TERM_HAS_NERD_FONT` environment variable:

```sh
export TERM_HAS_NERD_FONT=1  # enable Nerd Font icons
```

Without it, text fallbacks are used throughout the UI.
