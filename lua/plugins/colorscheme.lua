return {
  "Shatur/neovim-ayu",
  lazy = false,
  priority = 1000,
  config = function()
    require("ayu").setup({
      overrides = {
        -- 背景
        Normal = {
          bg = "#151515",
        },
      }, -- 可以在这里自定义覆盖颜色
    })
    vim.cmd("colorscheme ayu")
  end,
}
