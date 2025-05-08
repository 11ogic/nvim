return {
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_enabled = true
			vim.g.copilot_no_tab_map = true  -- 禁用默认的 Tab 映射

			-- 使用 Tab 优先考虑 Copilot
			vim.api.nvim_set_keymap("i", "<Tab>", 'copilot#Accept("<Tab>")', { expr = true, silent = true })

			-- 让 Copilot 更积极地提供建议
			vim.g.copilot_assume_mapped = true

			-- 设置 Copilot 自动触发
			vim.g.copilot_autocomplete = 1

			-- 控制 Copilot 的显示风格
			vim.cmd[[highlight CopilotSuggestion guifg=#555555 ctermfg=8]]
		end
	}
}