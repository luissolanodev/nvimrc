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

-- Scroll the gitsigns blame popup (<leader>ghb) with <C-d>/<C-u> without
-- leaving the cursor in the code buffer, matching Telescope's preview scroll.
-- Relies on gitsigns tagging its popup window via vim.w[winid].gitsigns_preview.
local function gitsigns_blame_winid()
  for _, winid in ipairs(vim.api.nvim_list_wins()) do
    if vim.w[winid].gitsigns_preview == "blame" then
      return winid
    end
  end
end

for _, key in ipairs({ "<C-d>", "<C-u>" }) do
  map("n", key, function()
    local keys = vim.api.nvim_replace_termcodes(key, true, false, true)
    local winid = gitsigns_blame_winid()
    if winid then
      vim.api.nvim_win_call(winid, function()
        vim.cmd("normal! " .. keys)
      end)
    else
      vim.cmd("normal! " .. keys)
    end
  end, { desc = "Scroll down/up (or Gitsigns blame popup)" })
end
