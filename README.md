# 🚀 Neovim 配置

一个基于 Lua 构建的现代 Neovim 配置，具备 LSP 支持、自动补全、模糊查找和美观的 UI。此配置旨在提供强大的 IDE 般的体验，同时保持 Neovim 的简洁性和速度。

## ✨ 特性

- **LSP 集成**：完整的语言服务器协议支持，包含自动补全、诊断和代码操作
- **模糊查找**：使用 Telescope 进行快速文件导航和搜索
- **Git 集成**：通过 Gitsigns 和 Fugitive 内置 Git 操作
- **自动格式化**：使用 Conform 自动格式化代码
- **语法高亮**：通过 Treesitter 增强语法高亮
- **终端集成**：使用 ToggleTerm 的浮动和分割终端
- **会话管理**：自动会话持久化
- **现代 UI**：美观的状态栏、缓冲区栏和通知
- **GitHub Copilot**：AI 驱动的代码建议

## ⚡️ 依赖要求

- **Neovim** >= 0.11.0
- **Git** >= 2.19.0
- **Node.js** >= 18.0（用于 LSP 服务器）
- 一个 [Nerd Font](https://www.nerdfonts.com/) 字体（推荐：JetBrainsMono Nerd Font）
- **ripgrep**（用于 Telescope 实时搜索）
- **fd**（可选，用于更快的文件查找）

## 📦 安装

1. 备份现有的 Neovim 配置：
```bash
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
```

2. 克隆此仓库：
```bash
git clone <你的仓库地址> ~/.config/nvim
```

3. 启动 Neovim：
```bash
nvim
```

插件管理器（lazy.nvim）将在首次启动时自动安装所有插件。

## 📝 配置结构

```
~/.config/nvim/
├── init.lua                    # 入口点和插件管理器设置
├── lazy-lock.json             # 插件版本锁定文件
├── lua/
│   ├── core/                  # 核心配置
│   │   ├── options.lua        # Neovim 设置
│   │   ├── keymaps.lua        # 键位映射
│   │   └── colors.lua         # 配色方案设置
│   └── plugins/               # 插件配置
│       ├── lsp/               # LSP 配置
│       │   ├── init.lua       # LSP 设置
│       │   ├── servers.lua    # LSP 服务器配置
│       │   └── languages/     # 特定语言配置
│       ├── ui/                # UI 插件
│       │   ├── dashboard.lua  # 启动屏幕
│       │   ├── statusline.lua # 状态栏
│       │   ├── bufferline.lua # 缓冲区标签页
│       │   ├── explorer.lua   # 文件浏览器
│       │   └── notifications.lua # 通知系统
│       ├── telescope.lua      # 模糊查找器
│       ├── git.lua           # Git 集成
│       ├── formatting.lua    # 代码格式化
│       ├── snippets.lua      # 代码片段引擎
│       └── copilot.lua       # GitHub Copilot
├── snippets/                  # 自定义代码片段
└── README.md
```

## 🔌 核心插件

| 插件 | 描述 |
|--------|-------------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | 现代插件管理器 |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP 配置 |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | 自动补全引擎 |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | 模糊查找器 |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | 语法高亮 |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git 装饰 |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | 代码格式化 |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | 状态栏 |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | 缓冲区标签页 |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | 终端集成 |
| [noice.nvim](https://github.com/folke/noice.nvim) | UI 增强 |
| [copilot.vim](https://github.com/github/copilot.vim) | AI 代码建议 |
## ⌨️ 键位映射

**Leader 键**：`<Space>`

### 基本操作

| 按键 | 模式 | 描述 |
|-----|------|-------------|
| `<leader>e` | 普通 | 切换文件浏览器 |
| `<leader>q` | 普通 | 关闭当前窗口 |
| `jk` | 插入 | 退出插入模式 |
| `<Esc>` | 普通 | 清除搜索高亮 |

### 文件导航（Telescope）

| 按键 | 模式 | 描述 |
|-----|------|-------------|
| `<leader>ff` | 普通 | 查找文件 |
| `<leader>fg` | 普通 | 实时搜索（在文件中搜索） |
| `<leader>fb` | 普通 | 查找缓冲区 |
| `<leader>fa` | 普通 | 查找所有文件（包括隐藏文件） |
| `<leader>fr` | 普通 | 最近使用的文件 |
| `<leader>fw` | 普通 | 查找光标下的当前单词 |
| `<leader>fh` | 普通 | 帮助标签 |
| `<leader>fc` | 普通 | 搜索命令 |

### LSP（语言服务器）

| 按键 | 模式 | 描述 |
|-----|------|-------------|
| `gd` | 普通 | 跳转到定义 |
| `gD` | 普通 | 跳转到声明 |
| `gr` | 普通 | 查找引用 |
| `gi` | 普通 | 跳转到实现 |
| `K` | 普通 | 悬浮文档 |
| `<leader>rn` | 普通 | 重命名符号 |
| `<leader>ca` | 普通 | 代码操作 |
| `<leader>F` | 普通 | 格式化代码 |
| `[d` | 普通 | 跳转到上一个诊断 |
| `]d` | 普通 | 跳转到下一个诊断 |
| `<leader>d` | 普通 | 显示行诊断 |

### 文件浏览器

| 按键 | 模式 | 描述 |
|-----|------|-------------|
| `l` / `<CR>` | 普通 | 打开文件或展开文件夹 |
| `h` | 普通 | 关闭文件夹或跳转到父目录 |
| `a` | 普通 | 创建新文件/文件夹 |
| `d` | 普通 | 删除文件/文件夹 |
| `r` | 普通 | 重命名 |
| `c` | 普通 | 复制 |
| `x` | 普通 | 剪切 |
| `p` | 普通 | 粘贴 |
| `v` | 普通 | 在垂直分割中打开 |
| `s` | 普通 | 在水平分割中打开 |
| `t` | 普通 | 在新标签页中打开 |
| `I` | 普通 | 切换隐藏文件 |
| `R` | 普通 | 刷新浏览器 |

### 窗口管理

| 按键 | 模式 | 描述 |
|-----|------|-------------|
| `<C-h>` | 普通 | 移动到左侧窗口 |
| `<C-j>` | 普通 | 移动到下方窗口 |
| `<C-k>` | 普通 | 移动到上方窗口 |
| `<C-l>` | 普通 | 移动到右侧窗口 |
| `<leader>sv` | 普通 | 垂直分割窗口 |
| `<leader>sh` | 普通 | 水平分割窗口 |
| `<leader>se` | 普通 | 平均分配窗口大小 |
| `<leader>sx` | 普通 | 关闭当前分割 |

### 缓冲区管理

| 按键 | 模式 | 描述 |
|-----|------|-------------|
| `<leader>bd` | 普通 | 删除当前缓冲区 |
| `<leader>bn` | 普通 | 下一个缓冲区 |
| `<leader>bp` | 普通 | 上一个缓冲区 |
| `<S-l>` | 普通 | 下一个缓冲区 |
| `<S-h>` | 普通 | 上一个缓冲区 |
| `<leader>ba` | 普通 | 关闭所有缓冲区 |
| `gt` | 普通 | 下一个标签页 |
| `gT` | 普通 | 上一个标签页 |

### Git 集成

| 按键 | 模式 | 描述 |
|-----|------|-------------|
| `<leader>gg` | 普通 | LazyGit |
| `<leader>gs` | 普通 | Git 状态 |
| `<leader>gb` | 普通 | Git 责任归属 |
| `<leader>gd` | 普通 | Git 差异 |
| `<leader>hs` | 普通 | 暂存代码块 |
| `<leader>hr` | 普通 | 重置代码块 |
| `<leader>hu` | 普通 | 撤销暂存代码块 |
| `<leader>hp` | 普通 | 预览代码块 |
| `]c` | 普通 | 下一个 Git 代码块 |
| `[c` | 普通 | 上一个 Git 代码块 |

### 终端

| 按键 | 模式 | 描述 |
|-----|------|-------------|
| `<C-\>` | 普通 | 切换浮动终端 |
| `<leader>tf` | 普通 | 浮动终端 |
| `<leader>th` | 普通 | 水平终端 |
| `<leader>tv` | 普通 | 垂直终端 |
| `<Esc><Esc>` | 终端 | 退出终端模式 |

### 代码编辑

| 按键 | 模式 | 描述 |
|-----|------|-------------|
| `<leader>/` | 普通/可视 | 切换注释 |
| `gcc` | 普通 | 切换行注释 |
| `gbc` | 普通 | 切换块注释 |
| `<C-Space>` | 插入 | 触发补全 |
| `<Tab>` | 插入 | 下一个补全项 / 展开代码片段 |
| `<S-Tab>` | 插入 | 上一个补全项 |

### 移动和导航

| 按键 | 模式 | 描述 |
|-----|------|-------------|
| `s{char}{char}` | 普通 | 跳转到字符对 |
| `S{char}{char}` | 普通 | 向后跳转 |
| `ys{motion}{char}` | 普通 | 添加包围符号 |
| `ds{char}` | 普通 | 删除包围符号 |
| `cs{old}{new}` | 普通 | 更改包围符号 |

### 其他

| 按键 | 模式 | 描述 |
|-----|------|-------------|
| `<leader>l` | 普通 | Lazy 插件管理器 |
| `<leader>m` | 普通 | Mason LSP 安装器 |
| `<leader>ss` | 普通 | 恢复上次会话 |
| `<leader>sl` | 普通 | 为当前工作目录恢复会话 |

**模式说明**：除非另有说明，否则为普通模式

## 🛠️ 自定义

### 添加 LSP 服务器

编辑 `lua/plugins/lsp/servers.lua` 来添加或配置语言服务器：

```lua
return {
  "你的语言服务器",
  -- 添加服务器特定设置
}
```

### 更改主题

编辑 `lua/core/colors.lua` 来更改配色方案。

### 添加插件

在 `lua/plugins/` 中创建新文件或添加到现有插件文件中：

```lua
return {
  "用户名/插件名",
  config = function()
    -- 插件配置
  end,
}
```

## 📚 学习资源

- [Neovim 文档](https://neovim.io/doc/)
- [Lazy.nvim 插件管理器](https://github.com/folke/lazy.nvim)
- [LSP 配置指南](https://github.com/neovim/nvim-lspconfig)
- [Telescope 文档](https://github.com/nvim-telescope/telescope.nvim)

## 🤝 贡献

欢迎提交问题或拉取请求来改进！

## 📄 许可证

MIT 许可证 - 欢迎将此配置作为你自己配置的起点。
