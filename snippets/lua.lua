-- Lua 语言的代码片段
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- Lua 函数模板
  s("func", fmt([[
    function {}({})
      {}
    end
  ]], {
    i(1, "function_name"),
    i(2, "args"),
    i(3, "-- function body")
  })),

  -- 局部函数模板
  s("lfunc", fmt([[
    local function {}({})
      {}
    end
  ]], {
    i(1, "function_name"),
    i(2, "args"),
    i(3, "-- function body")
  })),

  -- Neovim 插件配置模板
  s("plugin", fmt([[
    return {{
      "{}",
      {}
      config = function()
        {}
      end,
    }}
  ]], {
    i(1, "plugin/name"),
    c(2, {
      t(""),
      t("event = \"VeryLazy\",\n  "),
      t("cmd = { \"Command\" },\n  "),
      t("keys = { \"<leader>key\" },\n  "),
    }),
    i(3, "-- plugin configuration")
  })),

  -- 自动命令模板
  s("autocmd", fmt([[
    vim.api.nvim_create_autocmd("{}", {{
      pattern = "{}",
      callback = function()
        {}
      end,
      desc = "{}"
    }})
  ]], {
    i(1, "BufWritePre"),
    i(2, "*"),
    i(3, "-- callback function"),
    i(4, "描述")
  })),

  -- 键盘映射模板
  s("keymap", fmt([[
    vim.keymap.set("{}", "{}", {}, {{ desc = "{}", noremap = true, silent = true }})
  ]], {
    c(1, { t("n"), t("i"), t("v"), t("x") }),
    i(2, "<leader>key"),
    c(3, {
      i(1, "command"),
      fmt("function()\n    {}\n  end", { i(1, "-- function body") })
    }),
    i(4, "描述")
  })),

  -- 条件判断模板
  s("if", fmt([[
    if {} then
      {}
    end
  ]], {
    i(1, "condition"),
    i(2, "-- code")
  })),

  -- for 循环模板
  s("for", fmt([[
    for {} in {} do
      {}
    end
  ]], {
    i(1, "k, v"),
    i(2, "pairs(table)"),
    i(3, "-- loop body")
  })),

  -- require 模板
  s("req", fmt([[
    local {} = require("{}")
  ]], {
    i(1, "module"),
    i(2, "module.path")
  })),

  -- pcall 安全调用模板
  s("pcall", fmt([[
    local ok, {} = pcall(require, "{}")
    if not ok then
      vim.notify("Failed to load {}", vim.log.levels.ERROR)
      return
    end
  ]], {
    i(1, "module"),
    i(2, "module.name"),
    f(function(args) return args[1][1] end, {2})
  })),
}
