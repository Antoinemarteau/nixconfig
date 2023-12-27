local hl = function(name, val)
    vim.api.nvim_set_hl(0, name, val)
end

-----------------------
-- Main color scheme --
-----------------------
vim.cmd('colorscheme gruvbox')

-----------------------
-- Custom highlights --
-----------------------

-- 80 char line marker
hl('ColorColumn', { ctermbg=0, bg='lightgrey' })

-- Transparent background
hl('Normal', { bg='none' })

-- Highlight extra whitespaces
hl('ExtraWhitespace', { bg='Red' })
vim.fn.matchadd('ExtraWhitespace', '\\s\\+$')

-- Coloration syntaxique des .pro, .geo et .dat comme pour .cpp
vim.api.nvim_create_autocmd(
    {
        'BufNewFile',
        'BufReadPost'
    },
    {
        pattern={'*.pro', '*.geo', '*.dat'},
        callback=function()
            vim.api.nvim_buf_set_option(0, 'filetype', 'onelab')
        end
    }
)
