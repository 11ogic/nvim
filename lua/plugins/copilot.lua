return {
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_enabled = true
			vim.g.copilot_no_tab_map = true  -- 禁用默认的 Tab 映射
			vim.g.copilot_assume_mapped = true
			vim.g.copilot_autocomplete = 1
			-- 键盘映射已移至 lua/core/keymaps.lua 文件中统一管理
		end
	}
}