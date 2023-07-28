local keymap = vim.keymap.set

-- left aligned fixed size box with left aligned text
keymap("n", "<Leader>bb", "<Cmd>lua require('comment-box').lbox()<CR>", {})
keymap("v", "<Leader>bb", "<Cmd>lua require('comment-box').lbox()<CR>", {})

-- centered adapted box with centered text
keymap("n", "<Leader>bc", "<Cmd>lua require('comment-box').accbox()<CR>", {})
keymap("v", "<Leader>bc", "<Cmd>lua require('comment-box').accbox()<CR>", {})

-- centered line
keymap("n", "<Leader>bl", "<Cmd>lua require('comment-box').cline()<CR>", {})
keymap("i", "<M-l>", "<Cmd>lua require('comment-box').cline()<CR>", {})
