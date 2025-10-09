-- Vue.js 代码片段
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- Vue 3 Composition API 组件模板
  s("vue3", fmt([[
<script setup lang="ts">
{}
</script>

<template>
  <div class="{}">
    {}
  </div>
</template>

<style scoped lang="less">
.{} {{
  {}
}}
</style>
  ]], {
    i(1, "// component"),
    i(2, "component"),
    i(3, "<!-- content -->"),
    f(function(args) return args[1][1] end, { 2 }),
    i(4, "/* styles */")
  })),

  -- Vue 3 组件
  s("v3", fmt([[
<script setup lang="ts">
{}
</script>

<template>
  {}
</template>
  ]], {
    i(1, "// logic"),
    i(2, "<div>content</div>")
  })),

  -- Vue 3 Props
  s("props", fmt([[
interface Props {{
  {}
}}

const props = defineProps<Props>()
  ]], {
    i(1, "title: string")
  })),

  -- Vue 3 Emits
  s("emits", fmt([[
interface Emits {{
  {}
}}

const emit = defineEmits<Emits>()
  ]], {
    i(1, "(e: \"update:title\")")
  })),

  -- Vue 3 Computed
  s("computed", fmt([[
const {} = computed(() => {{
  {}
}})
  ]], {
    i(1, "computedValue"),
    i(2, "// computation")
  })),

  -- Vue ref 响应式变量
  s("ref", fmt([[
const {} = ref({})
  ]], {
    i(1, "state"),
    i(2, "initialValue")
  })),

  -- Vue reactive 响应式对象
  s("reactive", fmt([[
const {} = reactive({{
  {}
}})
  ]], {
    i(1, "state"),
    i(2, "key: 'value'")
  })),

  -- Vue computed 计算属性
  s("computed", fmt([[
const {} = computed(() => {})
  ]], {
    i(1, "computedValue"),
    i(2, "// computation")
  })),

  -- Vue watch 监听器
  s("watch", fmt([[
watch({}, ({}) => {{
  {}
}})
  ]], {
    i(1, "source"),
    i(2, "newValue"),
    i(3, "// watch logic")
  })),

  -- Vue onMounted 生命周期
  s("onMounted", fmt([[
onMounted(() => {{
  {}
}})
  ]], {
    i(1, "// mounted logic")
  })),

  -- Vue 3 Composable 函数（简化版）
  s("useComposable", fmt([[
import {{ ref }} from 'vue'

export function use{}() {{
  const {} = ref({})

  const {} = () => {{
    {}
  }}

  return {{
    {},
    {}
  }}
}}
  ]], {
    i(1, "Feature"),
    i(2, "state"),
    i(3, "initialValue"),
    i(4, "action"),
    i(5, "// action logic"),
    f(function(args) return args[1][1] end, { 2 }),
    f(function(args) return args[1][1] end, { 4 })
  })),

  -- Vue 2 Options API 组件模板
  s("vue2", fmt([[
    <template>
      <div class="{}">
        {}
      </div>
    </template>

    <script>
    export default {{
      name: '{}',
      props: {{
        {}
      }},
      data() {{
        return {{
          {}
        }}
      }},
      computed: {{
        {}() {{
          {}
        }}
      }},
      methods: {{
        {}() {{
          {}
        }}
      }},
      mounted() {{
        {}
      }}
    }}
    </script>

    <style scoped>
    .{} {{
      {}
    }}
    </style>
  ]], {
    i(1, "component-name"),
    i(2, "<!-- template content -->"),
    i(3, "ComponentName"),
    i(4, "// props definition"),
    i(5, "// data properties"),
    i(6, "computedName"),
    i(7, "// computed logic"),
    i(8, "methodName"),
    i(9, "// method logic"),
    i(10, "// mounted logic"),
    f(function(args) return args[1][1] end, { 1 }),
    i(11, "/* styles */")
  })),

  -- Pinia Store 模板（简化版）
  s("pinia", fmt([[
import {{ defineStore }} from 'pinia'

export const use{}Store = defineStore('{}', () => {{
  const {} = ref({})

  const {} = () => {{
    {}
  }}

  return {{
    {},
    {}
  }}
}})
  ]], {
    i(1, "Todo"),
    f(function(args) return args[1][1]:lower() end, { 1 }),
    i(2, "todos"),
    i(3, "[]"),
    i(4, "addTodo"),
    i(5, "// action logic"),
    f(function(args) return args[1][1] end, { 2 }),
    f(function(args) return args[1][1] end, { 4 })
  })),

  -- Vue Router 路由配置模板（简化版）
  s("route", fmt([[
{{
  path: '/{}',
  name: '{}',
  component: () => import('@/views/{}.vue')
}}
  ]], {
    i(1, "path"),
    i(2, "RouteName"),
    i(3, "ViewName")
  })),
}
