local module = {}

local tool = {}

local documentation_window_open = false

module.config = {
  {
    'weilbith/nvim-code-action-menu',
    cmd = 'CodeActionMenu',
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      {
        "folke/trouble.nvim",
        opts = {
          use_diagnostic_signs = true,
          action_keys = {
            close = "<esc>",
            previous = "u",
            next = "e"
          },
        },
      },
      { 'neovim/nvim-lspconfig' },
      {
        'williamboman/mason.nvim',
        build = function()
          vim.cmd([[MasonInstall]])
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'hrsh7th/cmp-nvim-lsp' },
      {
        'j-hui/fidget.nvim',
        tag = "legacy"
      },
      "folke/neodev.nvim",
      "ray-x/lsp_signature.nvim",
      "ldelossa/nvim-dap-projects",
      "MunifTanjim/prettier.nvim",
      -- "mjlbach/lsp_signature.nvim",
      "airblade/vim-rooter",
      "b0o/schemastore.nvim",
    },

    config = function()
      local lsp = require('lsp-zero').preset({})
      module.lsp = lsp

      require('mason').setup({})
      require('mason-lspconfig').setup({
        'tsserver',
        'eslint',
        'gopls',
        'jsonls',
        'html',
        'clangd',
        'dockerls',
        'ansiblels',
        'terraformls',
        'texlab',
        'pyright',
        'yamlls',
      })

      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({ buffer = bufnr })
        client.server_capabilities.semanticTokensProvider = nil
        require("plugins.autocomplete").configfunc()
        -- if vim.bo[bufnr].filetype ~= "dart" then
        require("lsp_signature").on_attach(tool.signature_config, bufnr)
        -- end
        vim.diagnostic.config({
          severity_sort = true,
          underline = true,
          signs = true,
          virtual_text = false,
          update_in_insert = false,
          float = true,
        })

        lsp.set_sign_icons({
          error = '✘',
          warn = '▲',
          hint = '⚑',
          info = '»'
        })
      end)

      lsp.set_server_config({
        on_init = function(client)
          client.server_capabilities.semanticTokensProvider = nil
        end,
      })

      lsp.format_on_save({
        format_opts = {
          -- async = false,
          -- timeout_ms = 10000,
        },
      })


      local lspconfig = require('lspconfig')

      require("config.lsp.lua").setup(lspconfig, lsp)
      require("config.lsp.json").setup(lspconfig, lsp)
      require("config.lsp.html").setup(lspconfig, lsp)

      require 'lspconfig'.tsserver.setup {
        init_options = {
          plugins = {
          },
        },
        filetypes = {
          "javascript",
          "typescript",
        },
      }

      require 'lspconfig'.terraformls.setup {}
      vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        pattern = { "*.tf", "*.tfvars", "*.lua" },
        callback = function()
          vim.lsp.buf.format()
        end,
      })
      require 'lspconfig'.yamlls.setup({
        settings = {
          redhat = {
            telemetry = {
              enabled = false
            }
          },
          yaml = {
            schemaStore = {
              enable = false,
              url = "",
            },
            -- schemas = require('schemastore').yaml.schemas(),
            validate = false,
            customTags = {
              "!fn",
              "!And",
              "!If",
              "!Not",
              "!Equals",
              "!Or",
              "!FindInMap sequence",
              "!Base64",
              "!Cidr",
              "!Ref",
              "!Sub",
              "!GetAtt",
              "!GetAZs",
              "!ImportValue",
              "!Select",
              "!Split",
              "!Join sequence"
            }
          },
        }
      })

      require 'lspconfig'.gopls.setup {}

      lsp.setup()


      -- Neovim hasn't added foldingRange to default capabilities, users must add it manually
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
      }
      local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
      for _, ls in ipairs(language_servers) do
        require('lspconfig')[ls].setup({
          capabilities = capabilities
          -- you can add other fields for setting up lsp server in this table
        })
      end

      require("fidget").setup({})

      local lsp_defaults = lspconfig.util.default_config
      lsp_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lsp_defaults.capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )

      require('nvim-dap-projects').search_project_config()

      tool.configureDocAndSignature()
      tool.configureKeybinds()

      local prettier = require("prettier")

      prettier.setup({
        bin = 'prettierd',
        filetypes = {
          "css",
          "graphql",
          "html",
          "javascript",
          "javascriptreact",
          "json",
          "less",
          "markdown",
          "scss",
          "typescript",
          "typescriptreact",
          "yaml",
        },
        cli_options = {
          arrow_parens = "always",
          bracket_spacing = true,
          bracket_same_line = false,
          embedded_language_formatting = "auto",
          end_of_line = "lf",
          html_whitespace_sensitivity = "css",
          -- jsx_bracket_same_line = false,
          jsx_single_quote = false,
          print_width = 80,
          prose_wrap = "preserve",
          quote_props = "as-needed",
          semi = true,
          single_attribute_per_line = false,
          single_quote = false,
          tab_width = 2,
          trailing_comma = "es5",
          use_tabs = false,
          vue_indent_script_and_style = false,
        },
      })

      local format_on_save_filetypes = {
        dart = true,
        json = true,
        go = true,
        lua = true,
        html = true,
        javascript = true,
        typescript = true,
        typescriptreact = true,
        c = true,
        cpp = true,
        objc = true,
        objcpp = true,
        dockerfile = true,
        terraform = true,
        tex = true,
      }

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function()
          if format_on_save_filetypes[vim.bo.filetype] then
            local lineno = vim.api.nvim_win_get_cursor(0)
            vim.lsp.buf.format({ async = false })
            pcall(vim.api.nvim_win_set_cursor, 0, lineno)
          end
        end,
      })
    end
  },
}

tool.configureDocAndSignature = function()
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
      -- silent = true,
      focusable = false,
      border = "rounded",
      zindex = 60,
    }
  )
  local group = vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
  vim.api.nvim_create_autocmd({ "CursorHold" }, {
    pattern = "*",
    callback = function()
      if not documentation_window_open then
        vim.diagnostic.open_float(0, {
          scope = "cursor",
          focusable = false,
          zindex = 10,
          close_events = {
            "CursorMoved",
            "CursorMovedI",
            "BufHidden",
            "InsertCharPre",
            "InsertEnter",
            "WinLeave",
            "ModeChanged",
          },
        })
      end
    end,
    group = group,
  })
  -- vim.api.nvim_create_autocmd({ "CursorHoldI" }, {
  -- 	pattern = "*",
  -- 	command = "silent! lua vim.lsp.buf.signature_help()",
  -- 	group = group,
  -- })

  -- tool.signature_config = {
  -- 	bind = false,
  -- 	floating_window = true,
  -- 	hint_inline = function() return false end,
  -- 	handler_opts = {
  -- 		border = "rounded"
  -- 	}
  -- }
  -- local lspsignature = require('lsp_signature')
  -- lspsignature.setup(tool.signature_config)
end

local documentation_window_open_index = 0
local function show_documentation()
  documentation_window_open_index = documentation_window_open_index + 1
  local current_index = documentation_window_open_index
  documentation_window_open = true
  vim.defer_fn(function()
    if current_index == documentation_window_open_index then
      documentation_window_open = false
    end
  end, 500)
  vim.lsp.buf.hover()
end

tool.configureKeybinds = function()
  vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
      local opts = { buffer = event.buf, noremap = true, nowait = true }

      vim.keymap.set('n', 'K', show_documentation, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', '<leader>gd', ':tab sp<CR><cmd>lua vim.lsp.buf.definition()<cr>', opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
      -- vim.keymap.set({ 'n', 'x' }, '<leader>f', function() vim.lsp.buf.format({ async = true }) end, opts)
      vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', "<leader>a", vim.lsp.buf.code_action, opts)
      -- vim.keymap.set('x', '<leader>aw', vim.lsp.buf.range_code_action, opts)
      -- vim.keymap.set('x', "<leader>,", vim.lsp.buf.range_code_action, opts)
      vim.keymap.set('n', '<leader>t', ':Trouble<cr>', opts)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    end
  })
end

return module