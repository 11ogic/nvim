return {
    -- 主题: Nightfox
    {
      "EdenEast/nightfox.nvim",
      priority = 1000, -- 确保它比其他插件先加载
      config = function()
        require("nightfox").setup({
          options = {
            -- 透明背景
            transparent = false,
            -- 终端颜色
            terminal_colors = true,
            -- 样式: "italic", "bold", "underline", "strikethrough"
            styles = {
              comments = "italic",
              keywords = "bold",
              types = "italic,bold",
            },
            -- 反色选项
            inverse = {
              match_paren = false,
              visual = false,
              search = false,
            },
            -- 增强黑橙色调
            colors = {
              -- 所有变体共享的颜色覆盖
              all = {
                -- 可以添加自定义颜色覆盖
              },
              -- 特定变体的颜色覆盖
              carbonfox = {
                -- 增强橙色调
                orange = "#d08770",
              },
            },
          },
        })

        -- 应用主题
        vim.cmd("colorscheme carbonfox")  -- 或使用变体: duskfox, nordfox, terafox, carbonfox
      end,
    },
  }