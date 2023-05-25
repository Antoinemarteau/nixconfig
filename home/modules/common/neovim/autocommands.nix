{
    programs.nixvim.autoCmd = [
        {
            # close quickfix menu after selecting choice
            event = "FileType";
            pattern = "qf";
            command = "nnoremap <buffer> <CR> <CR>:cclose<CR>";
        }
        {
            # Highlight yanked text
            event = "TextYankPost";
            command = "silent! lua vim.highlight.on_yank()";
        }
        {
            # Vertically center document when entering insert mode
            event = "InsertEnter";
            command = "norm zz";
        }
        {
            # Remove trailing whitespace on save
            event = "BufWrite";
            command = "%s/\\s\\+$//e";
        }
        {
            # Remove trailing whitespace on save
            event = "BufWritePost";
            pattern = "*notes-*.md";
            command = "silent !buildNote %:p";
        }
    ];
}
