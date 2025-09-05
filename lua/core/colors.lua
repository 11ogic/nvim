-- ========================================
-- 🎨 统一颜色管理 (Colors Management)
-- ========================================
-- 此文件统一管理整个 Neovim 配置中使用的所有颜色值
-- 便于维护和主题切换

local M = {}

-- ========== 基础调色板 (Base Palette) ==========
-- 基于 Ayu 主题的核心颜色
M.palette = {
    -- 背景色系
    bg_main = "#1c1c1c",      -- 主背景色
    bg_dark = "#0f1419",      -- Ayu 原始深色背景
    bg_light = "#1f2430",     -- 稍亮背景 (用于对比)
    bg_alt = "#181818",       -- 替代背景色
    bg_very_dark = "#0d0d0d", -- 极深背景色
    bg_separator = "#1c1c1c", -- 分离器背景
    bg_cursor = "#202020",    -- 光标行/列背景

    -- 前景色系
    fg_main = "#bfbdb6",   -- 主要文字颜色
    fg_dim = "#5c6773",    -- 次要文字颜色
    fg_bright = "#ffffff", -- 高亮文字颜色
    fg_muted = "#808080",  -- 静音文字颜色
    fg_dark = "#3e4451",   -- 深色文字

    -- Ayu 主题色
    blue = "#39bae6",   -- 蓝色 (Normal模式, 文件夹)
    green = "#c2d94c",  -- 绿色 (Insert模式, Git新增)
    yellow = "#ffb454", -- 黄色 (Command模式, 警告)
    orange = "#ff8f40", -- 橙色 (修改指示)
    red = "#f07178",    -- 红色 (Replace模式, 错误)
    purple = "#d2a6ff", -- 紫色 (Visual模式, 根目录)
    cyan = "#95e6cb",   -- 青色 (符号链接, 提示)

    -- 扩展颜色
    pink = "#ff80ff",      -- 粉色 (特殊文件)
    light_red = "#ffa0a0", -- 浅红色 (可执行文件)
    gold = "#e5c07b",      -- 金色 (打开的文件夹)
    coral = "#e06c75",     -- 珊瑚色 (根文件夹)
}

-- ========== 语义化颜色 (Semantic Colors) ==========
-- 基于用途的颜色定义，便于理解和使用
M.semantic = {
    -- 状态颜色
    success = M.palette.green,
    warning = M.palette.yellow,
    error = M.palette.red,
    info = M.palette.blue,
    hint = M.palette.cyan,

    -- 模式颜色
    normal = M.palette.blue,
    insert = M.palette.green,
    visual = M.palette.purple,
    replace = M.palette.red,
    command = M.palette.yellow,

    -- Git 状态颜色
    git_added = M.palette.green,
    git_modified = M.palette.orange,
    git_deleted = M.palette.red,
    git_renamed = M.palette.purple,
    git_ignored = M.palette.fg_dim,

    -- 文件类型颜色
    folder = M.palette.blue,
    file_normal = M.palette.fg_main,
    file_opened = M.palette.green,
    file_executable = M.palette.light_red,
    file_special = M.palette.pink,
    file_symlink = M.palette.cyan,
    file_image = M.palette.purple,

    -- UI 元素颜色
    separator = M.palette.fg_dark,
    border = M.palette.fg_dark,
    selection = M.palette.bg_light,
    highlight = M.palette.bg_cursor,
}

-- ========== 组件颜色配置 (Component Colors) ==========

-- Lualine 颜色主题
M.lualine = {
    bg = M.palette.bg_cursor,        -- 状态栏背景
    fg = M.palette.fg_main,          -- 状态栏文字
    section_bg = M.palette.bg_light, -- 区段背景
}

-- Bufferline 颜色配置
M.bufferline = {
    fill_bg = M.palette.bg_main,        -- 整体背景
    active_bg = M.palette.bg_light,      -- 活动标签背景
    active_fg = M.palette.fg_bright,    -- 活动标签文字
    inactive_bg = M.palette.bg_alt,     -- 非活动标签背景
    inactive_fg = M.palette.fg_muted,   -- 非活动标签文字
    separator_fg = M.palette.separator, -- 分离器颜色
}

-- NvimTree 颜色配置
M.nvimtree = {
    bg = M.palette.bg_alt,                 -- 文件树背景
    separator_bg = M.palette.bg_separator, -- 标题背景
    separator_fg = M.palette.separator,    -- 分离线颜色

    -- 文件夹颜色
    folder_icon = M.semantic.folder,
    folder_name = M.semantic.folder,
    folder_opened = M.palette.gold,
    folder_root = M.palette.coral,

    -- 文件颜色
    file_normal = M.semantic.file_normal,
    file_opened = M.semantic.file_opened,
    file_executable = M.semantic.file_executable,
    file_special = M.semantic.file_special,
    file_symlink = M.semantic.file_symlink,

    -- Git 状态
    git_dirty = M.semantic.git_modified,
    git_staged = M.semantic.git_added,
    git_new = M.semantic.git_added,
    git_deleted = M.semantic.git_deleted,
    git_ignored = M.semantic.git_ignored,

    -- UI 元素
    indent_marker = M.semantic.separator,
    cursor_line = M.semantic.selection,
}

-- Telescope 颜色配置
M.telescope = {
    border = M.semantic.border,
    selection = M.semantic.selection,
    match = M.semantic.warning,
}

-- ========== 实用函数 (Utility Functions) ==========

-- 获取十六进制颜色值 (去除 # 前缀)
function M.hex(color)
    if color:sub(1, 1) == "#" then
        return color:sub(2)
    end
    return color
end

-- 将颜色转换为 RGB 值
function M.hex_to_rgb(hex)
    hex = M.hex(hex)
    local r = tonumber(hex:sub(1, 2), 16)
    local g = tonumber(hex:sub(3, 4), 16)
    local b = tonumber(hex:sub(5, 6), 16)
    return r, g, b
end

-- 调整颜色亮度 (factor: -1.0 到 1.0)
function M.lighten(color, factor)
    local r, g, b = M.hex_to_rgb(color)
    factor = math.max(-1, math.min(1, factor))

    if factor > 0 then
        r = r + (255 - r) * factor
        g = g + (255 - g) * factor
        b = b + (255 - b) * factor
    else
        factor = -factor
        r = r * (1 - factor)
        g = g * (1 - factor)
        b = b * (1 - factor)
    end

    return string.format("#%02x%02x%02x",
        math.floor(r), math.floor(g), math.floor(b))
end

-- 创建颜色变体
function M.variants(base_color)
    return {
        base = base_color,
        light = M.lighten(base_color, 0.2),
        lighter = M.lighten(base_color, 0.4),
        dark = M.lighten(base_color, -0.2),
        darker = M.lighten(base_color, -0.4),
    }
end

-- ========== 主题切换支持 (Theme Switching Support) ==========

-- 暗色主题 (当前默认)
M.dark_theme = {
    bg = M.palette.bg_main,
    fg = M.palette.fg_main,
    accent = M.palette.blue,
}

-- 预留: 亮色主题配置
M.light_theme = {
    bg = "#ffffff",
    fg = "#2d3748",
    accent = M.palette.blue,
}

-- 获取当前主题颜色
function M.current_theme()
    -- 这里可以根据 vim.o.background 或其他条件返回不同主题
    return M.dark_theme
end

-- ========== 导出所有颜色 (Export All Colors) ==========

-- 为了向后兼容，导出常用的颜色值
M.main = M.palette.bg_main
M.background = M.palette.bg_main
M.foreground = M.palette.fg_main
M.accent = M.palette.blue

return M
