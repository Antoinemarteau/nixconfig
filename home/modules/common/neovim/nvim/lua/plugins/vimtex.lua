local autocmd = vim.api.nvim_create_autocmd
local nmap  = require 'utils'.nmap
local omap  = require 'utils'.omap
local xmap  = require 'utils'.xmap
local unmap = require 'utils'.unmap

vim.g.vimtex_view_method = 'zathura'
vim.g.tex_flavor = 'latex'
vim.g.vimtex_imaps_enabled = true
vim.g.vimtex_imaps_leader = 'ç'


-- Compile on initialization, cleanup on quit
local vimtex_augroup = vim.api.nvim_create_augroup(
    'vimtex_event_1',
    { clear = true }
)
autocmd(
    'User',
    {
        pattern = 'VimtexEventInitPost',
        command = 'TSDisable highlight | call vimtex#compiler#compile()',
        group = vimtex_augroup
    }
)
autocmd(
    'User',
    {
        pattern = 'VimtexEventQuit',
        command = 'call vimtex#compiler#clean(0)',
        group = vimtex_augroup
    }
)

autocmd(
    {'FileType'},
    {
        pattern = 'tex,latex',
        callback = function()
            -- unmap('ç') -- the mapping seem not to exist, and thus unmap crashes
            nmap('çm', '<Plug>(vimtex-%)')
            vim.keymap.set(
                {'n', 'v', 'o'},
                'm', ':VimtexView<CR>',
                { silent = true, buffer = 0 }
            )
        end
    }
)

-- TOC settings
vim.g.vimtex_toc_config = {
    name = 'TOC',
    layers = "['content', 'todo']",
    resize = 1,
    split_width = 50,
    todo_sorted = 0,
    show_help = 1,
    show_numbers = 1,
    mode = 2
}


-- Ignore undesired errors and warnings
vim.g.vimtex_quickfix_ignore_filters = {
    'Underfull',
    'Overfull',
    'undefined references',
    '(re)run Biber',
    'Unused global option(s)',
    'Token not allowed in a PDF string',
    'level fixed',
    'float specifier changed to',
}

vim.g.vimtex_quickfix_autoclose_after_keystrokes = 4

-- Affichage des symbole math comme dans le document
vim.opt.conceallevel=2
vim.g.tex_conceal='abdmg'

---- Spell check
--autocmd(
--    'FileType',
--    {
--        pattern = 'tex,latex,markdown',
--        command = "setlocal spell spelllang=en,fr"
--    }
--)

-- Mappings mode insertion, pour macros electromag
vim.call("vimtex#imaps#add_map", { lhs = "N", rhs = '\\nabla' })
vim.call("vimtex#imaps#add_map", { lhs = 'b', rhs = '\\b'     })
vim.call("vimtex#imaps#add_map", { lhs = 'h', rhs = '\\H'     })
vim.call("vimtex#imaps#add_map", { lhs = 'l', rhs = '\\L'     })
--
---- Racourcis pour ensemble
vim.call("vimtex#imaps#add_map", { lhs = 'oe',  rhs = '\\omeSymb'  })
vim.call("vimtex#imaps#add_map", { lhs = 'os',  rhs = '\\omsSymb'  })
vim.call("vimtex#imaps#add_map", { lhs = 'oc',  rhs = '\\omcSymb'  })
vim.call("vimtex#imaps#add_map", { lhs = 'ode', rhs = '\\domeSymb' })
vim.call("vimtex#imaps#add_map", { lhs = 'ods', rhs = '\\domsSymb' })
vim.call("vimtex#imaps#add_map", { lhs = 'odc', rhs = '\\domcSymb' })

vim.cmd( [[
    let g:vimtex_mappings_disable = {
        \ 'n': ['tsd', 'tsd', 'tsf', 'tsc', 'tse', 'csd', 'csc', 'cse', 'cs$'],
        \ 'x': ['tsd', 'tsd', 'tsf'],
        \}
        ]] )


nmap('lse', '<plug>(vimtex-env-change)')
nmap('lsc', '<plug>(vimtex-cmd-change)')
nmap('ls', '$<plug>(vimtex-env-change-math)')
nmap('lsd', '<plug>(vimtex-delim-change-math)')
nmap('jsf', '<plug>(vimtex-cmd-toggle-frac)')
xmap('jsf', '<plug>(vimtex-cmd-toggle-frac)')
nmap('jsc', '<plug>(vimtex-cmd-toggle-star)')
nmap('jse', '<plug>(vimtex-env-toggle-star)')
nmap('js', '$<plug>(vimtex-env-toggle-math)')
nmap('jsd', '<plug>(vimtex-delim-toggle-modifier)')
xmap('jsd', '<plug>(vimtex-delim-toggle-modifier)')
nmap('jsd', '<plug>(vimtex-delim-toggle-modifier-reverse)')
xmap('jsd', '<plug>(vimtex-delim-toggle-modifier-reverse)')

-- Remap % en ç en normal mode
nmap('ç ', '<Plug>(MatchitNormalForward)')
nmap('gç', '<Plug>(MatchitNormalBackward)')
xmap('ç ', '<Plug>(MatchitVisualForward)')
xmap('gç', '<Plug>(MatchitVisualBackward)')
omap('ç ', '<Plug>(MatchitOperationForward)')
omap('gç', '<Plug>(MatchitOperationBackward)')

nmap('[ç', '<Plug>(MatchitNormalMultiBackward)')
nmap(']ç', '<Plug>(MatchitNormalMultiForward)')
xmap('[ç', '<Plug>(MatchitVisualMultiBackward)')
xmap(']ç', '<Plug>(MatchitVisualMultiForward)')
omap('[ç', '<Plug>(MatchitOperationMultiBackward)')
omap(']ç', '<Plug>(MatchitOperationMultiForward)')

-- text object:
xmap('aç', '<Plug>(MatchitVisualTextObject)')
