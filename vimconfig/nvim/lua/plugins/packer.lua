local fn = vim.fn
local packer = nil


-- Install packer if necessary
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.api.nvim_command 'packadd packer.nvim'
end


-- Register plugins
if packer == nil then
    packer = require 'packer'
    packer.init {

        -- By default, packer needs to write un ~/.config/nvim/plugin/, but ~/.config/nvim is linked
        -- to the /nix/store so not-writeable.
        -- Here, I set it to ~/.local/share/nvim/plugin/
        -- https://github.com/wbthomason/packer.nvim/issues/241#issuecomment-841740576
        compile_path = require 'packer.util'.join_paths(
            vim.fn.stdpath('data'),
            'plugin',
            'packer_compiled.lua'
        ),
    }
end

local use = packer.use
packer.reset()
use 'wbthomason/packer.nvim'            -- Packer can manage itself as an optional plugin

use 'tpope/vim-obsession'               -- save vim session

--use 'christoomey/vim-tmux-navigator'    -- Move between vim and tmux panes seemlessly

---------------
-- LANGUAGES ---------------------------------------------------------------------------------------
---------------
-- LSP
use 'neovim/nvim-lspconfig'             -- A collection of common configurations for the built-in
                                        --  language server client.
use {'thomasfaingnaert/vim-lsp-ultisnips',-- add ultisnips snippets to lsp sugestions
    requires={'thomasfaingnaert/vim-lsp-snippets' }}

-- Style & status bar
use {'vim-airline/vim-airline',         --  status bar (needs devicons special font)
    requires={'ryanoasis/vim-devicons'}}
use 'ellisonleao/gruvbox.nvim'          -- Colorcheme


-- Completion
use 'hrsh7th/nvim-cmp'                  -- Completion engine
use 'hrsh7th/cmp-buffer'                -- nvim-cmp source for buffer words
use 'hrsh7th/cmp-path'                  -- nvim-cmp source for paths
use 'hrsh7th/cmp-nvim-lsp'              -- Nvim-cmp source for neovim builtin LSP client

use 'andymass/vim-matchup'              -- add smarter match and text object for pairs (%, a%, i%)

use {'nvim-treesitter/nvim-treesitter', -- Treesitter (for syntax highlighting and more)
     run = ':TSUpdate'}
use 'nvim-treesitter/nvim-treesitter-refactor'

use {'nvim-telescope/telescope.nvim',   -- Telescope
    requires={'nvim-lua/plenary.nvim'}}
use 'stevearc/oil.nvim'                 -- navigate and modify folder like buffer
--use {'kyazdani42/nvim-tree.lua',        -- File tree
--    require={'kyazdani42/nvim-web-devicons'}}
-- use 'ThePrimeagen/harpoon'              -- Harpoon

use 'tpope/vim-fugitive'                -- Git integration
use 'airblade/vim-gitgutter'            -- Show a git diff in the sign column.

use 'SirVer/ultisnips'                  -- Snippets engine
use 'honza/vim-snippets'                -- snippets files for various programming languages.

use 'chiel92/vim-autoformat'            -- Formatting

use 'lervag/vimtex'                     -- LaTeX support
use {'iamcco/markdown-preview.nvim',    -- Markdown preview
     run = 'cd app && yarn install'}

use 'JuliaEditorSupport/julia-vim'      -- julia support
use 'jpalardy/vim-slime'                -- send code in other term
use {'mroavi/vim-julia-cell',           -- run code in cells
    require={'jpalardy/vim-slime'}} --for = 'julia' }

--[[
use 'folke/trouble.nvim'                -- Pretty list for showing diagnostics

-- Completion
use {'tzachar/cmp-tabnine',             -- TabNine
     run = './install.sh' }

use 'onsails/lspkind-nvim'              -- vscode-like pictograms to neovim built-in lsp

-- Snippets
use 'L3MON4D3/LuaSnip'                  -- snippet engine
use 'saadparwaiz1/cmp_luasnip'          -- luasnip completion source for nvim-cmp


--------
-- UI ----------------------------------------------------------------------------------------------
--------
-- Requirements:
use 'kyazdani42/nvim-web-devicons'      -- for lualine, barbar, nvim-tree...
use 'nvim-lua/plenary.nvim'             -- for harpoon and telescope

-- Status Line and Bufferline
use 'hoob3rt/lualine.nvim'              -- The status line
use 'romgrk/barbar.nvim'                -- Tabline plugin

use 'nvim-telescope/telescope.nvim'     -- Telescope
use 'ThePrimeagen/harpoon'              -- Harpoon

use 'norcalli/nvim-colorizer.lua'       -- Preview colors directly from files

----------
-- Misc --------------------------------------------------------------------------------------------
----------
-- General Plugins
use 'windwp/nvim-autopairs'             -- A minimalist autopairs for Neovim written in Lua
use 'kevinhwang91/nvim-bqf'             -- Make Neovim's quickfix window better
use 'mhinz/vim-startify'                -- Start screen
use 'moll/vim-bbye'                     -- Delete buffers (close files) without closing your windows
                                        --  or messing up the layout
use 'voldikss/vim-floaterm'             -- A floating terminal window in neovim
use 'preservim/tagbar'                  -- Easy way to browse the tags of the current file and get
                                        --  an overview of its structure
use 'terrortylor/nvim-comment'          -- Offer key mapping to comment code
use 'nvim-neorg/neorg'                  -- Orgmode for neovim
]]--
