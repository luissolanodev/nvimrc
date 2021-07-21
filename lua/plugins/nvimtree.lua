vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_add_trailing = 1
vim.g.nvim_tree_lsp_diagnostics = 1
vim.g.nvim_tree_highlight_opened_files = 1
vim.api.nvim_set_keymap("n", "<leader>n", "<cmd>NvimTreeToggle<CR>", {noremap = true})
