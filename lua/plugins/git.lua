return {
  -- Git集成
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = true,
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
        on_attach = function(bufnr)
          if _G.setup_gitsigns_keymaps then
            _G.setup_gitsigns_keymaps(bufnr)
          end
        end,
      })
    end,
  },

  -- Fugitive（Git命令集成）
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull" },
  },

  -- Lazygit
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      -- 浮窗设置
      vim.g.lazygit_floating_window_scaling_factor = 0.77
      vim.g.lazygit_floating_window_winblend = 0
      vim.g.lazygit_use_neovim_remote = true

      -- LazyGit 关闭后刷新 Git 状态
      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit*",
        callback = function()
          -- 延迟执行，确保 LazyGit 完全关闭
          vim.defer_fn(function()
            -- 刷新 gitsigns
            if pcall(require, "gitsigns") then
              require("gitsigns").refresh()
            end
            -- 刷新所有缓冲区的 Git 状态
            vim.cmd("checktime")
            -- 如果有状态栏插件，也刷新状态栏
            if vim.fn.exists(":LualineRefresh") == 2 then
              vim.cmd("LualineRefresh")
            end
          end, 100)
        end,
        desc = "LazyGit 关闭后刷新 Git 状态"
      })
    end,
  },
}
