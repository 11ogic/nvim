# 🚀 Neovim 配置

个人 Neovim 配置，基于 Lua 构建，专注于现代化开发体验和高效的编码工作流。

## ⚡️ 系统要求

- **Neovim** >= 0.11.0
- **Git** >= 2.19.0
- **Node.js** >= 22.0 (用于 LSP 服务器)
- [Nerd Font](https://www.nerdfonts.com/) (推荐使用 JetBrains Mono Nerd Font)
- **可选依赖**:
  - `ripgrep` - 用于 Telescope 文件搜索
  - `fd` - 更快的文件查找
  - `lazygit` - Git TUI 工具

## 安装

```bash
# 备份现有配置
mv ~/.config/nvim ~/.config/nvim.backup

# 克隆配置
git clone https://github.com/11ogic/nvim ~/.config/nvim

# 启动 Neovim (插件会自动安装)
nvim
```

首次启动时，[lazy.nvim](https://github.com/folke/lazy.nvim) 会自动安装并下载所有插件。

## 📁 目录结构

```
~/.config/nvim/
├── init.lua                    # 配置入口点
├── lazy-lock.json              # 插件版本锁定文件
├── lua/
│   ├── core/                   # 核心配置
│   │   ├── colors.lua          # 颜色定义
│   │   ├── keymaps.lua         # 键位映射
│   │   └── options.lua         # 基础选项设置
│   └── plugins/                # 插件配置
│       ├── colorscheme.lua     # 主题配置 (基于Ayu)
│       ├── copilot.lua         # GitHub Copilot
│       ├── formatting.lua      # 代码格式化 (Conform)
│       ├── fun.lua             # 娱乐插件
│       ├── git.lua             # Git 集成
│       ├── snippets.lua        # 代码片段
│       ├── telescope.lua       # 模糊查找
│       ├── treesitter.lua      # 语法高亮
│       ├── ui.lua              # UI 增强
│       ├── utils.lua           # 实用工具
│       ├── lsp/                # LSP 配置
│       │   ├── init.lua        # LSP 入口
│       │   ├── cmp.lua         # 自动补全
│       │   ├── mason.lua       # LSP 服务器管理
│       │   ├── servers.lua     # 服务器配置
│       │   ├── utils.lua       # LSP 工具
│       │   └── languages/      # 语言特定配置
│       │       ├── basic.lua
│       │       ├── go.lua
│       │       ├── javascript.lua
│       │       ├── lua.lua
│       │       ├── python.lua
│       │       └── vue.lua
│       └── ui/                 # UI 组件
│           ├── bufferline.lua  # 标签页栏
│           ├── dashboard.lua   # 启动页面
│           ├── enhancements.lua# UI 增强
│           ├── explorer.lua    # 文件浏览器
│           ├── notifications.lua# 通知系统
│           └── statusline.lua  # 状态栏
├── snippets/                   # 自定义代码片段
│   ├── all.lua
│   ├── javascript.lua
│   ├── lua.lua
│   ├── typescript.lua
│   └── vue.lua
└── pack/github/start/copilot.vim/
```

## � 特性

### 核心功能
- 🎯 **LSP 集成** - 完整的语言服务器支持 (通过 Mason)
- 🔍 **Telescope** - 强大的模糊查找和搜索
- 🌳 **Treesitter** - 现代化语法高亮和代码理解
- 📝 **智能补全** - nvim-cmp + LuaSnip
- 🤖 **GitHub Copilot** - AI 代码助手
- 🎨 **Ayu 主题** - 优雅的深色配色方案
- 📊 **美观 UI** - Lualine、Bufferline、Noice
- 🔧 **代码格式化** - Conform.nvim 统一格式化
- 🌿 **Git 集成** - Gitsigns、Fugitive、LazyGit

### 支持的语言
- JavaScript/TypeScript
- Vue.js
- Python
- Go
- Lua
- HTML/CSS
- JSON/YAML
- Markdown
- 以及更多 (通过 Mason 安装 LSP)

## ⌨️ 键位映射

> **Leader 键**: `Space`

### 基础操作

| 按键 | 模式 | 功能 |
|------|------|------|
| `jk` | i | 退出插入模式 |
| `<leader>w` | n | 保存文件 |
| `<C-s>` | n/i | 保存文件 |
| `<leader>nh` | n | 清除搜索高亮 |
| `J` / `K` | v | 上下移动选中文本 |
| `<` / `>` | v | 保持选择的同时缩进 |

### 文件浏览器 (nvim-tree)

| 按键 | 模式 | 功能 |
|------|------|------|
| `<leader>o` | n | 切换文件浏览器 |
| `l` / `<CR>` | n | 打开文件/文件夹 |
| `h` | n | 关闭文件夹/返回上级 |
| `a` | n | 创建文件/文件夹 |
| `d` | n | 删除 |
| `r` | n | 重命名 |
| `c` / `x` / `p` | n | 复制/剪切/粘贴 |
| `v` / `s` / `t` | n | 垂直分割/水平分割/新标签页打开 |
| `H` | n | 切换隐藏文件 |
| `I` | n | 切换 Git 忽略文件 |

### 搜索与查找 (Telescope)

| 按键 | 模式 | 功能 |
|------|------|------|
| `<leader><space>` | n | 查找文件 |
| `<leader>fg` | n | 全局搜索 (live grep) |
| `<leader>fb` | n | 查找缓冲区 |
| `<leader>fh` | n | 查找帮助文档 |
| `<leader>fa` | n | 查找所有文件 (含隐藏) |
| `<leader>fw` | n | 查找当前光标下单词 |
| `<leader>fr` | n | 查找最近文件 |
| `<leader>no` | n | 查看通知历史 |

### LSP 功能

| 按键 | 模式 | 功能 |
|------|------|------|
| `gd` | n | 跳转到定义 |
| `gr` | n | 查找引用 |
| `gD` | n | 跳转到声明 |
| `gi` | n | 跳转到实现 |
| `K` | n | 显示悬停文档 |
| `<C-k>` | n | 显示签名帮助 |
| `<leader>rn` | n | 重命名符号 |
| `<leader>ca` | n | 代码操作 |
| `<leader>F` | n | 格式化代码 |
| `<C-l>` | n | 格式化代码 (Conform) |
| `<leader>e` | n | 显示诊断浮窗 |
| `[d` / `]d` | n | 上一个/下一个诊断 |
| `<leader>de` | n | 当前文件诊断列表 |
| `<leader>dw` | n | 工作区诊断列表 |

### 窗口管理

| 按键 | 模式 | 功能 |
|------|------|------|
| `<leader>sv` | n | 垂直分割窗口 |
| `<leader>sh` | n | 水平分割窗口 |
| `<leader>se` | n | 等分窗口大小 |
| `<leader>x` | n | 关闭当前窗口 |
| `<leader>Q` | n | 关闭所有窗口 |
| `<leader>W` | n | 保存所有文件 |

### 缓冲区管理

| 按键 | 模式 | 功能 |
|------|------|------|
| `<leader>q` | n | 删除当前缓冲区 |
| `<leader>qq` | n | 强制删除缓冲区 |
| `<leader>qa` | n | 关闭其他所有缓冲区 |
| `<leader>qA` | n | 关闭所有缓冲区 |
| `gt` / `gT` | n | 下一个/上一个缓冲区 |

### 标签页管理

| 按键 | 模式 | 功能 |
|------|------|------|
| `<leader>tn` | n | 新建标签页 |
| `<leader>tc` | n | 关闭标签页 |
| `<leader>to` | n | 只保留当前标签页 |
| `t]` / `t[` | n | 下一个/上一个标签页 |

### Git 操作

| 按键 | 模式 | 功能 |
|------|------|------|
| `<C-g>` | n | 打开 LazyGit |
| `<leader>gs` | n | Git 状态 |
| `<leader>gb` | n | Git Blame |
| `<leader>hs` | n/v | 暂存 hunk |
| `<leader>hr` | n/v | 重置 hunk |
| `<leader>hp` | n | 预览 hunk |
| `<leader>hb` | n | 显示行 Blame |
| `<leader>hd` | n | 显示 diff |
| `<leader>tb` | n | 切换行 blame 显示 |
| `]c` / `[c` | n | 下一个/上一个 Git 变更 |

### 终端 (ToggleTerm)

| 按键 | 模式 | 功能 |
|------|------|------|
| `<C-\>` | n | 切换终端 |
| `<leader>tt` | n | 浮动终端 |
| `<leader>th` | n | 水平终端 |
| `<leader>tv` | n | 垂直终端 |

### 导航 (Leap)

| 按键 | 模式 | 功能 |
|------|------|------|
| `<leader>j` | n/x/o | Leap 向前跳转 |
| `<leader>k` | n/x/o | Leap 向后跳转 |
| `<leader>g` | n/x/o | Leap 跨窗口搜索 |

### 会话管理 (Persistence)

| 按键 | 模式 | 功能 |
|------|------|------|
| `<leader>qs` | n | 恢复上次会话 |
| `<leader>ql` | n | 恢复最后一次会话 |
| `<leader>qd` | n | 不保存当前会话 |

### GitHub Copilot

| 按键 | 模式 | 功能 |
|------|------|------|
| `<C-j>` | i | 下一个建议 |
| `<C-k>` | i | 上一个建议 |

### 其他

| 按键 | 模式 | 功能 |
|------|------|------|
| `<leader>se` | n | 编辑代码片段 |
| `<leader>fl` | n | ESLint 修复所有 |
| `<leader>Fr` | n | 代码动画 🌧️ |

## 🔧 自定义

### 修改主题
编辑 `lua/plugins/colorscheme.lua` 更换主题或调整颜色。

### 添加 LSP 服务器
1. 打开 Neovim
2. 运行 `:Mason`
3. 搜索并安装所需的 LSP 服务器
4. 在 `lua/plugins/lsp/languages/` 添加语言特定配置

### 自定义键位映射
编辑 `lua/core/keymaps.lua` 添加或修改键位映射。

### 添加插件
在 `lua/plugins/` 目录下创建新的 `.lua` 文件，lazy.nvim 会自动加载。

## 📚 主要插件列表

| 插件 | 功能 |
|------|------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | 插件管理器 |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP 配置 |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | LSP/DAP/Linter 管理器 |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | 自动补全引擎 |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | 代码片段引擎 |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | 模糊查找器 |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | 语法解析和高亮 |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git 装饰 |
| [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) | LazyGit 集成 |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | 文件浏览器 |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | 状态栏 |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | 缓冲区标签栏 |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | 终端管理器 |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | 代码格式化 |
| [copilot.vim](https://github.com/github/copilot.vim) | GitHub Copilot |
| [leap.nvim](https://github.com/ggandor/leap.nvim) | 快速跳转导航 |
| [nvim-surround](https://github.com/kylechui/nvim-surround) | 包围符操作 |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | 智能注释 |
| [noice.nvim](https://github.com/folke/noice.nvim) | UI 增强 |

## 🎯 使用技巧

### LSP 服务器安装
```vim
:Mason                    " 打开 Mason 界面
:MasonInstall <server>    " 安装指定服务器
:LspInfo                  " 查看 LSP 状态
```

### 插件管理
```vim
:Lazy                     " 打开 Lazy 界面
:Lazy sync                " 同步插件
:Lazy update              " 更新插件
:Lazy clean               " 清理未使用的插件
```

### 代码片段
自定义代码片段位于 `snippets/` 目录，按语言分类。使用 `<leader>se` 快速编辑。

### 会话持久化
配置自动保存和恢复会话，退出时会自动保存，下次启动使用 `<leader>qs` 恢复。

## 🐛 故障排查

### LSP 不工作
1. 检查 LSP 服务器是否安装: `:Mason`
2. 查看 LSP 日志: `:LspLog`
3. 检查 LSP 状态: `:LspInfo`

### 插件加载失败
1. 更新插件: `:Lazy sync`
2. 清除缓存: 删除 `~/.local/share/nvim` 和 `~/.cache/nvim`
3. 重新安装: 重启 Neovim

### Treesitter 语法高亮异常
```vim
:TSUpdate                 " 更新 Treesitter 解析器
:TSInstallInfo            " 查看已安装的解析器
```

## 📄 许可证

MIT License

## 🙏 致谢

感谢所有优秀的 Neovim 插件作者和社区贡献者！

---

**模式说明**:
- `n` = Normal 模式
- `i` = Insert 模式
- `v` = Visual 模式
- `x` = Visual 模式 (不含 Select)
- `o` = Operator-pending 模式
