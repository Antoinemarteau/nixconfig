local tree_cb = require'nvim-tree.config'.nvim_tree_callback


-- Automatically close the tab/vim when nvim-tree is the last window in the tab.
vim.api.nvim_create_autocmd(
    'BufEnter',
    {
        pattern = '*',
        command = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif",
        nested = true
    }
)

require'nvim-tree'.setup {
    disable_netrw       = false,            -- Disables netrw completely.
    hijack_netrw        = false,            -- Hijack netrw window on startup.
    hijack_cursor       = false,            -- Hijack the cursor in the tree to put it at the start
                                            --      of the filename.
    update_cwd          = false,            -- Updates the root directory of the tree on
                                            --      `DirChanged` (when your run `:cd` usually).

    -- Show lsp diagnostics in the signcolumn.
    diagnostics = {
        enable = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        }
    },

    -- Update the focused file on `BufEnter`, un-collapses the folders recursively until it finds
    -- the file.
    update_focused_file = {
        enable      = true,     -- Enables the feature
        update_cwd  = false,    -- Update the root directory of the tree to the one of the folder
                                --      containing the file if the file is not under the current
                                --      root directory only relevant when
                                --      `update_focused_file.enable` is true.
        ignore_list = {}        -- List of buffer names / filetypes that will not update the cwd if
                                --      the file isn't found under the current root directory only
                                --      relevant when `update_focused_file.update_cwd` is true and
                                --      `update_focused_file.enable` is true.
    },

    -- Configuration options for the system open command (`s` in the tree by default)
    system_open = {
        cmd  = nil,             -- The command to run this, leaving nil should work in most cases.
        args = {}               -- The command arguments as a list.
    },

    -- filtering options
    filters = {
        dotfiles = true,        -- false by default, this option hides files and folders starting
                                --      with a dot `.`
        custom = {              -- Ignored files (empty by default)
            '.git',
            'node_modules',
            '.cache',
            '__pycache__',
            '*.aux',
            '*.bbl',
            '*.blg',
            '*.egg-info',
            '*.fdb_latexmk',
            '*.fls',
            '*.maf',
            '*.mtc',
            '*.mtc0',
            '*.pyc',
            '*.run.xml',
            '*.pre',
            '*.res',
            '*.synctex*'
        }
    },

    view = {
        width = 30,             -- width of the window, can be either a number (columns) or a string
                                --      in `%`
        side = 'left',          -- side of the tree, can be one of 'left', 'right', 'top', 'bottom'

        mappings = {

            custom_only = false,    -- custom only false will merge the list with the default
                                    --      mappings. If true, it will only use your list to set the
                                    --      mappings.

            -- list of mappings to set on the tree manually
            list = {
                { key = {"<CR>", "o", "<2-LeftMouse>", "l"},
                                        cb = tree_cb("edit") },
                { key = {"<2-RightMouse>", "<C-]>"},
                                        cb = tree_cb("cd") },
                { key = "q",            cb = tree_cb("close") },
                { key = "g?",           cb = tree_cb("toggle_help") },
                --{ key = "<C-v>",        cb = tree_cb("vsplit") },
                --{ key = "<C-x>",        cb = tree_cb("split") },
                --{ key = "<C-t>",        cb = tree_cb("tabnew") },
                --{ key = "<",            cb = tree_cb("prev_sibling") },
                --{ key = ">",            cb = tree_cb("next_sibling") },
                --{ key = "P",            cb = tree_cb("parent_node") },
                --{ key = {"<BS>", "<S-CR>", "h"},
                --                        cb = tree_cb("close_node") },
                --{ key = "<Tab>",        cb = tree_cb("preview") },
                --{ key = "K",            cb = tree_cb("first_sibling") },
                --{ key = "J",            cb = tree_cb("last_sibling") },
                --{ key = "I",            cb = tree_cb("toggle_ignored") },
                --{ key = "H",            cb = tree_cb("toggle_dotfiles") },
                --{ key = "R",            cb = tree_cb("refresh") },
                --{ key = "a",            cb = tree_cb("create") },
                --{ key = "d",            cb = tree_cb("remove") },
                --{ key = "r",            cb = tree_cb("rename") },
                --{ key = "<C-r>",        cb = tree_cb("full_rename") },
                --{ key = "x",            cb = tree_cb("cut") },
                --{ key = "c",            cb = tree_cb("copy") },
                --{ key = "p",            cb = tree_cb("paste") },
                --{ key = "y",            cb = tree_cb("copy_name") },
                --{ key = "Y",            cb = tree_cb("copy_path") },
                --{ key = "gy",           cb = tree_cb("copy_absolute_path") },
                --{ key = "[c",           cb = tree_cb("prev_git_item") },
                --{ key = "]c",           cb = tree_cb("next_git_item") },
                --{ key = "-",            cb = tree_cb("dir_up") },
            }
        }
    },

    renderer = {
        -- `false` by default, this option shows indent markers when folders are open
        indent_markers = {
            enable = true
        }
    }
}
