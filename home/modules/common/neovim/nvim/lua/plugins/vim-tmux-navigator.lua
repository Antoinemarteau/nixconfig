local nmap = require 'utils'.nmap

vim.g.tmux_navigator_no_mappings = 1

nmap('<C-c>', ':<C-U>TmuxNavigateLeft<CR>')
--nmap('<C-t>', ':<C-U>TmuxNavigateDown<CR>')     -- doesnt work due to tmux prefix
nmap('<C-s>', ':<C-U>TmuxNavigateUp<CR>')
--nmap('<C-r>', ':<C-U>TmuxNavigateRight<CR>')    -- doesnt work due to vim redo
--nmap('<C-\\>',':<C-U>TmuxNavigatePrevious<CR>') -- unused
