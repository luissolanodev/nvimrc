local opt = vim.opt

opt.history = 1000
opt.swapfile = false
opt.updatetime = 750
opt.undofile = true
opt.guicursor = ''
opt.cursorline = true
opt.cursorcolumn = true
opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.splitbelow = true
opt.splitright = true
opt.colorcolumn = {'80'}
opt.showtabline = 2
opt.encoding = 'utf-8'
opt.hidden = true
opt.fillchars = {vert = '┊'}
opt.termguicolors = false
opt.wildmenu = true
opt.listchars:append('eol:$')

vim.g.mapleader = ','

vim.keymap.set('c', '<Left>', '<Space><BS><Left>', {noremap = true})
vim.keymap.set('c', '<Right>', '<Space><BS><Right>', {noremap = true})

require('plugins')
