local nmap = require 'utils'.nmap
local xmap = require 'utils'.xmap

--------------------------------------------------------------------------------
-- slime configuration
--------------------------------------------------------------------------------
vim.g.slime_target = 'tmux'
vim.g.slime_default_config = {
    socket_name = 'default',
    target_pane = ":{end}.{right}"
}
vim.g.slime_dont_ask_default = 1
vim.g.slime_cell_delimiter = "##"

--------------------------------------------------------------------------------
-- julia-cell configuration
--------------------------------------------------------------------------------

-- Use '##' tags to define cells
vim.g.julia_cell_delimit_cells_by = 'tags'

-- execute the current line or current selection
nmap('<Leader>je', '<Plug>SlimeLineSend')
xmap('<Leader>je', '<Plug>SlimeRegionSend')
nmap('<Leader>e',  '<Plug>SlimeSendCell')

-- run entire file
nmap('<Leader>jr', ':JuliaCellRun<CR>')

-- execute the current cell
nmap('<Leader>jc', ':JuliaCellExecuteCell<CR>')

-- execute the current cell and jump to the next cell
nmap('<Leader>jC', ':JuliaCellExecuteCellJump<CR>')

-- map <Leader>jl to clear Julia screen
nmap('<Leader>jl', ':JuliaCellClear<CR>')

-- jump to the previous and next cell header
nmap('<Leader>jp', ':JuliaCellPrevCell<CR>')
nmap('<Leader>jn', ':JuliaCellNextCell<CR>')

-- save and run script
nmap('<F5>', ':w<CR>:JuliaCellRun<CR>')
