{
  plugins.markdown-preview = {
    enable = true;

    settings = {
      auto_start = 0;
      auto_close = 0;

      theme = "dark";

      browser = "firefox";
    };
  };

  keymaps = [
    {
      key = "<leader>m";
      action = ":MarkdownPreview<cr>";
      options.silent = true;
    }
  ];
}
