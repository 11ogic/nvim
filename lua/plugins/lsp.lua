return {
  -- LSP配置
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "j-hui/fidget.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
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
          "lua_ls",     -- Lua
          "pyright",    -- Python
          "ts_ls",      -- TypeScript/JavaScript
          "jsonls",     -- JSON
          "html",       -- HTML
          "cssls",      -- CSS
          "gopls",      -- Go
          "eslint",     -- ESLint
        },
        automatic_installation = true,
      })
      -- 状态通知
      require("fidget").setup()

      -- 设置nvim-cmp
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(), -- 上一个项目
          ["<C-j>"] = cmp.mapping.select_next_item(), -- 下一个项目
          ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- 向上滚动文档
          ["<C-f>"] = cmp.mapping.scroll_docs(4), -- 向下滚动文档
          ["<C-Space>"] = cmp.mapping.complete(), -- 显示补全
          ["<C-e>"] = cmp.mapping.abort(), -- 关闭补全窗口
          ["<CR>"] = cmp.mapping.confirm({ select = false }), -- 确认选择
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })

      -- LSP设置
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local telescope = require("telescope.builtin")

      -- 设置按键映射函数
      local on_attach = function(_, bufnr)
        local keymap = vim.keymap
        local opts = { noremap = true, silent = true, buffer = bufnr }

        -- LSP导航
        keymap.set("n", "gd", telescope.lsp_definitions, opts)
        keymap.set("n", "gr", telescope.lsp_references, opts)
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        keymap.set("n", "K", vim.lsp.buf.hover, opts)
        keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

        -- 诊断
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

        -- 重命名和代码操作
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

        -- 格式化
        keymap.set("n", "<leader>F", function() vim.lsp.buf.format { async = true } end, opts)
      end

      -- 服务器设置
      local servers = {
        "lua_ls",
        "pyright",
        "ts_ls",
        "jsonls",
        "html",
        "cssls",
        "gopls",
        "eslint",
      }

      -- 基本服务器设置循环
      for _, server in ipairs(servers) do
        if server ~= "lua_ls" and server ~= "gopls" then
          lspconfig[server].setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end
      end

      -- Lua特殊设置
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }, -- 认识vim全局变量
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
            telemetry = { enable = false },
          },
        },
      })

      -- Go特殊设置
      lspconfig.gopls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      })
    end,
  },
}