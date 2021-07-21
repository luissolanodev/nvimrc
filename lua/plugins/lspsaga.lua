require("lspsaga").init_lsp_saga {
   use_saga_diagnostic_sign = true,
   error_sign = '',
   warn_sign = '',
   hint_sign = '',
   infor_sign = '',
   dianostic_header_icon = '   ',
   code_action_icon = ' ',
   code_action_prompt = {
      enable = true,
      sign = true,
      sign_priority = 20,
      virtual_text = true,
   },
   finder_definition_icon = '  ',
   finder_reference_icon = '  ',
   max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
   finder_action_keys = {
      open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
   },
   code_action_keys = {
      quit = 'q',exec = '<CR>'
   },
   rename_action_keys = {
      quit = '<C-c>',exec = '<CR>'  -- quit can be a table
   },
   definition_preview_icon = '  ',
   border_style = "round",
   rename_prompt_prefix = '➤',
}

local api = vim.api
-- lsp provider to find the cursor word definition and reference
api.nvim_set_keymap("n", "gh", ":Lspsaga lsp_finder<CR>", {noremap = true, silent = true})
-- code action
api.nvim_set_keymap("n", "ca", ":Lspsaga code_action<CR>", {noremap = true, silent = true})
api.nvim_set_keymap("v", "<Leader>ca", ":<C-U>Lspsaga range_code_action<CR>", {noremap = true, silent = true})
-- show hover doc
api.nvim_set_keymap("n", "K", ":Lspsaga hover_doc<CR>", {noremap = true, silent = true})
-- scroll down hover doc or scroll in definition preview
api.nvim_set_keymap("n", "<C-f>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", {noremap = true, silent = true})
-- scroll up hover doc
api.nvim_set_keymap("n", "<C-b>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", {noremap = true, silent = true})
-- show signature help
api.nvim_set_keymap("n", "gs", ":Lspsaga signature_help<CR>", {noremap = true, silent = true})
-- rename
api.nvim_set_keymap("n", "gr", ":Lspsaga rename<CR>", {noremap = true, silent = true})
-- close rename win use <C-c> in insert mode or `q` in noremal mode or `:q`

-- Jump Diagnostic and Show Diagnostics
-- show
api.nvim_set_keymap("n", "<Leader>cd", ":Lspsaga show_line_diagnostics<CR>", {noremap = true, silent = true})
-- only show diagnostic if cursor is over the area
api.nvim_set_keymap("n", "<Leader>cc", "<cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>", {noremap = true, silent = true})
-- jump diagnostic
api.nvim_set_keymap("n", "[e", ":Lspsaga diagnostic_jump_next<CR>", {noremap = true, silent = true})
api.nvim_set_keymap("n", "]e", ":Lspsaga diagnostic_jump_prev<CR>", {noremap = true, silent = true})
