-- 文件浏览器配置 (nvim-tree)
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- 设置nvim-tree
    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      view = {
        width = 40,
      },
      renderer = {
        group_empty = true,
        highlight_git = true,
        highlight_opened_files = "name",
        indent_markers = {
          enable = true,
          inline_arrows = true,
        },
      },
      filters = {
        dotfiles = false,
      },
      -- file actions
      actions = {
        open_file = {
          window_picker = {
            enable = true,
          },
        },
      },
      on_attach = function(bufnr)
        -- 调用统一的nvim-tree键映射设置函数
        if _G.setup_nvimtree_keymaps then
          _G.setup_nvimtree_keymaps(bufnr)
        end
      end,
    })
  end,
}
