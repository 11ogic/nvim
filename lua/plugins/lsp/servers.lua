-- LSP 服务器配置 - 使用新的 vim.lsp.config API
local M = {}

function M.setup()
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  -- 设置按键映射函数 - 键映射已移至 lua/core/keymaps.lua 文件中统一管理
  local on_attach = function(_, bufnr)
    -- 调用统一的LSP键映射设置函数
    if _G.setup_lsp_keymaps then
      _G.setup_lsp_keymaps(bufnr)
    end
  end

  -- 加载各语言模块
  local languages = {
    javascript = require("plugins.lsp.languages.javascript"),
    go = require("plugins.lsp.languages.go"),
    lua = require("plugins.lsp.languages.lua"),
    python = require("plugins.lsp.languages.python"),
    basic = require("plugins.lsp.languages.basic"),
  }

  -- 设置各语言的 LSP
  for name, lang_module in pairs(languages) do
    if lang_module.setup then
      lang_module.setup(capabilities, on_attach)
    end
  end

  -- 设置语言特定的快捷键（如果需要）
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspLanguageKeymaps", { clear = true }),
    callback = function(event)
      local bufnr = event.buf
      local client = vim.lsp.get_client_by_id(event.data.client_id)

      if not client then return end

      -- 延迟设置键映射，确保覆盖其他插件的键映射
      vim.schedule(function()
        -- 重新设置 LSP 键映射以确保优先级
        if _G.setup_lsp_keymaps then
          _G.setup_lsp_keymaps(bufnr)
        end

        -- 根据客户端名称设置特定的快捷键
        if client.name == "gopls" and languages.go.setup_keymaps then
          languages.go.setup_keymaps(bufnr)
        elseif client.name == "lua_ls" and languages.lua.setup_keymaps then
          languages.lua.setup_keymaps(bufnr)
        elseif client.name == "pyright" and languages.python.setup_keymaps then
          languages.python.setup_keymaps(bufnr)
        end
      end)
    end,
  })
end

return M
