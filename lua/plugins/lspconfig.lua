local nvim_lsp = require('lspconfig')

local border = {
   {"🭽", "FloatBorder"},
   {"▔", "FloatBorder"},
   {"🭾", "FloatBorder"},
   {"▕", "FloatBorder"},
   {"🭿", "FloatBorder"},
   {"▁", "FloatBorder"},
   {"🭼", "FloatBorder"},
   {"▏", "FloatBorder"},
}
local on_attach = function(client, bufnr)
   local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
   local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

   vim.lsp.handlers["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border})
   vim.lsp.handlers["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border})
   buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

   -- Mappings
   local opts = { noremap = true, silent = true }
   buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
   buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
   buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
   buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
   buf_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
   buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
   buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
   buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
   buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
   buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
   buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
   buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
   buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
   buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
   buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
   buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
   buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

   -- Set autocommands conditional on server_capabilities
   if client.resolved_capabilities.document_highlight then
      vim.cmd[[
      augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]]
   end

   require("lsp_signature").on_attach()
end

-- Config that activates keymaps and enables snippet support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
   properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
   }
}

-- -- Lightbulb for code actions
-- vim.cmd[[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]

-- Lsp-install
local function setup_servers()
   require('lspinstall').setup()
   local servers = require("lspinstall").installed_servers()
   for _, server in pairs(servers) do
      local config = {
         -- enable snippet support
         capabilities = capabilities,
         -- map buffer local keybindings when the language server attaches
         on_attach = on_attach
      }

      -- Language specific config
      if server == "lua" then
         config.settings = {
            Lua = {
               diagnostics = {
                  globals = { "vim" }
               }
            }
         }
      end
      if server == "diagnosticls" then
         config = {
            filetypes = {
               "javascript",
               "javascript.jsx",
               "typescript",
               "typescript.tsx"
            },
            init_options = {
               filetypes = {
                  javascript = "eslint",
                  javascriptreact = "eslint",
                  typescript = "eslint",
                  ["javascript.jsx"] = "eslint",
                  typescriptreact = "eslint"
               },
               linters = {
                  eslint = {
                     command = "./node_modules/.bin/eslint",
                     rootPatterns = { ".eslintrc", ".eslintrc.json", "package.json" },
                     debounce = 100,
                     args = {
                        "--stdin",
                        "--stdin-filename",
                        "%filepath",
                        "--format",
                        "json"
                     },
                     sourceName = "eslint",
                     parseJson = {
                        errorsRoot = "[0].messages",
                        line = "line",
                        column = "column",
                        endLine = "endLine",
                        endColumn = "endColumn",
                        message = "${message} [${ruleId}]",
                        security = "severity",
                     };
                     securities = {
                        [2] = "error",
                        [1] = "warning"
                     }
                  }
               },
               formatters = {
                  prettier = {
                     command = "./node_modules/.bin/prettier",
                     args = {
                        "--stdin-filepath",
                        "%filepath"
                     },
                     rootPatterns = {
                        ".prettierrc",
                        ".prettierrc.json",
                        ".prettierrc.toml",
                        ".prettierrc.json",
                        ".prettierrc.yml",
                        ".prettierrc.yaml",
                        ".prettierrc.json5",
                        ".prettierrc.js",
                        ".prettierrc.cjs",
                        "prettier.config.js",
                        "prettier.config.cjs"
                     }
                  }
               },
               formatFiletypes = {
                  javascript = "prettier",
                  javascriptreact = "prettier",
                  typescript = "prettier",
                  ["typescript.tsx"] = "prettier"
               }
            }
         }
      end
      nvim_lsp[server].setup(config)
   end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require("lspinstall").post_install_hook = function()
   setup_servers() -- reload installed servers
   vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

-- Visuals

-- Signs displayed for diagnostics
local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
   local hl = "LspDiagnosticsSign" .. type
   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
-- Icons displayed in autocompletion for LSP
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

local kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(kinds) do
   kinds[i] = icons[kind] and icons[kind] .. kind or kind
end

-- Change square icon for a circle when showing diagnostic on virtual text
vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, _, params, client_id, _)
   local config = {
      underline = true,
      virtual_text = {
         prefix = "● ",
         spacing = 0,
      },
      signs = true,
      update_in_insert = true, -- set this to true if you want diagnostics to show in insert mode
   }
   local uri = params.uri
   local bufnr = vim.uri_to_bufnr(uri)

   if not bufnr then
      return
   end

   local diagnostics = params.diagnostics

   for i, v in ipairs(diagnostics) do
      diagnostics[i].message = string.format("%s: %s", v.source, v.message)
   end

   vim.lsp.diagnostic.save(diagnostics, bufnr, client_id)

   if not vim.api.nvim_buf_is_loaded(bufnr) then
      return
   end

   vim.lsp.diagnostic.display(diagnostics, bufnr, client_id, config)
end

--  Only show the most severe item in the gutter per line --
-- local orig_set_signs = vim.lsp.diagnostic.set_signs
-- local set_signs_limited = function(diagnostics, bufnr, client_id, sign_ns, opts)
-- if not diagnostics then
-- diagnostics = diagnostic_cache[bufnr][client_id]
-- end
-- if not diagnostics then
-- return
-- end
-- local max_severity_per_line = {}
-- for _,d in pairs(diagnostics) do
-- if max_severity_per_line[d.range.start.line] then
-- local current_d = max_severity_per_line[d.range.start.line]
-- if d.severity < current_d.severity then
-- max_severity_per_line[d.range.start.line] = d
-- end
-- else
-- max_severity_per_line[d.range.start.line] = d
-- end
-- end
-- local filtered_diagnostics = {}
-- for i,v in pairs(max_severity_per_line) do
-- table.insert(filtered_diagnostics, v)
-- end
-- orig_set_signs(filtered_diagnostics, bufnr, client_id, sign_ns, opts)
-- end
-- vim.lsp.diagnostic.set_signs = set_signs_limited
