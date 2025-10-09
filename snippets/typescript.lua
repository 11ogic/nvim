-- TypeScript 代码片段 (继承 JavaScript 片段并添加 TS 特有的)
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- 接口定义模板
  s("interface", fmt([[
    interface {} {{
      {}
    }}
  ]], {
    i(1, "InterfaceName"),
    i(2, "property: type;")
  })),

  -- 类型别名模板
  s("type", fmt([[
    type {} = {};
  ]], {
    i(1, "TypeName"),
    i(2, "string | number")
  })),

  -- 泛型函数模板
  s("gfunc", fmt([[
    function {}<{}>({}: {}): {} {{
      {}
    }}
  ]], {
    i(1, "functionName"),
    i(2, "T"),
    i(3, "param"),
    i(4, "T"),
    i(5, "T"),
    i(6, "// function body")
  })),

  -- 枚举模板
  s("enum", fmt([[
    enum {} {{
      {} = "{}",
      {}
    }}
  ]], {
    i(1, "EnumName"),
    i(2, "FIRST"),
    i(3, "first"),
    i(4, "// more enum values")
  })),

  -- 类模板
  s("class", fmt([[
    class {} {{
      private {}: {};

      constructor({}: {}) {{
        this.{} = {};
      }}

      public {}(): {} {{
        {}
      }}
    }}
  ]], {
    i(1, "ClassName"),
    i(2, "property"),
    i(3, "type"),
    i(4, "param"),
    i(5, "type"),
    f(function(args) return args[1][1] end, {2}),
    f(function(args) return args[1][1] end, {4}),
    i(6, "methodName"),
    i(7, "returnType"),
    i(8, "// method body")
  })),

  -- React Props 接口模板
  s("props", fmt([[
    interface {}Props {{
      {}
      children?: React.ReactNode;
    }}
  ]], {
    i(1, "Component"),
    i(2, "prop: type;")
  })),

  -- TypeScript React 组件模板
  s("tsrfc", fmt([[
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
    i(2, "// props definition"),
    f(function(args) return args[1][1] end, {1}),
    f(function(args) return args[1][1] end, {1}),
    i(3, "props"),
    i(4, "{/* component content */}"),
    f(function(args) return args[1][1] end, {1})
  })),

  -- 自定义 Hook 模板
  s("hook", fmt([[
    import {{ useState, useEffect }} from 'react';

    interface Use{}Return {{
      {}
    }}

    export const use{} = ({}): Use{}Return => {{
      const [{}, set{}] = useState({});

      useEffect(() => {{
        {}
      }}, [{}]);

      return {{
        {},
        {}
      }};
    }};
  ]], {
    i(1, "CustomHook"),
    i(2, "property: type;"),
    f(function(args) return args[1][1] end, {1}),
    i(3, "params"),
    f(function(args) return args[1][1] end, {1}),
    i(4, "state"),
    f(function(args)
      local name = args[1][1]
      return name:sub(1,1):upper() .. name:sub(2)
    end, {4}),
    i(5, "initialValue"),
    i(6, "// effect logic"),
    i(7, "dependencies"),
    f(function(args) return args[1][1] end, {4}),
    i(8, "// more return values")
  })),

  -- API 响应类型模板
  s("apitype", fmt([[
    interface {}Response {{
      success: boolean;
      data: {};
      message?: string;
      error?: string;
    }}

    interface {}Request {{
      {}
    }}
  ]], {
    i(1, "Api"),
    i(2, "DataType"),
    f(function(args) return args[1][1] end, {1}),
    i(3, "param: type;")
  })),
  
}
