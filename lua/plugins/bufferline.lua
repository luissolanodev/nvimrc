local api = vim.api
api.nvim_set_keymap("n", "<C-j>", "<cmd>BufferLineCyclePrev<CR>", {noremap = true, silent = true})
api.nvim_set_keymap("n", "<C-k>", "<cmd>BufferLineCycleNext<CR>", {noremap = true, silent = true})

require("bufferline").setup {
   options = {
      offsets = {{filetype = "NvimTree", text = "File Explorer", highlight = "FileExplorer"}}
   }
}
vim.cmd("highlight FileExplorer gui=bold,italic")
