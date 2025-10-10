-- nvim-cmp 自动补全配置
local M = {}

function M.setup()
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  ---@diagnostic disable-next-line: redundant-parameter
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
      }),
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-q>"] = cmp.mapping.abort(),                   -- 关闭补全窗口
      ["<CR>"] = cmp.mapping.confirm({ select = true }), -- 确认选择
      -- 滚动文档
      ["<C-y>"] = cmp.mapping.scroll_docs(-4),
      ["<C-e>"] = cmp.mapping.scroll_docs(4),

      -- 使用 Tab 进行片段跳转和补全选择
      ["<C-j>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.jumpable(1) then
          luasnip.jump(1)
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<C-k>"] = cmp.mapping(function(fallback)
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
end

return M
