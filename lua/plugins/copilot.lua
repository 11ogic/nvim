return {
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_enabled = true
			vim.g.copilot_no_tab_map = false -- disable default tab mapping
			vim.g.copilot_assume_mapped = true -- assume you have your own mappings
			vim.g.copilot_autocomplete = 1
		end
	}
}
