-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    -- vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)

    -- Attach navic to active buffer.
    if client.server_capabilities.documentSymbolProvider then
        local navic = require("nvim-navic")
        navic.setup({
            highlight = true,
            separator = '  ',
        })
        navic.attach(client, bufnr)
    end
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}
require'lspconfig'.clangd.setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require'lspconfig'.pyright.setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require'lspconfig'.tsserver.setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require'lspconfig'.rust_analyzer.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings
    settings = {
        ["rust-analyzer"] = {}
    }
}
require'lspconfig'.gopls.setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require'lspconfig'.jdtls.setup{
    cmd = { 'jdtls' },
    root_dir = function(fname)
        return require'lspconfig'.util.root_pattern(
            'build.gradle',
            'pom.xml',
            '.git'
        )(fname) or vim.fn.getcwd()
    end,
    on_attach = on_attach,
    flags = lsp_flags,
}
require'lspconfig'.html.setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

require'lspconfig'.lua_ls.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- local location = require("nvim-navic").get_location()
-- vim.o.winbar = "%{%' ' . v:lua.require'nvim-navic'.get_location()%}"

