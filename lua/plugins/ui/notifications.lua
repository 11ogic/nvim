-- 通知系统配置 (noice + nvim-notify)
local colors = require("core.colors")

return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    -- notify 配置
    require("notify").setup({
      stages = "fade_in_slide_out",
      timeout = 3000,
      max_width = 50, -- 设置通知窗口的最大宽度
      max_height = 10, -- 设置通知窗口的最大高度
      background_colour = colors.palette.bg_very_dark, -- 使用统一的颜色
      minimum_width = 20, -- 设置通知窗口的最小宽度
    })

    -- noice 配置
    require("noice").setup({
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- 过滤消息路由
      routes = {
        -- 完全跳过文件写入相关的消息
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "written" },
              { find = '".*" %d+L, %d+B' },
            },
          },
          opts = { skip = true },
        },
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        long_message_to_split = true, -- long messages will be sent to a split
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    })
    -- 诊断配置已移至 lua/plugins/lsp/utils.lua 统一管理
  end,
}
