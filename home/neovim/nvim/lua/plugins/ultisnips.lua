vim.g.UltiSnipsEditSplit = 'horizontal'
vim.g.UltiSnipsExpandTrigger       = '<tab>'
vim.g.UltiSnipsJumpForwardTrigger  = '<tab>'
vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>'

local autocmd = vim.api.nvim_create_autocmd

-- .pro (getDP) snippets priority : pro > onelab > all (discard any others)
autocmd({'BufNewFile', 'BufReadPost'}, {pattern = '*.pro', command = 'UltiSnipsAddFiletypes pro.onelab'})
autocmd({'BufNewFile', 'BufReadPost'}, {pattern = '*.pro', command = 'UltiSnipsAddFiletypes onelab.all'})

-- .geo (gmsh)  snippets priority : geo > onelab > all (discard any others)
autocmd({'BufNewFile', 'BufReadPost'}, {pattern = '*.geo', command = 'UltiSnipsAddFiletypes geo.onelab'})
autocmd({'BufNewFile', 'BufReadPost'}, {pattern = '*.geo', command = 'UltiSnipsAddFiletypes onelab.all'})
