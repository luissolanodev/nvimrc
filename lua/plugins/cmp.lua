local cmp = require('cmp')
local luasnip = require('luasnip')
local fn = vim.fn
local api = vim.api


local function format_completion(entry, vim_item)
   -- local emojis = {
      -- Class = "📚",
      -- Color = "🎨",
      -- Constant = "🔐",
      -- Constructor = "🛠️ ",
      -- Enum = "⛓ ",
      -- EnumMember = "🔗",
      -- Field = "⭐",
      -- File = "📄",
      -- Folder = "📂",
      -- Function = "⚙️ ",
      -- Interface = "🔒",
      -- Keyword = "🔑",
      -- Method = "🔩",
      -- Module = "🧰",
      -- Property = "💎",
      -- Snippet = "⚡️",
      -- Struct = "🧱",
      -- Text = "✏️ ",
      -- Unit = "🪙",
      -- Value = "🎲",
      -- Variable = "📦",
   -- }
   local icons = {
      Class = " ",
      Color = " ",
      Constant = " ",
      Constructor = " ",
      Enum = "了 ",
      EnumMember = " ",
      Field = " ",
      File = " ",
      Folder = " ",
      Function = " ",
      Interface = "ﰮ ",
      Keyword = " ",
      Method = "ƒ ",
      Module = " ",
      Property = " ",
      Snippet = "﬌ ",
      Struct = " ",
      Text = " ",
      Unit = " ",
      Value = " ",
      Variable = " ",
   }
   local formatted_sources = {
      nvim_lsp = '[LSP]',
      buffer = '[Buffer]',
      luasnip = '[LuaSnip]',
      cmp_tabnine = '[TabNine]',
      nvim_lua = '[Lua]',
      calc = '[Calc]',
      path = '[Path]'
   }
   local kind, source = vim_item.kind, entry.source.name
   vim_item.kind = string.format('%s %s', icons[kind], kind)
      vim_item.menu = formatted_sources[source]
   return vim_item

end

local function expand_snippet(args)
   luasnip.lsp_expand(args.body)
end
local function tab_completion(fallback)
   if cmp.visible() then
      cmp.select_next_item()
   elseif luasnip.expand_or_jumpable() then
      fn.feedkeys(api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
   else
      fallback()
   end
end

local function shift_tab_completion(fallback)
   if cmp.visible() then
      cmp.select_prev_item()
   elseif luasnip.jumpable(-1) then
      fn.feedkeys(api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
   else
      fallback()
   end
end

local function get_trigger_characters(trigger_characters)
   local filter_characters =  function(char)
      return char ~= ' ' and char ~= '\t'
   end
   return vim.tbl_filter(filter_characters, trigger_characters)
end

cmp.setup {
   completion = {
      get_trigger_characters = get_trigger_characters
   },
   snippet = {
      expand = expand_snippet,
   },
   mapping = cmp.mapping.preset.insert({
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<Tab>'] = cmp.mapping(tab_completion, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(shift_tab_completion, { 'i', 's' }),
   }),

   window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
   },
   formatting = {
      format = format_completion
   },
   sources = cmp.config.sources({
      { name = 'luasnip' },
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'buffer' },
      { name = 'path' },
      { name = 'cmp_tabnine' },
      { name = 'calc' },
      { name = 'emoji' },
      { name = 'look' },
      { name = 'tmux' }
   })
}

cmp.event:on(
  'confirm_done',
  require('nvim-autopairs.completion.cmp').on_confirm_done()
)
--  require("nvim-autopairs.completion.cmp").setup {
   --  map_cr = true, --  map <CR> on insert mode
   --  map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
   --  auto_select = false, -- automatically select the first item
   --  insert = false, -- use insert confirm behavior instead of replace
   --  map_char = { -- modifies the function or method delimiter by filetypes
      --  all = '(',
      --  tex = '{'
   --  }
--  }
