## ⚡️ Requirements:
- Neovim >= 0.10.0
- Git
- a [Nerd Font](https://www.nerdfonts.com/)

## 📝 Configuration Structure

```
~/.config/nvim/
├── init.lua              # Entry point
├── lua/
│   ├── core/            # Core configurations
│   │   ├── options.lua  # Basic settings
│   │   └── keymaps.lua  # Key mappings
│   └── plugins/         # Plugin configurations
│       ├── lsp.lua      # LSP settings
│       ├── telescope.lua # Search configuration
│       ├── treesitter.lua # Syntax highlighting
│       └── ui.lua       # UI related
└── README.md
```
## 🎮 Key Mappings

### Basic Operations
| Key | Mode | Description |
|-----|------|-------------|
| `<Space>` | n | Leader key |
| `<leader>e` | n | Toggle file explorer |
| `<leader>q` | n | Close current window |
| `jk` | i | Exit insert mode |

### File Operations
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ff` | n | Find files |
| `<leader>fg` | n | Live grep |
| `<leader>fb` | n | Find buffers |
| `<leader>fa` | n | Find all files (including hidden) |
| `<leader>fr` | n | Recent files |
| `<leader>fw` | n | Find current word |

### LSP Features
| Key | Mode | Description |
|-----|------|-------------|
| `gd` | n | Go to definition |
| `gr` | n | Find references |
| `K` | n | Show hover documentation |
| `<leader>rn` | n | Rename symbol |
| `<leader>ca` | n | Code actions |
| `<leader>F` | n | Format code |

### File Tree Operations
| Key | Mode | Description |
|-----|------|-------------|
| `l` | n | Open file/folder |
| `h` | n | Close folder/go to parent |
| `a` | n | Create file/folder |
| `d` | n | Delete |
| `r` | n | Rename |
| `c` | n | Copy |
| `x` | n | Cut |
| `p` | n | Paste |
| `v` | n | Open in vertical split |
| `s` | n | Open in horizontal split |
| `t` | n | Open in new tab |

### Window Management
| Key | Mode | Description |
|-----|------|-------------|
| `<C-h>` | n | Move to left window |
| `<C-j>` | n | Move to bottom window |
| `<C-k>` | n | Move to top window |
| `<C-l>` | n | Move to right window |
| `<leader>sv` | n | Split window vertically |
| `<leader>sh` | n | Split window horizontally |
| `<leader>se` | n | Equalize window sizes |

### Buffer Management
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>bd` | n | Delete current buffer |
| `<leader>bn` | n | Next buffer |
| `<leader>bp` | n | Previous buffer |
| `gt` | n | Next tab |
| `gT` | n | Previous tab |

### Git Operations
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>gs` | n | Git status |
| `<leader>gb` | n | Git blame |
| `<leader>hs` | n | Stage hunk |
| `<leader>hr` | n | Reset hunk |
| `<leader>hd` | n | View diff |

### Terminal
| Key | Mode | Description |
|-----|------|-------------|
| `<C-\>` | n | Toggle terminal |
| `<leader>tt` | n | Float terminal |
| `<leader>th` | n | Horizontal terminal |
| `<leader>tv` | n | Vertical terminal |

Note: 
- `n` = Normal mode
- `i` = Insert mode
- `v` = Visual mode
- `<leader>` = Space key by default
