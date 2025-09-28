-- LSP 工具函数和自动命令
local M = {}

function M.setup()
  -- 🔧 自动关闭 Location List 和 Quickfix List
  vim.api.nvim_create_autocmd("BufWinEnter", {
    group = vim.api.nvim_create_augroup("AutoCloseLocationList", { clear = true }),
    pattern = "*",
    callback = function()
      -- 当跳转到新缓冲区时，自动关闭 location list 和 quickfix list
      if vim.bo.buftype == "" then  -- 只在普通文件缓冲区中执行
        vim.schedule(function()
          vim.cmd("silent! lclose") -- 关闭 location list
          vim.cmd("silent! cclose") -- 关闭 quickfix list
        end)
      end
    end,
  })

  -- 🎨 自定义诊断标识（可选，如果需要的话）
  local signs = {
    { name = "DiagnosticSignError", text = "●" },
    { name = "DiagnosticSignWarn", text = "●" },
    { name = "DiagnosticSignHint", text = "●" },
    { name = "DiagnosticSignInfo", text = "●" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, {
      texthl = sign.name,
      text = sign.text,
      numhl = ""
    })
  end

  -- 格式化函数（Prettier 优先）
  M.format_buffer = function()
    local clients = vim.lsp.get_active_clients({ bufnr = 0 })
    local prettier_client = nil
    local lsp_client = nil

    for _, client in ipairs(clients) do
      if client.name == "prettier" or client.name == "null-ls" then
        prettier_client = client
      elseif client.server_capabilities.documentFormattingProvider then
        lsp_client = client
      end
    end

    if prettier_client then
      vim.lsp.buf.format({
        filter = function(c) return c.id == prettier_client.id end,
        timeout_ms = 2000
      })
    elseif lsp_client then
      vim.lsp.buf.format({
        filter = function(c) return c.id == lsp_client.id end,
        timeout_ms = 2000
      })
    end
  end

  -- 自动格式化
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("AutoFormat", { clear = true }),
    pattern = { "*.js", "*.ts", "*.vue", "*.jsx", "*.tsx", "*.json", "*.css", "*.scss", "*.html" },
    callback = function()
      M.format_buffer()
    end,
  })
end

return M
