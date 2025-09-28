-- Lua LSP 配置
local M = {}

function M.setup(lspconfig, capabilities, on_attach)
  lspconfig.lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      Lua = {
        -- 运行时设置
        runtime = {
          version = "LuaJIT", -- Neovim 使用 LuaJIT
          path = vim.split(package.path, ";"),
        },
        -- 诊断设置
        diagnostics = {
          globals = {
            "vim",                        -- Neovim 全局变量
            "use",                        -- Packer 插件管理器
            "describe",                   -- Busted 测试框架
            "it",                         -- Busted 测试框架
            "before_each",                -- Busted 测试框架
            "after_each",                 -- Busted 测试框架
          },
          disable = { "missing-fields" }, -- 禁用某些诊断
        },
        -- 工作区设置
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.stdpath("config") .. "/lua"] = true,
            [vim.fn.stdpath("data") .. "/lazy"] = true, -- Lazy.nvim 插件目录
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
          checkThirdParty = false, -- 不检查第三方库
        },
        -- 遥测设置
        telemetry = {
          enable = false -- 禁用遥测
        },
        -- 格式化设置
        format = {
          enable = true,
          defaultConfig = {
            indent_style = "space",
            indent_size = "2",
            continuation_indent_size = "2",
          },
        },
        -- 提示设置
        hint = {
          enable = true,
          paramType = true,
          paramName = "Disable",  -- 禁用参数名提示
          semicolon = "Disable",  -- 禁用分号提示
          arrayIndex = "Disable", -- 禁用数组索引提示
        },
        -- 补全设置
        completion = {
          callSnippet = "Replace",    -- 函数调用片段
          keywordSnippet = "Replace", -- 关键字片段
          displayContext = 1,         -- 显示上下文
        },
        -- 语义设置
        semantic = {
          enable = true,
          variable = true,
          annotation = true,
          keyword = false, -- 不对关键字进行语义高亮
        },
      },
    },
    filetypes = { "lua" },
    root_dir = lspconfig.util.root_pattern(".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml",
      "selene.toml", "selene.yml", ".git"),
  })
end

-- Lua 特定的格式化函数
function M.format_lua_file()
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  local stylua_client = nil
  local lua_ls_client = nil

  for _, client in ipairs(clients) do
    if client.name == "stylua" or client.name == "null-ls" then
      stylua_client = client
    elseif client.name == "lua_ls" then
      lua_ls_client = client
    end
  end

  -- 优先使用 StyLua，其次使用 lua_ls
  if stylua_client then
    vim.lsp.buf.format({
      filter = function(c) return c.id == stylua_client.id end,
      timeout_ms = 2000
    })
  elseif lua_ls_client then
    vim.lsp.buf.format({
      filter = function(c) return c.id == lua_ls_client.id end,
      timeout_ms = 2000
    })
  end
end

-- Lua 特定的自动命令
function M.setup_autocmds()
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("LuaAutoFormat", { clear = true }),
    pattern = "*.lua",
    callback = function()
      M.format_lua_file()
    end,
  })

  -- Lua 文件的特殊设置
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("LuaSettings", { clear = true }),
    pattern = "lua",
    callback = function()
      -- 设置缩进
      vim.bo.tabstop = 2
      vim.bo.shiftwidth = 2
      vim.bo.expandtab = true

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

-- Lua 特定的快捷键（可选）
function M.setup_keymaps(bufnr)
  local opts = { buffer = bufnr, silent = true, noremap = true }

  -- Lua 特定的快捷键
  vim.keymap.set("n", "<leader>lr", "<cmd>luafile %<cr>", vim.tbl_extend("force", opts, { desc = "运行当前 Lua 文件" }))
  vim.keymap.set("n", "<leader>ll", "<cmd>lua print(vim.inspect(vim.lsp.get_active_clients()))<cr>",
    vim.tbl_extend("force", opts, { desc = "查看 LSP 客户端" }))
end

return M
