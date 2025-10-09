-- JavaScript/TypeScript 代码片段
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- 函数声明模板
  s("func", fmt([[
    function {}({}) {{
      {}
    }}
  ]], {
    i(1, "functionName"),
    i(2, "params"),
    i(3, "// function body")
  })),

  -- 箭头函数模板
  s("arrow", fmt([[
    const {} = ({}) => {{
      {}
    }}
  ]], {
    i(1, "functionName"),
    i(2, "params"),
    i(3, "// function body")
  })),

  -- 异步函数模板
  s("async", fmt([[
    async function {}({}) {{
      try {{
        {}
      }} catch (error) {{
        console.error('Error in {}:', error);
        {}
      }}
    }}
  ]], {
    i(1, "functionName"),
    i(2, "params"),
    i(3, "// async code"),
    f(function(args) return args[1][1] end, {1}),
    i(4, "// error handling")
  })),

  -- React 函数组件模板
  s("rfc", fmt([[
    import React from 'react';

    interface {}Props {{
      {}
    }}

    const {}: React.FC<{}Props> = ({{ {} }}) => {{
      return (
        <div>
          {}
        </div>
      );
    }};

    export default {};
  ]], {
    i(1, "Component"),
    i(2, "// props interface"),
    f(function(args) return args[1][1] end, {1}),
    f(function(args) return args[1][1] end, {1}),
    i(3, "props"),
    i(4, "{/* component content */}"),
    f(function(args) return args[1][1] end, {1})
  })),

  -- useState Hook 模板
  s("useState", fmt([[
    const [{}, set{}] = useState({});
  ]], {
    i(1, "state"),
    f(function(args)
      local name = args[1][1]
      return name:sub(1,1):upper() .. name:sub(2)
    end, {1}),
    i(2, "initialValue")
  })),

  -- useEffect Hook 模板
  s("useEffect", fmt([[
    useEffect(() => {{
      {}

      return () => {{
        {}
      }};
    }}, [{}]);
  ]], {
    i(1, "// effect code"),
    i(2, "// cleanup code"),
    i(3, "dependencies")
  })),

  -- try-catch 模板
  s("try", fmt([[
    try {{
      {}
    }} catch (error) {{
      console.error('{}:', error);
      {}
    }}
  ]], {
    i(1, "// try code"),
    i(2, "Error message"),
    i(3, "// error handling")
  })),

  -- Promise 模板
  s("promise", fmt([[
    return new Promise((resolve, reject) => {{
      try {{
        {}
        resolve({});
      }} catch (error) {{
        reject(error);
      }}
    }});
  ]], {
    i(1, "// promise code"),
    i(2, "result")
  })),

  -- console.log 模板
  s("log", fmt([[
    console.log('{}:', {});
  ]], {
    i(1, "Debug"),
    i(2, "variable")
  })),

  -- 导入模板
  s("import", fmt([[
    import {} from '{}';
  ]], {
    c(1, {
      i(1, "module"),
      fmt("{{ {} }}", { i(1, "named") }),
      fmt("* as {}", { i(1, "alias") })
    }),
    i(2, "module-path")
  })),

  -- 导出模板
  s("export", fmt([[
    export {} {};
  ]], {
    c(1, { t("default"), t("const"), t("function"), t("class") }),
    i(2, "name")
  })),
}
