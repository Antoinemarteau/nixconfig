{
  plugins.markdown-preview = {
    enable = true;

    settings = {
      auto_start = false;
      auto_close = false;

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
