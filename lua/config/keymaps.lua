-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local del_map = vim.keymap.del

map("n", "<C-j>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<C-k>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<C-x>", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })
--
-- with <leader>j/<leader>k to safely move lines up/down
-- map("n", "N", ":m .+1<CR>==", { desc = "Move line down", remap = true, silent = true })
-- map("n", "P", ":m .-2<CR>==", { desc = "Move line up", remap = true, silent = true })

-- Remove Alt+j / Alt+k mappings because they are accidentally triggered
-- when pressing <Esc> followed by j or k quickly (common in terminal Neovim)
del_map("n", "<A-j>")
del_map("n", "<A-k>")
