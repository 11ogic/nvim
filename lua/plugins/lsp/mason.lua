-- Mason LSP 包管理器配置
local M = {}

function M.setup()
  -- 设置Mason
  require("mason").setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    }
  })

  -- 设置Mason-lspconfig
  require("mason-lspconfig").setup({
    ensure_installed = {
      -- Lua
      "lua_ls",

      -- Python
      "pyright",
      "ruff", -- Python linter/formatter

      -- JavaScript/TypeScript
      "ts_ls",
      "eslint",

      -- Vue.js
      "volar",

      -- Go
      "gopls",

      -- 基础语言
      "jsonls",   -- JSON
      "html",     -- HTML
      "cssls",    -- CSS
      "yamlls",   -- YAML (可选)
      "marksman", -- Markdown (可选)
    },
    automatic_installation = true,
  })
end

return M
