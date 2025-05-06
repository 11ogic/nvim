-- 设置Leader键为空格
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 禁用空格默认行为
vim.keymap.set('n', '<Space>', '<Nop>', { noremap = true, silent = true })

-- 定义所有键盘映射
local M = {
    -- 常规模式
    -- 移动增强
    {"n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, noremap = true }},
    {"n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, noremap = true }},

    -- 窗口导航
    {"n", "<C-h>", "<C-w>h", { desc = "左窗口导航", noremap = true }},
    {"n", "<C-j>", "<C-w>j", { desc = "下窗口导航", noremap = true }},
    {"n", "<C-k>", "<C-w>k", { desc = "上窗口导航", noremap = true }},
    {"n", "<C-l>", "<C-w>l", { desc = "右窗口导航", noremap = true }},

    -- 窗口管理
    {"n", "<leader>sv", "<C-w>v", { desc = "垂直分割", noremap = true }},
    {"n", "<leader>sh", "<C-w>s", { desc = "水平分割", noremap = true }},
    {"n", "<leader>se", "<C-w>=", { desc = "窗口等宽", noremap = true }},
    {"n", "<leader>sx", ":close<CR>", { desc = "关闭当前窗口", noremap = true }},

    -- 缓冲区导航
    {"n", "<S-h>", ":bprevious<CR>", { desc = "上一个缓冲区", noremap = true, silent = true }},
    {"n", "<S-l>", ":bnext<CR>", { desc = "下一个缓冲区", noremap = true, silent = true }},
    {"n", "<leader>x", ":bdelete<CR>", { desc = "关闭当前缓冲区", noremap = true, silent = true }},

    -- 清除搜索高亮
    {"n", "<leader>nh", ":nohl<CR>", { desc = "清除搜索高亮", noremap = true, silent = true }},

    -- 快速保存
    {"n", "<leader>w", ":w<CR>", { desc = "保存", noremap = true, silent = true }},

    -- 快速退出
    {"n", "<leader>q", ":q<CR>", { desc = "退出", noremap = true, silent = true }},

    -- 插入模式
    -- 快速退出插入模式
    {"i", "jk", "<ESC>", { desc = "ESC 替代品", noremap = true }},

    -- 视觉模式
    -- 保持缩进
    {"v", "<", "<gv", { desc = "保持选择的同时左缩进", noremap = true }},
    {"v", ">", ">gv", { desc = "保持选择的同时右缩进", noremap = true }},

    -- 移动选定的文本
    {"v", "J", ":m '>+1<CR>gv=gv", { desc = "向下移动选定的文本", noremap = true }},
    {"v", "K", ":m '<-2<CR>gv=gv", { desc = "向上移动选定的文本", noremap = true }},

    -- 粘贴不覆盖寄存器
    {"v", "p", '"_dP', { desc = "粘贴不覆盖寄存器", noremap = true }},
}

-- 应用所有键映射
for _, mapping in ipairs(M) do
    local mode = mapping[1]
    local key = mapping[2]
    local command = mapping[3]
    local opts = mapping[4]
    vim.keymap.set(mode, key, command, opts)
end
