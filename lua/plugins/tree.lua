-- For complete list of available configuration options see :help nvim-tree-setup
require('nvim-tree').setup {
    renderer = {
        indent_markers = {enable = true},
        root_folder_label = ':t',
        group_empty = true,
        highlight_git = true,
        add_trailing = true,
        highlight_opened_files = 'all'
    },
    sync_root_with_cwd = true,
    diagnostics = {enable = true, show_on_dirs = true},
    update_focused_file = {enable = true, update_cwd = true},
    view = {
        adaptive_size = true,
        centralize_selection = true,
        number = true,
        relativenumber = true
    }
}

vim.keymap.set('n', '<leader>n', '<cmd>NvimTreeToggle<CR>', {noremap = true})
