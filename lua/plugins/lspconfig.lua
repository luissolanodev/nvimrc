local nvim_lsp = require("lspconfig")

----------------------------------------------------------------------
--            Define on_attach function and capabilities            --
----------------------------------------------------------------------

local on_attach = function(client, bufnr)
   local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
   end
   local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
   end

   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

   -- Mappings
   local opts = { noremap = true, silent = true }
   buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
   buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
   buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
   buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
   buf_set_keymap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
   buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
   buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
   buf_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
   buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
   buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
   buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
   buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
   buf_set_keymap("n", "<leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
   buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
   buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
   buf_set_keymap("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
   buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

   -- Set autocommands for highlighting references
   if client.resolved_capabilities.document_highlight then
      vim.cmd([[
      augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]])
   end

   require("lsp_signature").on_attach()
end

-- The nvim-cmp almost supports LSP's capabilities so you should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

----------------------------------------------------------------------
--                           LSP-INSTALL                            --
--                  Set configuration for servers                   --
----------------------------------------------------------------------
local function setup_servers()
   require("lspinstall").setup()
   local servers = require("lspinstall").installed_servers()
   for _, server in pairs(servers) do
      local config = {
         -- Enable snippet support
         capabilities = capabilities,
         -- Map buffer local keybindings when the language server attaches
         on_attach = on_attach,
      }

      -- TODO: Move specific config to its own file
      -- Language specific config
      if server == "lua" then
         local lua = {
            settings = { Lua = { diagnostics = { globals = { "vim" } } } },
         }
         config = vim.tbl_extend("force", config, lua)
      end
      if server == "efm" then
         local eslint = {
            lintCommand = "./node_modules/.bin/eslint -f unix --stdin --stdin-filename ${INPUT}",
            lintIgnoreExitCode = true,
            lintStdin = true,
            lintFormats = { "%f:%l:%c: %m" },
            rootMarkers = {
               ".eslintrc",
               ".eslintrc.json",
               ".eslintrc.js",
               "package.json"
            }
         }
         local prettier = {
            formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}",
            formatStdin = true,
            rootMarkers = {
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
               "prettier.config.cjs",
               "package.json"
            }
         }

         config = {
            filetypes = {
               "lua",
               "javascript",
               "javascriptreact",
               "typescript",
               "typescriptreact"
            },
            init_options = {
               documentFormatting = true,
            },
            settings = {
               rootMarkers = { ".git/" },
               languages = {
                  lua = {
                     {
                        formatCommand = "stylua",
                        formatStdin = true,
                     },
                  },
                  javascript = { eslint, prettier },
                  typescriptreact = { eslint, prettier }
               },
            },
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

----------------------------------------------------------------------
--                             VISUALS                              --
----------------------------------------------------------------------

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

-- Signs displayed for diagnostics
local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
local hl = "LspDiagnosticsSign" .. type
vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Change display settings for diagnostics and show source
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
underline = true,
virtual_text = {
prefix = " ",
spacing = 0,
},
signs = true,
update_in_insert = true, -- set this to true if you want diagnostics to show in insert mode
})

-- Change display settings for diagnostics and show source
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, _, params, client_id, _)
-- local config = {
-- underline = true,
-- virtual_text = {
-- prefix = "● ",
-- spacing = 0,
-- },
-- signs = true,
-- update_in_insert = true, -- set this to true if you want diagnostics to show in insert mode
-- }
-- local uri = params.uri
-- local bufnr = vim.uri_to_bufnr(uri)

-- if not bufnr then
-- return
-- end

-- local diagnostics = params.diagnostics

-- for i, v in ipairs(diagnostics) do
-- diagnostics[i].message = string.format("%s: %s", v.source, v.message)
-- end

-- vim.lsp.diagnostic.save(diagnostics, bufnr, client_id)

-- if not vim.api.nvim_buf_is_loaded(bufnr) then
-- return
-- end

-- vim.lsp.diagnostic.display(diagnostics, bufnr, client_id, config)
-- end

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
