local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  require("plugins.colorscheme"),
  require("plugins.lualine"),
  require("plugins.nvim-tree"),
  require("plugins.navigator"),
  require("plugins.treesitter"),
  require("plugins.autocomplete").config,
  require("plugins.debugger"),
  require("plugins.lspconfig").config,

  "akinsho/bufferline.nvim",
  "lewis6991/gitsigns.nvim",

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
  },
}, {})
