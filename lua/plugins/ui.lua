-- UI 插件统一入口
-- 将原来的大文件拆分为多个功能模块

return {
  -- 状态栏
  require("plugins.ui.statusline"),

  -- 缓冲区标签
  require("plugins.ui.bufferline"),

  -- 文件浏览器
  require("plugins.ui.explorer"),

  -- 通知系统
  require("plugins.ui.notifications"),

  -- UI 增强插件
  require("plugins.ui.enhancements")[1], -- dressing
  require("plugins.ui.enhancements")[2], -- indent-blankline

  -- 启动屏幕
  require("plugins.ui.dashboard"),
}
