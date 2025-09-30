-- nvim-cmp 自动补全配置
local M = {}

function M.setup()
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    completion = {
      completeopt = "menu,menuone,noinsert",
    },
    window = {
      completion = cmp.config.window.bordered({
        border = "rounded",
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
      }),
      documentation = cmp.config.window.bordered({
        border = "rounded",
        focusable = true
      }),
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-e>"] = cmp.mapping.abort(),                   -- 关闭补全窗口
      ["<CR>"] = cmp.mapping.confirm({ select = true }), -- 确认选择
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
    }),
  })
end

return M
