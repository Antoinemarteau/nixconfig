{lib, ...}: {
  plugins.harpoon = {
    enable = true;

    keymapsSilent = true;

    keymaps = {
      addFile = "<leader>h";
      toggleQuickMenu = "<C-h>";
      navFile = {
        "1" = "<leader>t";
        "2" = "<leader>s";
        "3" = "<leader>r";
        "4" = "<leader>n";
      };
    };
  };
}
