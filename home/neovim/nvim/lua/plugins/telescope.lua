--------------
-- Bindings --
--------------
local nmap = require 'utils'.nmap

local builtin = require 'telescope.builtin'

-- Find files using Telescope command-line sugar.
nmap('<leader>fr', builtin.git_files)
nmap('<leader>fs', builtin.oldfiles)
nmap('<leader>fg', builtin.live_grep)
nmap('<leader>fd',
     function()
        builtin.diagnostics({bufnr = 0})
     end
)


-------------------
-- Configuration --
-------------------
require 'telescope'.setup {
    defaults = {
        file_ignore_patterns = {
            '^.git/',
            '^.pre',
            '^.pos',
            '^.msh',
        },
        mappings = {
            i = {
                ["<A-t>"] = "move_selection_next",
                ["<A-s>"] = "move_selection_previous",
                ["<A-v>"] = "select_vertical",
                ["<A-d>"] = "select_horizontal",
            },
            n = {
                ["<A-t>"] = "move_selection_next",
                ["<A-s>"] = "move_selection_previous",
                ["<A-v>"] = "select_vertical",
                ["<A-d>"] = "select_horizontal",
            }
        }
    }
}
