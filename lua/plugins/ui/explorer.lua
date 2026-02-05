-- 文件浏览器配置 (nvim-tree)
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- 设置nvim-tree
    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      sync_root_with_cwd = true,      -- 根目录与 cwd 同步
      respect_buf_cwd = true,         -- 尊重缓冲区的 cwd
      view = {
        float = {
          enable = true,
          quit_on_focus_loss = true,
          open_win_config = function()
            return {
              relative = "editor",
              border = "rounded",
              width = 100,
              height = 50,
              col = (vim.o.columns - 100) / 2, -- 水平居中
              row = (vim.o.lines - 50) / 2,    -- 垂直居中
            }
          end,
        },
      },
      renderer = {
        group_empty = false,
        highlight_git = true,
        highlight_opened_files = "name",
        indent_markers = {
          enable = true,
          inline_arrows = true,
        },
      },
      filters = {
        dotfiles = false,
      },
      -- file actions
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      on_attach = function(bufnr)
        -- 调用统一的nvim-tree键映射设置函数
        if _G.setup_nvimtree_keymaps then
          _G.setup_nvimtree_keymaps(bufnr)
        end
      end,
      -- 自动定位到当前文件
      update_focused_file = {
        enable = true,       -- 启用自动定位
        update_root = true,  -- 自动切换到文件所在项目根目录
        ignore_list = {},    -- 忽略的文件类型
      },
      -- 诊断
      diagnostics = {
        enable = true,
        show_on_dirs = false,
        show_on_open_dirs = true,
        debounce_delay = 50,
        severity = {
          min = vim.diagnostic.severity.HINT,
          max = vim.diagnostic.severity.ERROR,
        },
        icons = {
          hint = "▶",
          info = "▶",
          warning = "●",
          error = "✗",
        },
      },
    })

    -- 添加窗口尺寸变更时自动重新居中的功能
    local function recenter_nvimtree()
      local nvim_tree = require("nvim-tree.api")
      if nvim_tree.tree.is_visible() then
        -- 关闭并重新打开nvim-tree以重新居中
        nvim_tree.tree.close()
        vim.defer_fn(function()
          nvim_tree.tree.open()
        end, 10)
      end
    end

    -- 监听VimResized事件
    vim.api.nvim_create_autocmd("VimResized", {
      pattern = "*",
      callback = recenter_nvimtree,
      desc = "重新居中nvim-tree当窗口尺寸变更时"
    })
  end,
  -- 根据 nvim-tree 官方文档设置诊断栏颜色
  vim.schedule(function()
    local colors = require("core.colors")

    vim.cmd(string.format([[
      highlight! NvimTreeSignColumn guibg=%s
      highlight! NvimTreeSignColumnNC guibg=%s
    ]],
      colors.palette.bg_main,
      colors.palette.bg_alt
    ))
  end)
}
