------------------
-- Key mappings --
------------------
local nmap = require 'utils'.nmap

nmap('gd', vim.lsp.buf.definition)
nmap('gr', vim.lsp.buf.references)
nmap('gt', vim.lsp.buf.type_definition)
nmap('gi', vim.lsp.buf.implementation)
nmap('gk', vim.lsp.buf.hover)
nmap('gf', vim.lsp.buf.format)
nmap('ga', vim.lsp.buf.code_action)
nmap('gy', vim.lsp.buf.document_symbol) -- close quickfix list with <A-q>

-- Navigate in diagnostics
nmap('<A-s>', vim.diagnostic.goto_prev)
nmap('<A-t>', vim.diagnostic.goto_next)

-- Rename
nmap('<F2>', vim.lsp.buf.rename)


------------------------------------
-- nvim-cmp extended capabilities --
------------------------------------

-- The nvim-cmp almost supports LSP's capabilities so we advertise it to LSP servers.
local capabilities = require('cmp_nvim_lsp').default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)


------------------------------------------------
-- Individual language servers configurations --
------------------------------------------------

-- bash
require 'lspconfig'.bashls.setup {
    capabilities = capabilities
}

-- C / C++
require'lspconfig'.clangd.setup {
    capabilities = capabilities
}

-- LaTeX
require 'lspconfig'.texlab.setup {
    capabilities = capabilities
}
require 'lspconfig'.ltex.setup {
    capabilities = capabilities
}

-- lua
require 'lspconfig'.lua_ls.setup {
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                -- Prevent warning
                checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            }
        }
    }
}

-- Python
require 'lspconfig'.pylsp.setup {
    capabilities = capabilities,
}

-- Julia
require'lspconfig'.julials.setup{
    capabilities = capabilities,
}
