-- 通用代码片段 (适用于所有文件类型)
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- 日期时间模板
  s("date", f(function()
    return os.date("%Y-%m-%d")
  end)),

  s("time", f(function()
    return os.date("%H:%M:%S")
  end)),

  s("datetime", f(function()
    return os.date("%Y-%m-%d %H:%M:%S")
  end)),

  -- 文件头注释模板
  s("header", fmt([[
    /**
     * @file {}
     * @author {}
     * @date {}
     * @description {}
     */
  ]], {
    f(function()
      return vim.fn.expand("%:t")
    end),
    i(1, "Your Name"),
    f(function()
      return os.date("%Y-%m-%d")
    end),
    i(2, "文件描述")
  })),

  -- TODO 注释模板
  s("todo", fmt([[
    // TODO: {} - {}
  ]], {
    i(1, "描述"),
    f(function()
      return os.date("%Y-%m-%d")
    end)
  })),

  s("fixme", fmt([[
    // FIXME: {} - {}
  ]], {
    i(1, "需要修复的问题"),
    f(function()
      return os.date("%Y-%m-%d")
    end)
  })),

  s("note", fmt([[
    // NOTE: {}
  ]], {
    i(1, "重要说明")
  })),

  -- 分隔线模板
  s("sep", t("// ==========================================")),
  s("sep2", t("/* ========================================== */")),

  -- 函数注释模板
  s("jsdoc", fmt([[
    /**
     * {}
     * @param {{{}}} {} {}
     * @returns {{{}}} {}
     */
  ]], {
    i(1, "函数描述"),
    i(2, "type"),
    i(3, "paramName"),
    i(4, "参数描述"),
    i(5, "returnType"),
    i(6, "返回值描述")
  })),

  -- 许可证模板
  s("mit", fmt([[
    /*
     * MIT License
     * 
     * Copyright (c) {} {}
     * 
     * Permission is hereby granted, free of charge, to any person obtaining a copy
     * of this software and associated documentation files (the "Software"), to deal
     * in the Software without restriction, including without limitation the rights
     * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
     * copies of the Software, and to permit persons to whom the Software is
     * furnished to do so, subject to the following conditions:
     * 
     * The above copyright notice and this permission notice shall be included in all
     * copies or substantial portions of the Software.
     * 
     * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
     * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
     * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
     * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
     * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
     * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
     * SOFTWARE.
     */
  ]], {
    f(function()
      return os.date("%Y")
    end),
    i(1, "Your Name")
  })),

  -- Lorem ipsum 文本模板
  s("lorem", t("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")),

  -- 邮箱模板
  s("email", i(1, "example@email.com")),

  -- URL 模板
  s("url", i(1, "https://example.com")),

  -- picsum
  s("picsum", i(1, "https://picsum.photos/200")),
}
