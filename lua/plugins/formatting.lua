-- 代码格式化配置 (conform.nvim)
return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  cmd = { "ConformInfo" },
  opts = {
    -- 定义各种文件类型的格式化工具
    formatters_by_ft = {
      -- JavaScript/TypeScript
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },

      -- Web 开发
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      less = { "prettier" },

      -- 配置文件
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      yml = { "prettier" },

      -- Markdown
      markdown = { "prettier" },

      -- Vue.js
      vue = { "prettier" },

      -- Python
      python = { "ruff_format", "ruff_fix" },

      -- Go
      go = { "gofumpt", "goimports" },

      -- Lua
      lua = { "stylua" },

      -- Shell
      sh = { "shfmt" },
      bash = { "shfmt" },
      zsh = { "shfmt" },
    },

    -- 保存时自动格式化
    format_on_save = false,
    -- format_on_save = {
    --   timeout_ms = 500,
    --   lsp_fallback = true,
    -- },

    -- 自定义格式化工具配置
    formatters = {
      prettier = {
        prepend_args = { "--single-quote", "--trailing-comma", "es5" },
      },
      stylua = {
        prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
      },
    },
  },

  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
