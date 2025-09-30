-- 文件浏览器配置 (nvim-tree)
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- 设置nvim-tree
    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      view = {
        float = {
          enable = true,
          quit_on_focus_loss = true,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = 100,
            height = 50,
            col = (vim.o.columns - 100) / 2, -- 水平居中
            row = (vim.o.lines - 50) / 2,    -- 垂直居中
          },
        },
      },
      renderer = {
        group_empty = true,
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
            enable = true,
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
        update_root = false, -- 不自动切换根目录
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
          warning = "▶",
          error = "✗",
        },
      },
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
