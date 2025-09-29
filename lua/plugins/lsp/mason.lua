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

  -- 设置Mason-lspconfig (LSP 服务器)
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
      "vue_ls",

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

  -- 注意：格式化工具需要手动安装
  -- 可以通过以下方式安装：
  -- :MasonInstall prettier stylua gofumpt goimports shfmt
  -- 或者使用系统包管理器安装
end

return M
