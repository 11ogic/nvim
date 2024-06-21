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
  "folke/tokyonight.nvim",
  "nvim-lualine/lualine.nvim",
  "nvim-tree/nvim-tree.lua", 
  "nvim-tree/nvim-web-devicons", 
  "christoomey/vim-tmux-navigator",
  "nvim-treesitter/nvim-treesitter",
  "p00f/nvim-ts-rainbow",
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim", -- bridge
    "neovim/nvim-lspconfig"
  },

  -- LSP
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "L3MON4D3/LuaSnip", -- snippets engine
  "saadparwaiz1/cmp_luasnip",
  "rafamadriz/friendly-snippets",
  "hrsh7th/cmp-path",

  "numToStr/Comment.nvim",
  "windwp/nvim-autopairs", 

  "akinsho/bufferline.nvim",
  "lewis6991/gitsigns.nvim",

  {
    'nvim-telescope/telescope.nvim', tag = '0.1.1', 
    dependencies = { {'nvim-lua/plenary.nvim'} } 
  },
},{})
