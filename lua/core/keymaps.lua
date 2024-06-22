vim.g.mapleader = " "

local keymap = vim.keymap

local mode_nv = { "n", "v" }
local mode_v = { "v" }
local mode_i = { "i" }
local nmappings = {
  -- edit
  { from = "J", to = ":m '>+1<CR>gv=gv", mode = mode_v },
  { from = "K", to = ":m '<-2<CR>gv=gv", mode = mode_v },
  { from = "<leader>sv", to = "<C-w>v", mode = mode_nv },
  { from = "<leader>sh", to = "<C-w>s", mode = mode_nv },
  { from = "<leader>nh", to = ":nohl<CR>", mode = mode_nv },
  -- pborad
  { from = "<leader>y", to = "\"+y", mode = mode_nv },
  { from = "<leader>p", to = "\"+p", mode = mode_nv },
  -- file
  { from = "<leader>q", to = ":q<CR>", mode = mode_nv },
  { from = "<leader>w", to = ":w<CR>", mode = mode_nv },
  { from = "<leader>x", to = ":x<CR>", mode = mode_nv },
  -- plugin
  { from = "<leader>e", to = ":NvimTreeToggle<CR>", mode = mode_nv },
}

for _, mapping in ipairs(nmappings) do
  vim.keymap.set(mapping.mode or "n", mapping.from, mapping.to, { noremap = true })
end
