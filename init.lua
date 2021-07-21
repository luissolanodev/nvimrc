local opt = vim.opt

opt.compatible = false
opt.history = 1000
opt.swapfile = false
opt.backup = false

opt.autoindent = true

opt.undofile = true
opt.undodir = "~/.config/nvim/undodir"

opt.guicursor = ""
opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.splitbelow = true
opt.splitright = true

opt.colorcolumn = "80"
opt.laststatus = 2
opt.showtabline = 2

opt.encoding = "utf-8"
opt.backspace = "indent,eol,start"
opt.hidden = true

opt.fillchars = "vert:┊"
opt.wildmenu = true
opt.termguicolors = true
opt.completeopt = "menuone,noselect"

vim.g.mapleader=","
vim.b.tex_flavor = "latex"

require("plugins")
