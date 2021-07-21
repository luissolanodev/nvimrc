local telescope = require("telescope")
telescope.load_extension("media_files")
telescope.setup()
local api = vim.api
api.nvim_set_keymap("n", "<C-p>", "<cmd>lua require('telescope.builtin').find_files()<CR>", {noremap = true})
api.nvim_set_keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>", {noremap = true})
api.nvim_set_keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>", {noremap = true})
api.nvim_set_keymap("n", "<leader>fc", "<cmd>lua require('telescope.builtin').commands()<CR>", {noremap = true})
