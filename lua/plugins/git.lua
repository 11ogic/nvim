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
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter_opts = {
          relative_time = false,
        },
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
        yadm = {
          enable = false,
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- 导航
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, desc = "下一个 Git 变更" })

          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, desc = "上一个 Git 变更" })

          -- 动作
          map("n", "<leader>hs", gs.stage_hunk, { desc = "暂存变更" })
          map("n", "<leader>hr", gs.reset_hunk, { desc = "重置变更" })
          map("v", "<leader>hs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "暂存选定变更" })
          map("v", "<leader>hr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "重置选定变更" })
          map("n", "<leader>hS", gs.stage_buffer, { desc = "暂存所有变更" })
          map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "撤销暂存变更" })
          map("n", "<leader>hR", gs.reset_buffer, { desc = "重置所有变更" })
          map("n", "<leader>hp", gs.preview_hunk, { desc = "预览变更" })
          map("n", "<leader>hb", function()
            gs.blame_line({ full = true })
          end, { desc = "显示 Git blame" })
          map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "切换行 blame" })
          map("n", "<leader>hd", gs.diffthis, { desc = "显示 Git diff" })
          map("n", "<leader>hD", function()
            gs.diffthis("~")
          end, { desc = "显示与 HEAD 的 Git diff" })
          map("n", "<leader>td", gs.toggle_deleted, { desc = "切换删除显示" })
        end,
      })
    end,
  },

  -- Fugitive（Git命令集成）
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull" },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git 状态" },
      { "<leader>gb", "<cmd>Gblame<cr>", desc = "Git blame" },
    },
  },
}