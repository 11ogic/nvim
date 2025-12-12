# CLAUDE.md

此文件为 Claude Code (claude.ai/code) 在本仓库中工作时提供指导。

## 概述

这是一个使用 Lua 编写的现代 Neovim 配置，使用 lazy.nvim 作为插件管理器。配置提供类 IDE 功能，包括 LSP 支持、自动补全、模糊查找和 Git 集成。

## 依赖要求

- Neovim >= 0.11.0
- Node.js >= 18.0（用于 LSP 服务器）
- ripgrep（用于 Telescope 实时搜索）
- Nerd Font 字体（用于图标显示）

## 架构

### 入口点
- `init.lua` - 加载核心设置、键映射，并引导 lazy.nvim 自动发现 `lua/plugins/` 目录下的插件

### 核心配置 (`lua/core/`)
- `options.lua` - Neovim 设置（2空格缩进、相对行号等）
- `keymaps.lua` - 所有键位映射，Leader 键设为空格。包含全局映射并导出供插件使用的设置函数（`setup_lsp_keymaps`、`setup_gitsigns_keymaps`、`setup_nvimtree_keymaps`）
- `colors.lua` - 基于 Ayu 主题的集中式颜色管理。提供 `palette`、`semantic` 和组件专用的颜色表

### LSP 设置 (`lua/plugins/lsp/`)
- `init.lua` - 主入口，协调加载 mason、cmp、servers 和 utils 模块
- `servers.lua` - 配置 LSP 服务器，使用共享的 `on_attach` 和 `capabilities`，加载语言特定模块
- `languages/` - 按语言划分的 LSP 配置（javascript、vue、go、lua、python、basic）
- `mason.lua` - Mason 包管理器设置
- `cmp.lua` - 自动补全配置

### UI 组件 (`lua/plugins/ui/`)
- `statusline.lua` - Lualine 配置
- `bufferline.lua` - 缓冲区标签
- `explorer.lua` - NvimTree 文件浏览器
- `dashboard.lua` - 启动屏幕
- `notifications.lua` - Noice/notify 设置
- `enhancements.lua` - 其他 UI 增强

### 自定义代码片段 (`snippets/`)
按文件类型组织的 LuaSnip 代码片段：`lua.lua`、`javascript.lua`、`typescript.lua`、`vue.lua`、`all.lua`

## 关键模式

### 添加新的 LSP 服务器
1. 在 `lua/plugins/lsp/languages/` 中创建文件，包含 `setup(capabilities, on_attach)` 函数
2. 将模块添加到 `lua/plugins/lsp/servers.lua` 中的 `languages` 表

### 添加插件键映射
- 全局键映射：添加到 `lua/core/keymaps.lua` 中的 `M` 表
- 插件专用键映射：使用导出的设置函数模式（如 `_G.setup_lsp_keymaps`）

### 颜色自定义
所有颜色集中在 `lua/core/colors.lua` 中。使用 `M.palette` 获取基础颜色，`M.semantic` 获取语义化颜色，或使用组件专用表（如 `M.nvimtree`、`M.bufferline`）。

## 重要键位

- `<Space>` - Leader 键
- `<leader><space>` - 查找文件（Telescope）
- `<leader>fg` - 实时搜索
- `<leader>o` - 切换文件浏览器
- `<C-\>` - 切换终端
- `<C-g>` - LazyGit
- `<C-l>` - 格式化代码（Conform）
- `gd` - 跳转到定义（LSP）
- `gr` - 查找引用（LSP）
- `K` - 悬浮文档（LSP）
