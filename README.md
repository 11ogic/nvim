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
