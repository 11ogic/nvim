local colors = require('core.colors')

return {
  "Shatur/neovim-ayu",
  lazy = false,
  priority = 1000,
  config = function()
    require("ayu").setup({
      overrides = {
        -- 使用统一的背景色
        Normal = {
          bg = colors.palette.bg_main,
        },
        -- 编辑器光标行
        CursorLine = {
          bg = colors.palette.bg_cursor,
        },
        -- 光标列颜色
        CursorColumn = {
          bg = colors.palette.bg_cursor,
        },
        -- 可视选择颜色
        Visual = {
          bg = colors.palette.bg_light,
        },
        -- 普通行号
        LineNr = {
          fg = colors.palette.fg_dim,      -- 使用次要文字颜色
          bg = colors.palette.bg_main,     -- 与主背景一致
        },
        -- 当前行行号（光标所在行）
        CursorLineNr = {
          fg = colors.palette.fg_bright,   -- 使用高亮文字颜色
          bg = colors.palette.bg_cursor,   -- 与光标行背景一致
          bold = true,                     -- 加粗突出
        },
        -- 标志列（行号左边的竖线区域）
        SignColumn = {
          fg = colors.palette.fg_dark,     -- 标志前景色
          bg = colors.palette.bg_main,     -- 与主背景一致
        },
        -- 窗口分界线
        WinSeparator = {
          fg = colors.semantic.separator,  -- 使用统一的分隔符颜色
          bg = "NONE",                     -- 透明背景
        },
        -- 折叠列
        FoldColumn = {
          fg = colors.palette.fg_dim,
          bg = colors.palette.bg_main,
        },
        
        -- ========== 诊断浮窗颜色覆盖 ==========
        -- 诊断浮窗背景
        NormalFloat = {
          fg = colors.palette.fg_main,
          bg = colors.diagnostic.float_bg,
        },
        -- 诊断浮窗边框
        FloatBorder = {
          fg = colors.diagnostic.float_border,
          bg = colors.diagnostic.float_bg,
        },
        -- 诊断错误颜色
        DiagnosticError = {
          fg = colors.diagnostic.error_text,
        },
        -- 诊断警告颜色
        DiagnosticWarn = {
          fg = colors.diagnostic.warning_text,
        },
        -- 诊断信息颜色
        DiagnosticInfo = {
          fg = colors.diagnostic.info_text,
        },
        -- 诊断提示颜色
        DiagnosticHint = {
          fg = colors.diagnostic.hint_text,
        },
        -- 诊断符号颜色
        DiagnosticSignError = {
          fg = colors.diagnostic.error_sign,
          bg = colors.palette.bg_main,
        },
        DiagnosticSignWarn = {
          fg = colors.diagnostic.warning_sign,
          bg = colors.palette.bg_main,
        },
        DiagnosticSignInfo = {
          fg = colors.diagnostic.info_sign,
          bg = colors.palette.bg_main,
        },
        DiagnosticSignHint = {
          fg = colors.diagnostic.hint_sign,
          bg = colors.palette.bg_main,
        },
      },
    })
    vim.cmd("colorscheme ayu")

    -- NvimTree 颜色覆盖 (使用统一的色值管理)
    vim.cmd(string.format([[
        " File Explorer 标题样式
        :hi FileExplorerTitle    guibg=%s guifg=%s gui=bold

        " 背景和窗口颜色
        :hi NvimTreeNormal       guibg=%s
        :hi NvimTreeEndOfBuffer  guifg=%s
        :hi NvimTreeWinSeparator guifg=%s guibg=%s

        " 文件类型颜色
        :hi NvimTreeExecFile     guifg=%s
        :hi NvimTreeSpecialFile  guifg=%s gui=underline
        :hi NvimTreeSymlink      guifg=%s gui=italic
        :hi link NvimTreeImageFile Title

        " 文件夹和文件颜色
        :hi NvimTreeFolderIcon   guifg=%s
        :hi NvimTreeFolderName   guifg=%s
        :hi NvimTreeOpenedFolderName guifg=%s
        :hi NvimTreeRootFolder   guifg=%s gui=bold
        :hi NvimTreeIndentMarker guifg=%s

        " Git 状态颜色
        :hi NvimTreeGitDirty     guifg=%s
        :hi NvimTreeGitStaged    guifg=%s
        :hi NvimTreeGitNew       guifg=%s
        :hi NvimTreeGitDeleted   guifg=%s
        :hi NvimTreeGitIgnored   guifg=%s

        " 光标和选择
        :hi NvimTreeCursorLine   guibg=%s
    ]],
      -- 标题样式
      colors.palette.bg_main,
      colors.nvimtree.folder_icon,

      -- 背景和分离器
      colors.nvimtree.bg,
      colors.nvimtree.bg,
      colors.nvimtree.separator_fg,
      colors.nvimtree.bg,

      -- 文件类型
      colors.nvimtree.file_executable,
      colors.nvimtree.file_special,
      colors.nvimtree.file_symlink,

      -- 文件夹和文件
      colors.nvimtree.folder_icon,
      colors.nvimtree.folder_name,
      colors.nvimtree.folder_opened,
      colors.nvimtree.folder_root,
      colors.nvimtree.indent_marker,

      -- Git 状态
      colors.nvimtree.git_dirty,
      colors.nvimtree.git_staged,
      colors.nvimtree.git_new,
      colors.nvimtree.git_deleted,
      colors.nvimtree.git_ignored,

      -- UI 元素
      colors.nvimtree.cursor_line
    ))
  end,
}
