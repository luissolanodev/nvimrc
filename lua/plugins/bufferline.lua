vim.keymap.set('n', '<C-j>', '<cmd>BufferLineCyclePrev<CR>',
               {noremap = true, silent = true})
vim.keymap.set('n', '<C-k>', '<cmd>BufferLineCycleNext<CR>',
               {noremap = true, silent = true})

require('bufferline').setup {
    options = {
        offsets = {
            {
                filetype = 'NvimTree',
                text = 'Nvim tree',
                text_align = 'center',
                highlight = 'FileExplorer'
            }
        },
        separator_style = 'slant'
    },
    highlights = require('rose-pine.plugins.bufferline')
    -- highlights = require('catppuccin.groups.integrations.bufferline').get()
}
vim.cmd('hi FileExplorer gui=bold,italic')
