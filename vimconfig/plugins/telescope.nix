{
  plugins.telescope = {
    enable = true;

    keymaps = {
      "<leader>fr" = "git_files";
      "<leader>fs" = "oldfiles";
      "<leader>fg" = "live_grep";
      "<leader>fw" = "grep_string";
      "<leader>fb" = "buffers";
      "<leader>fd" = "diagnostics";
    };

    settings.defaults = {
      file_ignore_patterns = [
        "^.git/"
        "^.pre/"
        "^.pos/"
        "^.msh/"
      ];

      mappings = {
          i = {
            "<A-t>" = "move_selection_next";
            "<A-s>" = "move_selection_previous";
            "<A-v>" = "select_vertical";
            "<A-d>" = "select_horizontal";
          };

          n = {
            "<A-t>" = "move_selection_next";
            "<A-s>" = "move_selection_previous";
            "<A-v>" = "select_vertical";
            "<A-d>" = "select_horizontal";
          };
      };

      set_env.COLORTERM = "truecolor";
    };
  };
}

