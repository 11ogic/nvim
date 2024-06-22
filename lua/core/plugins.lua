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
  require("plugins.telescope").config,
  require("plugins.colorscheme"),
  require("plugins.lualine"),
  require("plugins.navigator"),
  require("plugins.tabline"),
  require("plugins.scrollbar"),
  require("plugins.snippets"),
  require("plugins.editor"),
  require("plugins.nvim-tree"),
  require("plugins.treesitter"),
  require("plugins.autocomplete").config,
  require("plugins.debugger"),
  require("plugins.lspconfig").config,
  require("plugins.go"),
  require("plugins.notify"),
  require("plugins.copilot"),
  require("plugins.git"),
}, {})
