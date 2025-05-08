return {
  -- 状态栏
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "nordfox",
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

  -- UI组件
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      require("dressing").setup({
        input = {
          enabled = true,
          default_prompt = "Input:",
          prompt_align = "left",
          insert_only = true,
          border = "rounded",
          relative = "cursor",
          prefer_width = 40,
          width = nil,
          max_width = { 140, 0.9 },
          min_width = { 20, 0.2 },
          winblend = 0,
          winhighlight = "Normal:Normal,NormalNC:NormalNC",
          override = function(conf)
            conf.anchor = "SW"
            return conf
          end,
        },
        select = {
          enabled = true,
          backend = { "telescope", "fzf", "builtin" },
          trim_prompt = true,
          telescope = nil,
          fzf = {
            window = {
              width = 0.5,
              height = 0.4,
            },
          },
          builtin = {
            border = "rounded",
            relative = "editor",
            winblend = 0,
            winhighlight = "Normal:Normal,NormalNC:NormalNC",
            width = nil,
            max_width = { 140, 0.8 },
            min_width = { 40, 0.2 },
            height = nil,
            max_height = 0.9,
            min_height = { 10, 0.2 },
            override = function(conf)
              conf.anchor = "NW"
              return conf
            end,
          },
        },
        -- 窗口选项
        win_options = {
          winblend = 10, -- 窗口透明度
          winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
        },
      })
    end,
  },

  -- 增强通知
  {
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
        background_colour = "#000000",
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
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          long_message_to_split = true, -- long messages will be sent to a split
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
      })
      -- 诊断浮动窗口配置
      vim.diagnostic.config({
        virtual_text = false,
        float = {
          border = "rounded",
          max_width = 70,
          max_height = 30,
          focusable = true,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter" },
        },
      })
    end
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
