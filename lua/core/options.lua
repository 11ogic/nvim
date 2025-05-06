-- 设置选项
local opt = vim.opt

-- 行号
opt.number = true
opt.relativenumber = true

-- 缩进
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- 防止包装
opt.wrap = false

-- 搜索设置
opt.ignorecase = true
opt.smartcase = true

-- 外观
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- 回滚
opt.undofile = true
opt.swapfile = false
opt.backup = false

-- 光标行
opt.cursorline = true

-- 外观
opt.scrolloff = 8
opt.sidescrolloff = 8

-- 更新时间
opt.updatetime = 300
opt.timeoutlen = 300

-- 显示模式
opt.showmode = false

-- 内部编码
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- 分割窗口
opt.splitright = true
opt.splitbelow = true

-- 系统剪贴板
opt.clipboard:append("unnamedplus") 