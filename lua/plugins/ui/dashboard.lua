-- 启动屏幕配置 (alpha-nvim)
return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- 快捷按键
    dashboard.section.buttons.val = {
      dashboard.button("f", "  查找文件", ":Telescope find_files <CR>"),
      dashboard.button("e", "  新文件", ":ene <BAR> startinsert <CR>"),
      dashboard.button("r", "  最近文件", ":Telescope oldfiles <CR>"),
      dashboard.button("t", "  查找文本", ":Telescope live_grep <CR>"),
      dashboard.button("q", "  退出", ":qa<CR>"),
    }

    -- 加载和设置
    alpha.setup(dashboard.config)

    -- 自动命令
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

        dashboard.section.footer.val = "⚡ Neovim 已加载 " .. stats.count .. " 插件，用时 " .. ms .. "ms"
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
