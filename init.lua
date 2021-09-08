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
opt.colorcolumn = { '80' }
opt.showtabline = 2
opt.encoding = 'utf-8'
opt.hidden = true
opt.list = true
opt.listchars = { eol = '$' }
opt.fillchars = { vert = '┊', eob = ' ' }
opt.termguicolors = true
vim.g.mapleader = ','
require("plugins")
