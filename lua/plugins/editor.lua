return {
  {
    "RRethy/vim-illuminate",
    config = function()
      require('illuminate').configure({
        providers = { 'regex' },
      })
      vim.cmd("hi IlluminatedWordText guibg=#393E4D gui=none")
    end
  },
  -- markdown
  {
    "dkarter/bullets.vim",
    lazy = false,
    ft = { "markdown", "txt" },
  },
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      filetypes = { "*" },
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = true,
        RRGGBBAA = false,
        AARRGGBB = true,
        rgb_fn = false,
        hsl_fn = false,
        css = false,
        css_fn = false,
        mode = "virtualtext",
        tailwind = true,
        sass = { enable = false },
        virtualtext = "■",
      },
      buftypes = {},
    }
  },
  {
    'gcmt/wildfire.vim',
    lazy = false,
  },
  {
    "gbprod/substitute.nvim",
    config = function()
      local substitute = require("substitute")
      substitute.setup({
        highlight_substituted_text = {
          enabled = true,
          timer = 200,
        },
      })
      -- vim.keymap.set("n", "s", substitute.operator, { noremap = true })
      -- vim.keymap.set("n", "sh", function() substitute.operator({ motion = "e" }) end, { noremap = true })
      -- vim.keymap.set("x", "s", require('substitute.range').visual, { noremap = true })
      -- vim.keymap.set("n", "ss", substitute.line, { noremap = true })
      -- vim.keymap.set("n", "sI", substitute.eol, { noremap = true })
      -- vim.keymap.set("x", "s", substitute.visual, { noremap = true })
    end
  },
  -- {
  --   "kevinhwang91/nvim-ufo",
  --   dependencies = { "kevinhwang91/promise-async" },
  --   config = function()
  --     require('ufo').setup()
  --     vim.o.foldenable = false
  --   end
  -- },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end
  },
}
