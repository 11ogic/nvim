return {
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_enabled = true
			vim.g.copilot_no_tab_map = true  -- 禁用默认的 Tab 映射

			vim.api.nvim_set_keymap("i", "<Tab>", 'copilot#Accept("<Tab>")', { expr = true, silent = true })
			vim.g.copilot_assume_mapped = true
			vim.g.copilot_autocomplete = 1
		end
	}
}