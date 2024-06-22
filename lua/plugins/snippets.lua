return {
  {
    "SirVer/ultisnips",
    dependencies = {
      "honza/vim-snippets",
    },
    config = function()
      vim.g.UltiSnipsSnippetDirectories = { "~/.config/nvim/Ultisnips" }
      -- vim.g.UltiSnipsExpandTrigger = ""
      -- vim.g.UltiSnipsJumpForwardTrigger = ""
      -- vim.g.UltiSnipsJumpBackwardTrigger = ""
    end
  },
}
