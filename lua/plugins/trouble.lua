require("trouble").setup()

local api = vim.api
api.nvim_set_keymap("n", "<Leader>xx", "<cmd>Trouble<CR>", {noremap = true, silent = true})
api.nvim_set_keymap("n", "<Leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<CR>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<CR>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<CR>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<CR>", {silent = true, noremap = true})
