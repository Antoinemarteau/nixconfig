{
    programs.nixvim = {
        colorschemes.gruvbox.enable = true;

        filetype.extension = {
            pro = "onelab";
            geo = "onelab";
            dat = "onelab";
        };

        highlight = {
            Normal.bg = "none";
            ColorColumn = {
                bg = "grey";
            };
            ExtraWhitespace.bg = "Red";
        };

        match = {
            ExtraWhitespace = "\\s\\+$";
        };
    };
}
