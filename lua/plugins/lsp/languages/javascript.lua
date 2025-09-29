-- JavaScript/TypeScript LSP 配置
local M = {}

function M.setup(capabilities, on_attach)
  -- TypeScript Language Server
  vim.lsp.config("ts_ls", {
    capabilities = capabilities,
    on_attach = on_attach,
    -- 确保读取 tsconfig.json
    before_init = function(_, config)
      -- 查找 tsconfig.json 或 jsconfig.json
      local tsconfig = vim.fn.findfile("tsconfig.json", config.root_dir .. ";")
      local jsconfig = vim.fn.findfile("jsconfig.json", config.root_dir .. ";")

      if tsconfig ~= "" then
        config.init_options = config.init_options or {}
        config.init_options.tsconfig = tsconfig
      elseif jsconfig ~= "" then
        config.init_options = config.init_options or {}
        config.init_options.tsconfig = jsconfig
      end
    end,
    settings = {
      typescript = {
        preferences = {
          importModuleSpecifier = "relative",
          includePackageJsonAutoImports = "auto",
        },
        suggest = {
          autoImports = true,
          completeFunctionCalls = false,
        },
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
      javascript = {
        preferences = {
          importModuleSpecifier = "relative",
        },
        suggest = {
          autoImports = true,
          completeFunctionCalls = false,
        },
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
  })

  -- ESLint
  vim.lsp.config("eslint", {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)

      -- 自动修复 ESLint 错误
      -- vim.api.nvim_create_autocmd("BufWritePre", {
      --   buffer = bufnr,
      --   command = "EslintFixAll",
      -- })
    end,
    settings = {
      workingDirectory = { mode = "auto" },
      format = { enable = true },
      lint = { enable = true },
      codeAction = {
        disableRuleComment = {
          enable = true,
          location = "separateLine"
        },
        showDocumentation = {
          enable = true
        }
      }
    },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  })
end

-- JavaScript/TypeScript 特定的格式化函数
function M.format_js_file()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  local prettier_client = nil
  local eslint_client = nil
  local ts_client = nil

  for _, client in ipairs(clients) do
    if client.name == "prettier" then
      prettier_client = client
    elseif client.name == "eslint" then
      eslint_client = client
    elseif client.name == "ts_ls" then
      ts_client = client
    end
  end

  -- 优先级：Prettier > ESLint > TypeScript
  if prettier_client then
    vim.lsp.buf.format({
      filter = function(c) return c.id == prettier_client.id end,
      timeout_ms = 2000
    })
  elseif eslint_client then
    vim.cmd("EslintFixAll")
  elseif ts_client then
    vim.lsp.buf.format({
      filter = function(c) return c.id == ts_client.id end,
      timeout_ms = 2000
    })
  end
end

-- JavaScript/TypeScript 特定的自动命令
function M.setup_autocmds()
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("JSAutoFormat", { clear = true }),
    pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
    callback = function()
      M.format_js_file()
    end,
  })

  -- JavaScript/TypeScript 文件的特殊设置
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("JSSettings", { clear = true }),
    pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    callback = function()
      -- 设置缩进
      vim.bo.tabstop = 2
      vim.bo.shiftwidth = 2
      vim.bo.expandtab = true

      -- 启用 inlay hints（如果支持）
      if vim.lsp.inlay_hint then
        vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
      end
    end,
  })
end

return M
