-- UI 增强插件配置
return {
  -- UI组件增强 (dressing)
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
}
