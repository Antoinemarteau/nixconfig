require 'vim.treesitter.language'.register("cpp", "onelab")

require 'nvim-treesitter.configs'.setup {

    -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = {
        'bash',
        'c',
        'cpp',
        'html',
        'julia',
        'latex',
        'lua',
        'nix',
        'python'
    },

    highlight = {
        -- false will disable the whole extension
        enable = true
    },

    refactor = {
        highlight_definitions = {
            -- Highlights definition and usages of the current symbol under the cursor.
            enable = true
        }
    }
}
