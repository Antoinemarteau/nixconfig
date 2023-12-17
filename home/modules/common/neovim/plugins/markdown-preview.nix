{
  programs.nixvim = {
    plugins.markdown-preview = {
      enable = true;

      autoStart = false;
      autoClose = false;

      theme = "dark";

      browser = "firefox";
    };

    keymaps = [
      {
        key = "<leader>m";
        action = ":MarkdownPreview<cr>";
        options.silent = true;
      }
    ];
  };
}
