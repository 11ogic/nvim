-- 设置Leader键为空格
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 禁用空格默认行为
vim.keymap.set('n', '<Space>', '<Nop>', { noremap = true, silent = true })

-- 定义所有键盘映射
local M = {
  -- ========== 基础编辑操作 ==========
  -- 移动增强
  { "n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, noremap = true } },
  { "n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, noremap = true } },

  -- 快速退出插入模式
  { "i", "jk", "<ESC>", { desc = "ESC 替代品", noremap = true } },

  -- 视觉模式 - 保持缩进
  { "v", "<", "<gv", { desc = "保持选择的同时左缩进", noremap = true } },
  { "v", ">", ">gv", { desc = "保持选择的同时右缩进", noremap = true } },

  -- 移动选定的文本
  { "v", "J", ":m '>+1<CR>gv=gv", { desc = "向下移动选定的文本", noremap = true } },
  { "v", "K", ":m '<-2<CR>gv=gv", { desc = "向上移动选定的文本", noremap = true } },

  -- 粘贴不覆盖寄存器
  { "v", "p", '"_dP', { desc = "粘贴不覆盖寄存器", noremap = true } },

  -- 清除搜索高亮
  { "n", "<leader>nh", ":nohl<CR>", { desc = "清除搜索高亮", noremap = true, silent = true } },

  -- ========== 窗口导航和管理 ==========
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

  -- ========== 缓冲区和标签页管理 ==========
  -- 缓冲区管理
  { "n", "<leader>bd", ":bd<CR>", { desc = "删除当前缓冲区", noremap = true, silent = true } },
  { "n", "<leader>bD", ":!bd<CR>", { desc = "强制删除当前缓冲区", noremap = true, silent = true } },
  { "n", "<leader>bn", ":bnext<CR>", { desc = "下一个缓冲区", noremap = true, silent = true } },
  { "n", "<leader>bp", ":bprevious<CR>", { desc = "上一个缓冲区", noremap = true, silent = true } },

  -- 标签页
  { "n", "gT", "<cmd>bprevious<cr>", { desc = "上一个标签页", noremap = true, silent = true } },
  { "n", "gt", "<cmd>bnext<cr>", { desc = "下一个标签页", noremap = true, silent = true } },

  -- ========== 文件浏览器 (nvim-tree) ==========
  { "n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "切换文件浏览器", noremap = true, silent = true } },

  -- ========== 搜索和查找 (Telescope) ==========
  -- 基础搜索
  { "n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "查找文件", noremap = true, silent = true } },
  { "n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "通过Grep查找", noremap = true, silent = true } },
  { "n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "查找缓冲区", noremap = true, silent = true } },
  { "n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "查找帮助", noremap = true, silent = true } },

  -- 高级搜索
  { "n", "<leader>fa", "<cmd>Telescope find_files hidden=true<cr>", { desc = "查找所有文件（包括隐藏文件）", noremap = true, silent = true } },
  { "n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "查找当前单词", noremap = true, silent = true } },
  { "n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "查找最近文件", noremap = true, silent = true } },

  -- 查看通知历史
  { "n", "<leader>no", "<cmd>Telescope notify<cr>", { desc = "查看通知历史", noremap = true, silent = true } },

  -- ========== Leap跳转导航 ==========
  { { 'n', 'x', 'o' }, "<leader>j", "<Plug>(leap-forward-to)", { desc = "Leap向前跳转", noremap = true } },
  { { 'n', 'x', 'o' }, "<leader>k", "<Plug>(leap-backward-to)", { desc = "Leap向后跳转", noremap = true } },
  { { 'n', 'x', 'o' }, "<leader>g", "<Plug>(leap-from-window)", { desc = "Leap跨窗口搜索", noremap = true } },

  -- ========== 会话管理 (Persistence) ==========
  { "n", "<leader>qs", function() require("persistence").load() end, { desc = "恢复上次会话", noremap = true, silent = true } },
  { "n", "<leader>ql", function() require("persistence").load({ last = true }) end, { desc = "恢复最后一次会话", noremap = true, silent = true } },
  { "n", "<leader>qd", function() require("persistence").stop() end, { desc = "不要保存当前会话", noremap = true, silent = true } },

  -- ========== 终端管理 (ToggleTerm) ==========
  { "n", "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", { desc = "浮动终端", noremap = true, silent = true } },
  { "n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "水平终端", noremap = true, silent = true } },
  { "n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", { desc = "垂直终端", noremap = true, silent = true } },
  { "n", "<c-\\>", "<cmd>ToggleTerm<cr>", { desc = "切换终端", noremap = true, silent = true } },

  -- ========== Git操作 ==========
  { "n", "<leader>gs", "<cmd>Git<cr>", { desc = "Git 状态", noremap = true, silent = true } },
  { "n", "<leader>gb", "<cmd>Gblame<cr>", { desc = "Git blame", noremap = true, silent = true } },
  { "n", "<c-g>", ":LazyGit<CR>", { desc = "LazyGit", noremap = true, silent = true } },

  -- ========== Copilot ==========
  { "i", "<C-j>", 'copilot#Next()', { expr = true, silent = true, desc = "下一个Copilot建议" } },
  { "i", "<C-k>", 'copilot#Previous()', { expr = true, silent = true, desc = "上一个Copilot建议" } },

  -- ========== 代码格式化 ==========
  { "n", "<c-l>", function()
    require("conform").format({ async = true, lsp_fallback = true })
  end, { desc = "格式化代码", noremap = true, silent = true } },
  { "n", "<leader>fl", "<cmd>EslintFixAll<cr>", { desc = "格式化 ESLint 代码", noremap = true, silent = true } },

  -- ========== Vue 开发 ==========
  { "n", "<leader>vf", function() vim.lsp.buf.format({ async = false }) end, { desc = "格式化 Vue 文件", noremap = true, silent = true } },
  { "n", "<leader>vr", "<cmd>Telescope lsp_references<cr>", { desc = "查找 Vue 组件引用", noremap = true, silent = true } },
  { "n", "<leader>vd", "<cmd>Telescope lsp_definitions<cr>", { desc = "跳转到 Vue 组件定义", noremap = true, silent = true } },
}

-- LSP 专用键映射函数
local function setup_lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- LSP导航 - 确保覆盖任何全局映射
  vim.keymap.set("n", "gd", function()
    -- 检查是否有 LSP 客户端附加
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    if #clients > 0 then
      vim.lsp.buf.definition()
    else
      -- 如果没有 LSP 客户端，显示消息
      vim.notify("没有 LSP 客户端附加到当前缓冲区", vim.log.levels.WARN)
    end
  end, vim.tbl_extend("force", opts, { desc = "跳转到定义" }))
  vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "查找引用" }))
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "跳转到声明" }))
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "跳转到实现" }))
  vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "显示悬停文档" }))
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "显示签名帮助" }))

  -- 诊断
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "显示诊断信息" }))
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "上一个诊断" }))
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "下一个诊断" }))

  -- 重命名和代码操作
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "重命名符号" }))
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "代码操作" }))

  -- 格式化
  vim.keymap.set("n", "<leader>F", function() vim.lsp.buf.format { async = true } end,
    vim.tbl_extend("force", opts, { desc = "格式化代码" }))
end

-- GitSigns 专用键映射函数
local function setup_gitsigns_keymaps(bufnr)
  local gs = package.loaded.gitsigns

  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  -- 导航
  map("n", "]c", function()
    if vim.wo.diff then
      return "]c"
    end
    vim.schedule(function()
      gs.next_hunk()
    end)
    return "<Ignore>"
  end, { expr = true, desc = "下一个 Git 变更" })

  map("n", "[c", function()
    if vim.wo.diff then
      return "[c"
    end
    vim.schedule(function()
      gs.prev_hunk()
    end)
    return "<Ignore>"
  end, { expr = true, desc = "上一个 Git 变更" })

  -- 动作
  map("n", "<leader>hs", gs.stage_hunk, { desc = "暂存变更" })
  map("n", "<leader>hr", gs.reset_hunk, { desc = "重置变更" })
  map("v", "<leader>hs", function()
    gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, { desc = "暂存选定变更" })
  map("v", "<leader>hr", function()
    gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, { desc = "重置选定变更" })
  map("n", "<leader>hS", gs.stage_buffer, { desc = "暂存所有变更" })
  map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "撤销暂存变更" })
  map("n", "<leader>hR", gs.reset_buffer, { desc = "重置所有变更" })
  map("n", "<leader>hp", gs.preview_hunk, { desc = "预览变更" })
  map("n", "<leader>hb", function()
    gs.blame_line({ full = true })
  end, { desc = "显示 Git blame" })
  map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "切换行 blame" })
  map("n", "<leader>hd", gs.diffthis, { desc = "显示 Git diff" })
  map("n", "<leader>hD", function()
    gs.diffthis("~")
  end, { desc = "显示与 HEAD 的 Git diff" })
  map("n", "<leader>td", gs.toggle_deleted, { desc = "切换删除显示" })
end

-- NvimTree 专用键映射函数
local function setup_nvimtree_keymaps(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('打开'))
  vim.keymap.set('n', 'l', api.node.open.edit, opts('打开'))
  vim.keymap.set('n', '<Tab>', api.node.open.edit, opts('打开'))
  vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('关闭目录'))
  vim.keymap.set('n', 'v', api.node.open.vertical, opts('垂直分割打开'))
  vim.keymap.set('n', 's', api.node.open.horizontal, opts('水平分割打开'))
  vim.keymap.set('n', 't', api.node.open.tab, opts('新标签页打开'))
  vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opts('信息'))
  vim.keymap.set('n', 'a', api.fs.create, opts('创建'))
  vim.keymap.set('n', 'd', api.fs.remove, opts('删除'))
  vim.keymap.set('n', 'r', api.fs.rename, opts('重命名'))
  vim.keymap.set('n', 'c', api.fs.copy.node, opts('复制'))
  vim.keymap.set('n', 'x', api.fs.cut, opts('剪切'))
  vim.keymap.set('n', 'p', api.fs.paste, opts('粘贴'))
  vim.keymap.set('n', 'y', api.fs.copy.filename, opts('复制文件名'))
  vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('复制相对路径'))
  vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('复制绝对路径'))
  vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('切换 Git 忽略'))
  vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('切换隐藏文件'))
  vim.keymap.set('n', 'R', api.tree.reload, opts('刷新'))
  vim.keymap.set('n', '?', api.tree.toggle_help, opts('帮助'))
end

-- 终端专用键映射函数
local function setup_terminal_keymaps()
  local opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

-- 应用基础键映射
for _, mapping in ipairs(M) do
  local mode = mapping[1]
  local key = mapping[2]
  local command = mapping[3]
  local opts = mapping[4]
  vim.keymap.set(mode, key, command, opts)
end

-- 设置自动命令来应用终端键映射
vim.cmd("autocmd! TermOpen term://* lua setup_terminal_keymaps()")

-- 导出函数供插件使用
_G.setup_lsp_keymaps = setup_lsp_keymaps
_G.setup_gitsigns_keymaps = setup_gitsigns_keymaps
_G.setup_nvimtree_keymaps = setup_nvimtree_keymaps
_G.setup_terminal_keymaps = setup_terminal_keymaps
