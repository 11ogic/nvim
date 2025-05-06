# 我的Neovim配置

这是一个使用Lua编写的现代化Neovim配置。

## 特点

- 基于Lua配置
- 使用lazy.nvim进行插件管理
- 现代化的LSP配置
- 美观的UI
- 高效的编辑和导航功能
- Git集成
- 智能的代码补全

## 要求

- Neovim 0.8.0+
- Git
- 一个Nerd Font字体 (推荐: JetBrainsMono Nerd Font)
- 可选: ripgrep (用于更好的搜索体验)
- 可选: lazygit (增强的git体验)

## 安装

1. 备份您当前的Neovim配置(如果有):

```bash
mv ~/.config/nvim ~/.config/nvim.bak
```

2. 克隆此仓库:

```bash
git clone https://github.com/yourusername/nvim-config.git ~/.config/nvim
```

3. 启动Neovim:

```bash
nvim
```

第一次启动时，lazy.nvim将自动安装所有插件。

## 主要插件

- **lazy.nvim**: 插件管理器
- **tokyonight.nvim**: 配色方案
- **nvim-lspconfig**: LSP配置
- **mason.nvim**: 轻松安装LSP服务器
- **nvim-treesitter**: 语法高亮和代码解析
- **nvim-cmp**: 代码补全
- **telescope.nvim**: 模糊查找器
- **lualine.nvim**: 状态栏
- **nvim-tree.lua**: 文件浏览器
- **gitsigns.nvim**: Git集成
- 以及更多...

## 键盘映射

领导键被设置为 `空格`。主要快捷键包括:

### 一般

- `<space>w` - 保存文件
- `<space>q` - 关闭缓冲区
- `jk` - 在插入模式下退出
- `<ctrl>+h/j/k/l` - 窗口导航

### 文件和导航

- `<space>e` - 切换文件浏览器
- `<space>ff` - 查找文件
- `<space>fg` - 通过Grep查找文本
- `<space>fb` - 查找缓冲区
- `<space>fh` - 查找帮助
- `<shift>+h/l` - 切换缓冲区

### LSP

- `gd` - 跳转到定义
- `gr` - 查找引用
- `K` - 显示悬停文档
- `<space>rn` - 重命名
- `<space>ca` - 代码操作
- `<space>f` - 格式化代码

### Git

- `<space>gs` - Git状态
- `<space>gb` - Git blame
- `<space>hs` - 暂存变更
- `<space>hr` - 重置变更
- `<space>hd` - 查看diff

### 终端

- `<ctrl>\` - 切换终端
- `<space>tt` - 浮动终端
- `<space>th` - 水平终端
- `<space>tv` - 垂直终端

## 自定义

您可以通过编辑以下文件来自定义此配置:

- `lua/core/options.lua` - Neovim选项
- `lua/core/keymaps.lua` - 键盘映射
- `lua/plugins/` - 插件配置
- `lua/core/colorscheme.lua` - 颜色主题

## 疑难解答

如果您遇到问题:

1. 更新Neovim到最新版本
2. 更新插件: `:Lazy sync`
3. 检查特定插件的问题 