-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end
-- Format on save
local async_formatting = function(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()

    vim.lsp.buf_request(
        bufnr,
        "textDocument/formatting",
        vim.lsp.util.make_formatting_params({}),
        function(err, res, ctx)
            if err then
                local err_msg = type(err) == "string" and err or err.message
                -- you can modify the log message / level (or ignore it completely)
                vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
                return
            end

            -- don't apply results if buffer is unloaded or has been modified
            if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
                return
            end

            if res then
                local client = vim.lsp.get_client_by_id(ctx.client_id)
                vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
                vim.api.nvim_buf_call(bufnr, function()
                    vim.cmd("silent noautocmd update")
                end)
            end
        end
    )
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local buf_opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, buf_opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, buf_opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, buf_opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, buf_opts)
    vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, buf_opts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, buf_opts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, buf_opts)
    vim.keymap.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, buf_opts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, buf_opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, buf_opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, buf_opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, buf_opts)
    vim.keymap.set("n", "<leader>f", function()
        async_formatting(bufnr)
    end, buf_opts)

    -- Highlight symbol under cursor
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
        vim.api.nvim_clear_autocmds({
            buffer = bufnr,
            group = "lsp_document_highlight",
        })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = "lsp_document_highlight",
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            group = "lsp_document_highlight",
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end

    if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
    end

    -- Format on save
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePost", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                async_formatting(bufnr)
            end,
        })
    end

    -- Disable semantic highlighting from LSP server causing highlight color flickering
    client.server_capabilities.semanticTokensProvider = nil
end

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "tsserver", "tailwindcss", "jsonls", "jdtls", "prismals" },
    automatic_installation = true,
})

local lspconfig = require("lspconfig")

-- Set up lspconfig for cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local general_lsp_config = { on_attach = on_attach, capabilities = capabilities }

lspconfig["lua_ls"].setup(vim.tbl_extend("error", general_lsp_config, {
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { enable = true, globals = { "vim" } },
        },
    },
}))

local null_ls = require("null-ls")

null_ls.setup({
    on_attach = on_attach,
    sources = {
        null_ls.builtins.formatting.prettierd.with({
            dynamic_command = require("null-ls.helpers.command_resolver").from_node_modules(),
        }),
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.diagnostics.eslint_d,
    },
})

lspconfig["tsserver"].setup(general_lsp_config)

lspconfig["tailwindcss"].setup(general_lsp_config)

lspconfig["jsonls"].setup(general_lsp_config)

lspconfig["html"].setup(general_lsp_config)

lspconfig["jdtls"].setup(general_lsp_config)

lspconfig["prismals"].setup(general_lsp_config)

lspconfig["clangd"].setup(general_lsp_config)

lspconfig["astro"].setup(general_lsp_config)

-- Customizing how diagnostics are displayed
vim.diagnostic.config({
    virtual_text = {
        source = "if_many",
        -- prefix = ' '
        prefix = "💀",
        spacing = 0,
    },
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = false,
})

-- Change diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
