{
    programs.nixvim = {
        globals = {
            ########-
            ## Providers #
            ########-

            ## Disable useless providers
            loaded_ruby_provider = 0;      # Ruby
            loaded_perl_provider = 0;      # Perl
            loaded_python_provider = 0;    # Python 2
        };

        # Use system clipboard
        clipboard = {
            register = "unnamedplus";
            providers.xclip.enable = true;
        };

        options = {

            ############
            # Settings #
            ############

            updatetime = 100;          # Faster completion

            # Line numbers
            relativenumber = true;     # Relative line numbers
            number = true;             # Display the absolute line number of the current line
            hidden = true;             # Keep closed buffer open in the background
            mouse = "a";               # Enable mouse control
            splitbelow = true;         # A new window is put below the current one
            splitright = true;         # A new window is put right of the current one

            swapfile = false;          # Disable the swap file
            modeline = true;           # Tags such as 'vim:ft=sh'
            modelines = 10;            # Sets the type of modelines
            undofile = true;           # Automatically save and restore undo history
            incsearch = true;          # Incremental search: show match for partly typed search command
            smartcase = true;          # Override the 'ignorecase' option if the search
                                        # pattern contains; upper case characters
            scrolloff = 8;             # Number of screen lines to show around the cursor
            cursorline = false;        # Highlight the screen line of the cursor
            cursorcolumn = false;      # Highlight the screen column of the cursor
            signcolumn = "yes";        # Whether to show the signcolumn
            colorcolumn = "0";         # Columns to highlight
            wrap = false;              # Don't wrap lines
            laststatus = 2;            # When to use a status line for the last window
            termguicolors = true;      # Enables 24-bit RGB color in the |TUI|
            spell = false;             # Highlight spelling mistakes (local to window)
            shortmess = "filnxtToOFc";
            listchars = "nbsp:·";      # Point médian treated as unbreakable space
            list = true;               # With listchars option

            # Tab options
            tabstop = 4;               # Number of spaces a <Tab> in the text stands for (local to buffer)
            shiftwidth = 4;            # Number of spaces used for each step of (auto)indent (local to buffer)
            softtabstop = 4;           # If non-zero, number of spaces to insert for a <Tab> (local to buffer)
            expandtab = true;          # Expand <Tab> to spaces in Insert mode (local to buffer)
            smartindent = true;        # Do clever autoindenting
            wildchar  = 9;            # Trigger for completion in command mode WITH <Tab>
            wildcharm = 9;            # wildchar for mapping (see :h wildcharm) WITH <Tab>

            textwidth = 0;             # do not automatically break lines
        };
    };
}
