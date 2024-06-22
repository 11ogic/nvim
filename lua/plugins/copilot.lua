return {
  {
    "github/copilot.vim",
    config = function()
      vim.g.copilot_enabled = true
      vim.g.copilot_no_tab_map = true
      vim.api.nvim_set_keymap('n', '<leader>go', ':Copilot<CR>', { silent = true })
      vim.api.nvim_set_keymap('n', '<leader>ge', ':Copilot enable<CR>', { silent = true })
      vim.api.nvim_set_keymap('n', '<leader>gd', ':Copilot disable<CR>', { silent = true })
      vim.api.nvim_set_keymap('i', '<c-o>', '<Plug>(copilot-suggest)', { noremap = true })
      vim.api.nvim_set_keymap('i', '<c-j>', '<Plug>(copilot-next)', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('i', '<c-k>', '<Plug>(copilot-previous)', { noremap = true, silent = true })
      vim.cmd('imap <silent><script><expr> <c-l> copilot#Accept("")')
      vim.cmd([[
			let g:copilot_filetypes = {
	       \ 'TelescopePrompt': v:false,
	     \ }
			]])
    end
  }
}
