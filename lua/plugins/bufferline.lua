local api = vim.api
api.nvim_set_keymap("n", "<C-j>", "<cmd>BufferLineCyclePrev<CR>", {noremap = true, silent = true})
api.nvim_set_keymap("n", "<C-k>", "<cmd>BufferLineCycleNext<CR>", {noremap = true, silent = true})

require("bufferline").setup {
   options = {
      offsets = {
         {
            filetype = "NvimTree",
            text = "Nvim tree",
            highlight = "FileExplorer"
         }
      },
      separator_style = 'slant'
   }
}
vim.cmd("hi FileExplorer gui=bold,italic")
