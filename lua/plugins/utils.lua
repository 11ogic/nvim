return {
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
        sticky = true, -- 当换行时，光标是否应该留在原位
        ignore = nil, -- 忽略在注释字符串中的行

        toggler = {
          line = "gcc", -- 切换行注释
          block = "gbc", -- 切换块注释
        },

        opleader = {
          line = "gc", -- 操作行注释
          block = "gb", -- 操作块注释
        },

        mappings = {
          basic = true, -- 启用基本的映射
          extra = true, -- 启用额外的映射
          extended = false, -- 启用扩展的映射
        },

        pre_hook = nil, -- 在注释前运行的函数
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
      require("leap").add_default_mappings()
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
    event = "BufReadPre",
    config = function()
      require("persistence").setup({
        dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
        options = { "buffers", "curdir", "tabpages", "winsize" },
      })

      -- 键盘映射
      vim.keymap.set("n", "<leader>qs", function() require("persistence").load() end,
        { desc = "恢复上次会话" })
      vim.keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end,
        { desc = "恢复最后一次会话" })
      vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end,
        { desc = "不要保存当前会话" })
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
      })
    end,
  },

  -- 增强终端集成
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", desc = "浮动终端" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "水平终端" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "垂直终端" },
    },
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

      -- 终端中的退出插入模式映射
      function _G.set_terminal_keymaps()
        local opts = { noremap = true }
        vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
      end

      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
    end,
  },

  -- 增强通知
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      vim.notify = require("notify")
      require("notify").setup({
        stages = "fade",
        timeout = 3000,
        render = "default",
        background_colour = "FloatShadow",
        max_width = 80,
      })
    end,
  },
}