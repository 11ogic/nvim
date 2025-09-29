-- Go LSP 配置
local M = {}

function M.setup(lspconfig, capabilities, on_attach)
  lspconfig.gopls.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      -- 调用基础的 on_attach
      on_attach(client, bufnr)
    end,
    settings = {
      gopls = {
        -- 分析设置
        analyses = {
          unusedparams = true,
          unreachable = true,
          fillstruct = true,
          nilness = true,
          shadow = true,
        },
        -- 静态检查
        staticcheck = true,
        -- 使用 gofumpt 格式化
        gofumpt = true,
        -- 代码补全设置
        completeUnimported = true,
        usePlaceholders = true,
        -- 导入设置
        local_prefix = "",
        -- 实验性功能
        experimentalPostfixCompletions = true,
        -- 代码镜头
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        -- 提示设置
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        -- 语义标记
        semanticTokens = true,
        -- 工作区设置
        directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
        templateExtensions = { "tpl", "yaml", "yml" },
      },
    },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = function(fname)
      -- 优先查找 go.work，然后是 go.mod，最后是 .git
      local root = lspconfig.util.root_pattern("go.work")(fname)
          or lspconfig.util.root_pattern("go.mod")(fname)
          or lspconfig.util.root_pattern(".git")(fname)

      if root then
        vim.notify("Go 项目根目录: " .. root, vim.log.levels.INFO)
        return root
      end

      -- 如果没找到，使用文件所在目录
      vim.notify("未找到 Go 项目根目录，使用文件目录", vim.log.levels.WARN)
      return vim.fn.fnamemodify(fname, ":p:h")
    end,
  })
end

-- Go 特定的格式化函数
function M.format_go_file()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  local gopls_client = nil

  for _, client in ipairs(clients) do
    if client.name == "gopls" then
      gopls_client = client
      break
    end
  end

  if gopls_client then
    vim.lsp.buf.format({
      filter = function(c) return c.id == gopls_client.id end,
      timeout_ms = 3000
    })
  end
end

-- Go 特定的自动命令
function M.setup_autocmds()
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("GoAutoFormat", { clear = true }),
    pattern = { "*.go" },
    callback = function()
      -- 自动导入和格式化
      vim.lsp.buf.code_action({
        context = { only = { "source.organizeImports" } },
        apply = true,
      })
      M.format_go_file()
    end,
  })

  -- Go 文件的特殊设置
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("GoSettings", { clear = true }),
    pattern = "go",
    callback = function()
      -- Go 使用 tab 缩进
      vim.bo.tabstop = 4
      vim.bo.shiftwidth = 4
      vim.bo.expandtab = false

      -- 启用 inlay hints（如果支持）
      if vim.lsp.inlay_hint then
        vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
      end

      -- 设置折叠
      vim.wo.foldmethod = "syntax"
      vim.wo.foldlevel = 99
    end,
  })
end

-- Go 特定的快捷键（可选）
function M.setup_keymaps(bufnr)
  local opts = { buffer = bufnr, silent = true, noremap = true }

  -- 确保 gd 在 Go 文件中正确工作
  vim.keymap.set("n", "gd", function()
    local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "gopls" })
    if #clients > 0 then
      vim.lsp.buf.definition()
    else
      vim.notify("gopls LSP 客户端未附加到当前缓冲区", vim.log.levels.WARN)
    end
  end, vim.tbl_extend("force", opts, { desc = "Go: 跳转到定义" }))

  -- Go 特定的快捷键
  vim.keymap.set("n", "<leader>gt", function()
    -- 如果有 go.nvim 插件则使用，否则使用基本命令
    if pcall(require, "go") then
      vim.cmd("GoTest")
    else
      vim.cmd("!go test")
    end
  end, vim.tbl_extend("force", opts, { desc = "运行 Go 测试" }))

  vim.keymap.set("n", "<leader>gT", function()
    if pcall(require, "go") then
      vim.cmd("GoTestFile")
    else
      vim.cmd("!go test " .. vim.fn.expand("%"))
    end
  end, vim.tbl_extend("force", opts, { desc = "运行当前文件测试" }))

  vim.keymap.set("n", "<leader>gi", function()
    -- 使用 LSP 的 code action 来添加导入
    vim.lsp.buf.code_action({
      context = { only = { "source.organizeImports" } },
      apply = true,
    })
  end, vim.tbl_extend("force", opts, { desc = "整理导入" }))

  vim.keymap.set("n", "<leader>gf", function()
    -- 使用 LSP 的 code action 来填充结构体
    vim.lsp.buf.code_action({
      context = { only = { "refactor.rewrite" } },
      apply = false,
    })
  end, vim.tbl_extend("force", opts, { desc = "代码重构" }))
end

return M
