-- 代码模板插入功能 (LuaSnip)
return {
  -- LuaSnip 代码片段引擎
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    event = "InsertEnter",
    dependencies = {
      -- 友好的代码片段集合
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local luasnip = require("luasnip")
      local types = require("luasnip.util.types")

      -- 基础配置
      luasnip.config.setup({
        -- 更新事件配置
        update_events = "TextChanged,TextChangedI",
        -- 删除检查事件
        delete_check_events = "TextChanged",
        -- 扩展选项
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { "●", "Orange" } },
            },
          },
        },
        -- 启用自动触发
        enable_autosnippets = true,
        -- 存储片段历史
        store_selection_keys = "<Tab>",
      })

      -- 片段展开后切换到普通模式
      -- vim.api.nvim_create_autocmd("User", {
      --   pattern = "LuasnipInsertNodeEnter",
      --   callback = function()
      --     vim.defer_fn(function()
      --       vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>i", true, false, true), "n", false)
      --     end, 0)
      --   end,
      --   desc = "片段展开后切换到普通模式"
      -- })

      -- 加载 VSCode 风格的代码片段
      require("luasnip.loaders.from_vscode").lazy_load()

      -- 加载自定义代码片段
      require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })

      -- 创建自定义代码片段目录
      local snippets_dir = vim.fn.stdpath("config") .. "/snippets"
      if vim.fn.isdirectory(snippets_dir) == 0 then
        vim.fn.mkdir(snippets_dir, "p")
      end
    end,
  },

  -- cmp_luasnip - 将 LuaSnip 与 nvim-cmp 集成
  {
    "saadparwaiz1/cmp_luasnip",
    event = "InsertEnter",
    dependencies = { "L3MON4D3/LuaSnip" },
  },
}
