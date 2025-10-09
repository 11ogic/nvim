return {
  -- Buffer 管理 - 智能删除 buffer（保留窗口）
  {
    "echasnovski/mini.bufremove",
    event = "VeryLazy",
    config = function()
      require('mini.bufremove').setup()
    end,
  },

  -- 自动配对
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true, -- 使用tree-sitter检查
        ts_config = {
          lua = { "string", "source" },
          javascript = { "string", "template_string" },
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
      })

      -- 将自动配对与cmp集成
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp_status_ok, cmp = pcall(require, "cmp")
      if cmp_status_ok then
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end
    end,
  },

  -- 注释
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("Comment").setup({
        padding = true, -- 注释和行之间添加空格
        sticky = true,  -- 当换行时，光标是否应该留在原位
        ignore = nil,   -- 忽略在注释字符串中的行

        toggler = {
          line = "gcc",  -- 切换行注释
          block = "gbc", -- 切换块注释
        },

        opleader = {
          line = "gc",  -- 操作行注释
          block = "gb", -- 操作块注释
        },

        mappings = {
          basic = true,     -- 启用基本的映射
          extra = true,     -- 启用额外的映射
          extended = false, -- 启用扩展的映射
        },

        pre_hook = nil,  -- 在注释前运行的函数
        post_hook = nil, -- 在注释后运行的函数
      })
    end,
  },

  -- 快速环绕
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- 配置
      })
    end,
  },

  -- 书签
  {
    "MattesGroeger/vim-bookmarks",
    event = { "BufReadPre", "BufNewFile" },
    init = function()
      vim.g.bookmark_sign = "♥"
      vim.g.bookmark_highlight_lines = 1
    end,
  },

  -- 增强f/t移动
  {
    "ggandor/leap.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("leap").setup({
        -- 禁用默认键映射，使用自定义键映射
        default_keymaps = false,
      })
      -- 键盘映射已移至 lua/core/keymaps.lua 文件中统一管理
    end,
  },

  -- 强大的重复动作
  {
    "tpope/vim-repeat",
    event = { "BufReadPre", "BufNewFile" },
  },

  -- 增强会话管理
  {
    "folke/persistence.nvim",
    event = "VimEnter",
    config = function()
      require("persistence").setup({
        dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
        options = { "buffers", "curdir", "tabpages", "winsize" },
      })

      -- 仅在无参数启动 nvim 时自动恢复上次会话
      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("RestoreSession", { clear = true }),
        callback = function()
          -- 检查是否是无参数启动
          if vim.fn.argc() == 0 then
            -- 延迟执行，确保其他插件已加载
            vim.schedule(function()
              require("persistence").load()
            end)
          end
        end,
        nested = true,
      })

      -- 键盘映射已移至 lua/core/keymaps.lua 文件中统一管理
    end,
  },

  -- 增强终端集成
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    -- 键盘映射已移至 lua/core/keymaps.lua 文件中统一管理
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })

      -- 终端中的键盘映射已移至 lua/core/keymaps.lua 文件中统一管理
    end,
  },
}
