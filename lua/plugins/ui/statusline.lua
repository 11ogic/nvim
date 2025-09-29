-- 状态栏配置 (lualine)
local colors = require("core.colors")

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local custom_theme = require("lualine.themes.ayu")
    -- 使用统一的颜色管理
    custom_theme.normal.c.bg = colors.lualine.bg

    require("lualine").setup({
      options = {
        theme = custom_theme,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true, -- 只在最底部显示一条全局状态栏
      },
    })
  end,
}
