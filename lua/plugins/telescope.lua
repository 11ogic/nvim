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
              ["<leader>q"] = actions.close,
            },
            n = {
              ["<leader>q"] = actions.close,
            },
          },
          -- ignore files
          file_ignore_patterns = {
            "node_modules",
            "dist",
            "build",
            ".git",
            "__pycache__",
          },
          hidden = false, -- show hidden files
          follow = false, -- follow symlinks
        },
        pickers = {
          find_files = {
            -- 查找文件时的特定选项
            hidden = false, -- show hidden files
            follow = false, -- follow symlinks
          }
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

      -- 键盘映射
      local keymap = vim.keymap
      -- Basic Search
      keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "查找文件" })
      keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "通过Grep查找" })
      keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "查找缓冲区" })
      keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "查找帮助" })
      
      -- Advanced Search
      keymap.set("n", "<leader>fa", "<cmd>Telescope find_files hidden=true<cr>", { desc = "查找所有文件（包括隐藏文件）" })
      keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "查找当前单词" })
      keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "查找最近文件" })
    end,
  },
}