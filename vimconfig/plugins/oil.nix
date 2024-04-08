{
    plugins.oil = {
      enable = true;
      settings = {
        columns = [
            "icon"
            "size"
        ];
        #columns.icon.enable = true;
        #columns.size.enable = true;

        keymaps = {
          "g?" = "actions.show_help";
          "<CR>" = "actions.select";
          "<C-s>" = "actions.select_vsplit";
          "<C-h>" = "actions.select_split";
          "<C-t>" = "actions.select_tab";
          "<C-p>" = "actions.preview";
          "<C-c>" = "actions.close";
          "<C-l>" = "actions.refresh";
          "-" = "actions.parent";
          "_" = "actions.open_cwd";
          "`" = "actions.cd";
          "~" = "actions.tcd";
          "g." = "actions.toggle_hidden";
        };
      };
    };

  keymaps = [
      {
          key = "-";
          action = "require('oil').open";
          lua = true;
          options.silent = true;
      }
  ];
}
