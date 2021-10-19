local g = vim.g
g.nvim_tree_indent_markers = 1 -- 0 by default, this option shows indent markers when folders are open
g.nvim_tree_root_folder_modifier = ':t' -- ':~' This is the default. See :help filename-modifiers for more options
g.nvim_tree_group_empty = 1 -- 0 by default, compact folders that only contain a single folder into one node in the file tree
g.nvim_tree_git_hl = 1 -- 0 by default, will enable file highlight for git attributes (can be used without the icons).
g.nvim_tree_add_trailing = 1 --  by default, append a trailing slash to folder names

require("nvim-tree").setup {
   -- hijack the cursor in the tree to put it at the start of the filename
   hijack_cursor = true,
   -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
   update_cwd = true,
   -- show lsp diagnostics in the signcolumn
   diagnostics = {
      enable = true,
      icons = {
         hint = "",
         info = "",
         warning = "",
         error = "",
      }
   },
   -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
   update_focused_file = {
      -- enables the feature
      enable = true,
      -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
      -- only relevant when `update_focused_file.enable` is true
      update_cwd  = true,
      -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
      -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
      ignore_list = {}
   },
}
vim.api.nvim_set_keymap("n", "<leader>n", "<cmd>NvimTreeToggle<CR>", {noremap = true})
