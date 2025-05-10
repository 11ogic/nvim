-- 设置Leader键为空格
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 禁用空格默认行为
vim.keymap.set('n', '<Space>', '<Nop>', { noremap = true, silent = true })

-- 定义所有键盘映射
local M = {
  -- 常规模式
  -- 移动增强
  { "n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, noremap = true } },
  { "n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, noremap = true } },

  -- 窗口导航
  { "n", "<C-h>", "<C-w>h", { desc = "左窗口导航", noremap = true } },
  { "n", "<C-j>", "<C-w>j", { desc = "下窗口导航", noremap = true } },
  { "n", "<C-k>", "<C-w>k", { desc = "上窗口导航", noremap = true } },
  { "n", "<C-l>", "<C-w>l", { desc = "右窗口导航", noremap = true } },

  -- 窗口管理
  { "n", "<leader>q", ":close<CR>", { desc = "关闭当前窗口", noremap = true, silent = true } },
  { "n", "<leader>qq", ":qall<CR>", { desc = "关闭所有窗口", noremap = true, silent = true } },
  { "n", "<leader>w", ":w<CR>", { desc = "保存文件", noremap = true, silent = true } },
  { "n", "<leader>W", ":wall<CR>", { desc = "保存所有文件", noremap = true, silent = true } },
  { "n", "<leader>sv", ":vsplit<CR>", { desc = "垂直分割窗口", noremap = true, silent = true } },
  { "n", "<leader>sh", ":split<CR>", { desc = "水平分割窗口", noremap = true, silent = true } },
  { "n", "<leader>se", "<C-w>=", { desc = "等分窗口", noremap = true, silent = true } },

  -- 缓冲区管理
  { "n", "<leader>bd", ":bd<CR>", { desc = "删除当前缓冲区", noremap = true, silent = true } },
  { "n", "<leader>bD", ":!bd<CR>", { desc = "强制删除当前缓冲区", noremap = true, silent = true } },
  { "n", "<leader>bn", ":bnext<CR>", { desc = "下一个缓冲区", noremap = true, silent = true } },
  { "n", "<leader>bp", ":bprevious<CR>", { desc = "上一个缓冲区", noremap = true, silent = true } },

  -- 查看通知历史
  { "n", "<leader>no", "<cmd>Telescope notify<cr>", { desc = "查看通知历史", noremap = true, silent = true } },

  -- 标签页
  { "n", "gT", "<cmd>bprevious<cr>", { desc = "上一个标签页", noremap = true, silent = true } },
  { "n", "gt", "<cmd>bnext<cr>", { desc = "下一个标签页", noremap = true, silent = true } },

  -- 清除搜索高亮
  { "n", "<leader>nh", ":nohl<CR>", { desc = "清除搜索高亮", noremap = true, silent = true } },

  -- 插入模式
  -- 快速退出插入模式
  { "i", "jk", "<ESC>", { desc = "ESC 替代品", noremap = true } },

  -- 视觉模式
  -- 保持缩进
  { "v", "<", "<gv", { desc = "保持选择的同时左缩进", noremap = true } },
  { "v", ">", ">gv", { desc = "保持选择的同时右缩进", noremap = true } },

  -- 移动选定的文本
  { "v", "J", ":m '>+1<CR>gv=gv", { desc = "向下移动选定的文本", noremap = true } },
  { "v", "K", ":m '<-2<CR>gv=gv", { desc = "向上移动选定的文本", noremap = true } },

  -- 粘贴不覆盖寄存器
  { "v", "p", '"_dP', { desc = "粘贴不覆盖寄存器", noremap = true } },
}

-- 应用所有键映射
for _, mapping in ipairs(M) do
  local mode = mapping[1]
  local key = mapping[2]
  local command = mapping[3]
  local opts = mapping[4]
  vim.keymap.set(mode, key, command, opts)
end
