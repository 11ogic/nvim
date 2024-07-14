-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    config = function()
      require("catppuccin").setup {
        flavour = "auto", -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = "latte",
          dark = "mocha",
        },
        transparent_background = true,
      }
      vim.cmd [[colorscheme catppuccin]]
    end,
  },
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    colorscheme = "catppuccin-mocha",
    highlights = {
      init = function()
        local get_hlgroup = require("astroui").get_hlgroup
        return {
          CursorLineFold = { link = "CursorLineNr" },
          GitSignsCurrentLineBlame = { fg = get_hlgroup("NonText").fg, italic = true },
          HighlightURL = { underline = true },
          OctoEditable = { fg = "NONE", bg = "NONE" },
        }
      end,
    },
  },
}
