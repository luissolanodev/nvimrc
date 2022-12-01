local nvim_lsp = require("lspconfig")

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)

   -- Set autocommands for highlighting references
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      }
      vim.diagnostic.open_float(nil, opts)
    end
  })

   require("lsp_signature").on_attach()
end

-- The nvim-cmp almost supports LSP's capabilities so you should advertise it to LSP servers..
local capabilities = require("cmp_nvim_lsp").default_capabilities()

----------------------------------------------------------------------
--                           LSP-INSTALL                            --
--                  Set configuration for servers                   --
----------------------------------------------------------------------
require("mason").setup {
  providers = {
    "mason.providers.client",
    -- "mason.providers.registry-api" -- This is the default provider. You can still include it here if you want, as a fallback to the client provider.
  }
}
require("mason-lspconfig").setup()

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
nvim_lsp.efm.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
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

}

nvim_lsp.lua.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = { diagnostics = { globals = { "vim" } } }
  }
}

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
