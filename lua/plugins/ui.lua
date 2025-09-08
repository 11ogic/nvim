local colors = require('core.colors')

return {
  -- 状态栏
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local custom_theme = require("lualine.themes.ayu")
      -- 使用统一的颜色管理
      custom_theme.normal.c.bg = colors.lualine.bg

      require("lualine").setup({
        options = {
          theme = custom_theme,
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
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
          -- 强制启用诊断和状态显示
          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = false,

          -- 📈 标签尺寸和高度配置
          max_name_length = 18, -- 文件名最大长度

          mode = "buffers",
          separator_style = { "", "" },
          -- 启用底部高亮线指示器
          indicator = {
            icon = "",           -- 不显示左侧指示器图标
            style = "underline", -- 使用下划线样式
          },
          -- 关闭按钮配置
          show_buffer_close_icons = false, -- 隐藏缓冲区关闭按钮
          show_close_icon = false,         -- 隐藏右侧关闭按钮
          -- 其他配置
          show_tab_indicators = true,      -- 显示标签指示器
          show_duplicate_prefix = true,    -- 显示重复文件名前缀
          persist_buffer_sort = true,      -- 持久化缓冲区排序
          always_show_bufferline = true,   -- 始终显示 bufferline
          offsets = {
            {
              filetype = "NvimTree",
              text = "📂 File Explorer",
              highlight = "FileExplorerTitle",
              text_align = "center",
              separator = false,
              padding = 1,
            }
          },
        },
        -- 使用统一的颜色管理
        highlights = {
          fill = {
            bg = colors.bufferline.fill_bg
          },
          background = {
            fg = colors.bufferline.inactive_fg,
            bg = colors.bufferline.inactive_bg,
          },
          -- 普通活动标签（无状态）
          buffer_selected = {
            fg = colors.palette.fg_bright, -- 使用明亮的白色
            bg = colors.bufferline.active_bg,
            bold = true,
            underline = true,
            sp = colors.palette.orange,
          },
          buffer_visible = {
            fg = colors.palette.fg_muted,
            bg = colors.palette.bg_light,
          },

          -- ========== 指示器配置 ==========
          -- 活动标签的指示器（底部线）
          indicator_selected = {
            fg = colors.palette.orange, -- 指示器颜色
            bg = colors.bufferline.active_bg,
            underline = true,
            sp = colors.palette.orange,
          },
          -- 可见标签的指示器
          indicator_visible = {
            fg = 'None',
            bg = colors.palette.bg_light,
          },
          modified = {
            fg = colors.semantic.warning,
            bg = colors.bufferline.inactive_bg,
          },
          modified_selected = {
            fg = colors.semantic.warning, -- 黄色表示修改
            bg = colors.bufferline.active_bg,
            underline = true,
            sp = colors.palette.orange, -- 统一的橙色底线
          },
          modified_visible = {
            fg = colors.semantic.warning,
            bg = colors.palette.bg_light,
          },
          -- LSP 诊断颜色
          error = {
            fg = colors.semantic.error,
            bg = colors.bufferline.inactive_bg,
          },
          error_selected = {
            fg = colors.semantic.error, -- 红色表示错误
            bg = colors.bufferline.active_bg,
            underline = true,
            sp = colors.palette.orange, -- 统一的橙色底线
          },
          warning = {
            fg = colors.semantic.warning,
            bg = colors.bufferline.inactive_bg,
          },
          warning_selected = {
            fg = colors.palette.yellow, -- 使用更鲜明的黄色
            bg = colors.bufferline.active_bg,
            underline = true,
            sp = colors.palette.orange, -- 统一的橙色底线
          },
          info = {
            fg = colors.semantic.info,
            bg = colors.bufferline.inactive_bg,
          },
          info_selected = {
            fg = colors.semantic.info, -- 蓝色表示信息
            bg = colors.bufferline.active_bg,
            underline = true,
            sp = colors.palette.orange, -- 统一的橙色底线
          },
          hint = {
            fg = colors.semantic.hint,
            bg = colors.bufferline.inactive_bg,
          },
          hint_selected = {
            fg = colors.semantic.hint, -- 青色表示提示
            bg = colors.bufferline.active_bg,
            underline = true,
            sp = colors.palette.orange, -- 统一的橙色底线
          },
        }
      })

      -- 强制应用 bufferline 颜色配置
      vim.schedule(function()
        -- 确保颜色配置被正确应用
        vim.cmd([[
          highlight! BufferLineErrorSelected guifg=]] .. colors.semantic.error .. [[ gui=underline
          highlight! BufferLineWarningSelected guifg=]] .. colors.palette.yellow .. [[ gui=underline
          highlight! BufferLineModifiedSelected guifg=]] .. colors.semantic.warning .. [[ gui=underline
          highlight! BufferLineInfoSelected guifg=]] .. colors.semantic.info .. [[ gui=underline
          highlight! BufferLineHintSelected guifg=]] .. colors.semantic.hint .. [[ gui=underline
        ]])
      end)
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
      })
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
        max_width = 50,                                  -- 设置通知窗口的最大宽度
        max_height = 10,                                 -- 设置通知窗口的最大高度
        background_colour = colors.palette.bg_very_dark, -- 使用统一的颜色
        minimum_width = 20,                              -- 设置通知窗口的最小宽度
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
          bottom_search = true,         -- use a classic bottom cmdline for search
          long_message_to_split = true, -- long messages will be sent to a split
          lsp_doc_border = true,        -- add a border to hover docs and signature help
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
  },
}
