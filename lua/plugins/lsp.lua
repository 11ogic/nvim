return {
  -- LSP配置
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim", version = "^1.0.0" },
      { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
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

      -- 设置nvim-cmp
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          border = "rounded",
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-e>"] = cmp.mapping.abort(), -- 关闭补全窗口
          ["<CR>"] = cmp.mapping.confirm({ select = false }), -- 确认选择
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

      -- 设置按键映射函数 - 键映射已移至 lua/core/keymaps.lua 文件中统一管理
      local on_attach = function(_, bufnr)
        -- 调用统一的LSP键映射设置函数
        if _G.setup_lsp_keymaps then
          _G.setup_lsp_keymaps(bufnr)
        end
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