-- 基础语言 LSP 配置（HTML, CSS, JSON 等）
local M = {}

function M.setup(lspconfig, capabilities, on_attach)
  -- JSON Language Server
  lspconfig.jsonls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      json = {
        -- 基础 JSON schema 支持（不依赖 schemastore）
        validate = { enable = true },
        format = { enable = true },
        schemas = {
          {
            fileMatch = { "package.json" },
            url = "https://json.schemastore.org/package.json"
          },
          {
            fileMatch = { "tsconfig.json", "tsconfig.*.json" },
            url = "https://json.schemastore.org/tsconfig.json"
          },
        },
      },
    },
    filetypes = { "json", "jsonc" },
  })

  -- HTML Language Server
  lspconfig.html.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      html = {
        format = {
          templating = true,
          wrapLineLength = 120,
          wrapAttributes = "auto",
        },
        hover = {
          documentation = true,
          references = true,
        },
        completion = {
          attributeDefaultValue = "doublequotes",
        },
      },
    },
    filetypes = { "html", "htm" },
  })

  -- CSS Language Server
  lspconfig.cssls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      css = {
        validate = true,
        lint = {
          unknownAtRules = "ignore", -- 忽略未知的 CSS 规则（如 Tailwind）
          duplicateProperties = "warning",
          emptyRules = "warning",
        },
        completion = {
          triggerPropertyValueCompletion = true,
          completePropertyWithSemicolon = true,
        },
      },
      scss = {
        validate = true,
        lint = {
          unknownAtRules = "ignore",
          duplicateProperties = "warning",
          emptyRules = "warning",
        },
        completion = {
          triggerPropertyValueCompletion = true,
          completePropertyWithSemicolon = true,
        },
      },
      less = {
        validate = true,
        lint = {
          unknownAtRules = "ignore",
          duplicateProperties = "warning",
          emptyRules = "warning",
        },
        completion = {
          triggerPropertyValueCompletion = true,
          completePropertyWithSemicolon = true,
        },
      },
    },
    filetypes = { "css", "scss", "less" },
  })

  -- YAML Language Server (可选)
  if vim.fn.executable("yaml-language-server") == 1 then
    lspconfig.yamlls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        yaml = {
          schemas = {
            ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
            ["https://json.schemastore.org/github-action.json"] = "/action.{yml,yaml}",
            ["https://json.schemastore.org/docker-compose.json"] = "/docker-compose.{yml,yaml}",
            ["https://json.schemastore.org/kustomization.json"] = "/kustomization.{yml,yaml}",
          },
          validate = true,
          completion = true,
          hover = true,
        },
      },
      filetypes = { "yaml", "yml" },
    })
  end

  -- Markdown Language Server (可选)
  if vim.fn.executable("marksman") == 1 then
    lspconfig.marksman.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "markdown", "md" },
    })
  end
end

-- 基础语言的格式化函数
function M.format_basic_file()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  local prettier_client = nil
  local lsp_client = nil

  for _, client in ipairs(clients) do
    if client.name == "prettier" then
      prettier_client = client
    elseif client.server_capabilities.documentFormattingProvider then
      lsp_client = client
    end
  end

  -- 优先使用 Prettier，其次使用对应的 LSP
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

-- 基础语言的自动命令
function M.setup_autocmds()
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("BasicLangAutoFormat", { clear = true }),
    pattern = { "*.json", "*.jsonc", "*.html", "*.htm", "*.css", "*.scss", "*.less", "*.yaml", "*.yml", "*.md" },
    callback = function()
      M.format_basic_file()
    end,
  })

  -- 各种文件类型的特殊设置
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("BasicLangSettings", { clear = true }),
    pattern = { "json", "jsonc", "html", "css", "scss", "less", "yaml", "yml" },
    callback = function()
      -- 设置缩进
      vim.bo.tabstop = 2
      vim.bo.shiftwidth = 2
      vim.bo.expandtab = true
    end,
  })

  -- Markdown 特殊设置
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("MarkdownSettings", { clear = true }),
    pattern = "markdown",
    callback = function()
      -- 设置缩进
      vim.bo.tabstop = 2
      vim.bo.shiftwidth = 2
      vim.bo.expandtab = true

      -- 启用拼写检查
      vim.wo.spell = true
      vim.bo.spelllang = "en_us"

      -- 设置文本宽度
      vim.bo.textwidth = 80

      -- 启用自动换行
      vim.wo.wrap = true
      vim.wo.linebreak = true
    end,
  })
end

return M
