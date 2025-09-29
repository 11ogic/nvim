return {
    -- Telescope (模糊查找)
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")

            telescope.setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                            ["<ESC>"] = actions.close,
                        },
                        n = {
                            ["<ESC>"] = actions.close,
                        },
                    },
                    -- ignore files
                    file_ignore_patterns = {
                        "node_modules",
                        "dist",
                        "build",
                        ".git",
                        "__pycache__",
                        ".DS_Store",
                    },
                    hidden = false, -- show hidden files
                    follow = false, -- follow symlinks
                },
                pickers = {
                    find_files = {
                        -- 查找文件时的特定选项
                        hidden = false, -- show hidden files
                        follow = false, -- follow symlinks
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                },
            })

            telescope.load_extension("fzf")

            -- 键盘映射已移至 lua/core/keymaps.lua 文件中统一管理
        end,
    },
}
