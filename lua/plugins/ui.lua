return {
  -- 状态栏
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "carbonfox",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = true, -- 只在最底部显示一条全局状态栏
        },
      })
    end,
  },

  -- 缓冲区标签
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          separator_style = "thin",
          offsets = {
            {
              filetype = "NvimTree",
              text = "====== File Explorer ======",
              highlight = "Directory",
              text_align = "center",
            }
          },
        },
      })
    end,
  },

  -- 文件浏览器
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- 设置nvim-tree
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
          width = 40,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
      })

      -- 设置按键映射
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "切换文件浏览器" })
    end,
  },

  -- 缩进线
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = {
          char = "│",
        },
      })
    end,
  },

  -- 启动屏幕
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- ASCII 艺术 Logo
      dashboard.section.header.val = {
        "                                                     ",
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
        "                                                     ",
        "                欢迎来到 Neovim 世界                 ",
        "                                                     ",
      }

      -- 快捷按键
      dashboard.section.buttons.val = {
        dashboard.button("f", "  查找文件", ":Telescope find_files <CR>"),
        dashboard.button("e", "  新文件", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", "  最近文件", ":Telescope oldfiles <CR>"),
        dashboard.button("t", "  查找文本", ":Telescope live_grep <CR>"),
        dashboard.button("c", "  配置", ":e ~/.config/nvim/init.lua <CR>"),
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
  },
}
