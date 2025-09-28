-- 初始化Neovim配置
-- 基本设置
require('core.options')
require('core.keymaps')

-- 确保vim全局变量可用
_G.vim = vim or require('vim')

-- 自动安装lazy.nvim插件管理器
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- 使用最新稳定版本
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 插件设置
require("lazy").setup("plugins", {
  git = {
    timeout = 300, -- 5 minutes timeout
    ssl_verify = false, -- Disable SSL verification
  },
  install = {
    colorscheme = { "ayu" },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
