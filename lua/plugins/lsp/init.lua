-- LSP 配置主入口文件
return {
  -- LSP配置
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim",           version = "^1.0.0" },
      { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "j-hui/fidget.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      -- 按顺序加载各个模块
      require("plugins.lsp.mason").setup()
      require("plugins.lsp.cmp").setup()
      require("plugins.lsp.servers").setup()
      require("plugins.lsp.utils").setup()
    end,
  },
}
