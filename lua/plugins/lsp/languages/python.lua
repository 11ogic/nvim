-- Python LSP 配置
local M = {}

function M.setup(lspconfig, capabilities, on_attach)
  -- Pyright (推荐的 Python LSP)
  lspconfig.pyright.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      python = {
        analysis = {
          -- 类型检查模式
          typeCheckingMode = "basic", -- "off", "basic", "strict"
          -- 自动导入补全
          autoImportCompletions = true,
          -- 自动搜索路径
          autoSearchPaths = true,
          -- 使用库代码进行类型
          useLibraryCodeForTypes = true,
          -- 诊断模式
          diagnosticMode = "workspace", -- "openFilesOnly", "workspace"
          -- 存根路径
          stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs",
        },
        -- 默认 Python 路径
        defaultInterpreter = { "python3" },
        -- 虚拟环境路径
        venvPath = ".",
      },
    },
    filetypes = { "python" },
    root_dir = lspconfig.util.root_pattern(
      "pyproject.toml",
      "setup.py",
      "setup.cfg",
      "requirements.txt",
      "Pipfile",
      "pyrightconfig.json",
      ".git"
    ),
  })

  -- Ruff (快速的 Python linter 和 formatter) - 可选
  -- 只有在安装了 ruff_lsp 时才启用
  if vim.fn.executable("ruff-lsp") == 1 then
    lspconfig.ruff_lsp.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        -- 禁用 hover，让 Pyright 处理
        client.server_capabilities.hoverProvider = false
        on_attach(client, bufnr)
      end,
      init_options = {
        settings = {
          -- 任何额外的 CLI 参数
          args = {},
        }
      },
      filetypes = { "python" },
    })
  end
end

-- Python 特定的格式化函数
function M.format_python_file()
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  local ruff_client = nil
  local black_client = nil
  local pyright_client = nil

  for _, client in ipairs(clients) do
    if client.name == "ruff_lsp" then
      ruff_client = client
    elseif client.name == "black" or client.name == "null-ls" then
      black_client = client
    elseif client.name == "pyright" then
      pyright_client = client
    end
  end

  -- 优先级：Ruff > Black > Pyright
  if ruff_client then
    vim.lsp.buf.format({
      filter = function(c) return c.id == ruff_client.id end,
      timeout_ms = 3000
    })
  elseif black_client then
    vim.lsp.buf.format({
      filter = function(c) return c.id == black_client.id end,
      timeout_ms = 3000
    })
  elseif pyright_client then
    vim.lsp.buf.format({
      filter = function(c) return c.id == pyright_client.id end,
      timeout_ms = 3000
    })
  end
end

-- Python 特定的自动命令
function M.setup_autocmds()
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("PythonAutoFormat", { clear = true }),
    pattern = "*.py",
    callback = function()
      -- 自动导入排序和格式化
      vim.lsp.buf.code_action({
        context = { only = { "source.organizeImports" } },
        apply = true,
      })
      M.format_python_file()
    end,
  })

  -- Python 文件的特殊设置
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("PythonSettings", { clear = true }),
    pattern = "python",
    callback = function()
      -- PEP 8 缩进设置
      vim.bo.tabstop = 4
      vim.bo.shiftwidth = 4
      vim.bo.expandtab = true
      vim.bo.softtabstop = 4

      -- 设置行长度
      vim.bo.textwidth = 88 -- Black 的默认行长度

      -- 启用 inlay hints（如果支持）
      if vim.lsp.inlay_hint then
        vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
      end

      -- 设置折叠
      vim.wo.foldmethod = "indent"
      vim.wo.foldlevel = 99
    end,
  })
end

-- Python 特定的快捷键（可选）
function M.setup_keymaps(bufnr)
  local opts = { buffer = bufnr, silent = true, noremap = true }

  -- Python 特定的快捷键
  vim.keymap.set("n", "<leader>pr", "<cmd>!python3 %<cr>", vim.tbl_extend("force", opts, { desc = "运行当前 Python 文件" }))
  vim.keymap.set("n", "<leader>pi", "<cmd>!python3 -i %<cr>", vim.tbl_extend("force", opts, { desc = "交互式运行 Python 文件" }))
  vim.keymap.set("n", "<leader>pt", "<cmd>!python3 -m pytest<cr>", vim.tbl_extend("force", opts, { desc = "运行 pytest" }))
  vim.keymap.set("n", "<leader>pT", "<cmd>!python3 -m pytest %<cr>",
    vim.tbl_extend("force", opts, { desc = "运行当前文件的测试" }))
end

-- 虚拟环境检测
function M.detect_venv()
  local venv_path = os.getenv("VIRTUAL_ENV")
  if venv_path then
    return venv_path .. "/bin/python"
  end

  -- 检查常见的虚拟环境目录
  local common_venv_names = { "venv", ".venv", "env", ".env" }
  for _, name in ipairs(common_venv_names) do
    local path = vim.fn.getcwd() .. "/" .. name .. "/bin/python"
    if vim.fn.executable(path) == 1 then
      return path
    end
  end

  return "python3" -- 默认使用系统 Python
end

return M
