{
  programs.nixvim = {
    plugins.markdown-preview = {
      enable = true;

      autoStart = false;
      autoClose = false;

      theme = "dark";

      browser = "firefox";
    };

    maps.normal."<leader>m" = {
      action = ":MarkdownPreview<cr>";
      silent = true;
    };
  };
}
