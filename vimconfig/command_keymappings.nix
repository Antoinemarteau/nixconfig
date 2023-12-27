{ config, lib, helpers, ... }:
{
      keymaps = let
          command =
            lib.mapAttrsToList
            (key: action: {
              mode = "c";
              inherit action key;
            })
            {
              "<A-v>" = "<C-B>";                          # Go to begining of line
              "<A-d>" = "<S-Left>";                       # Cursor one word left
              "<A-l>" = "<S-Right>";                      # Cursor one word right
              "<A-j>" = "<End>";                          # Go to end of line

              "<A-c>" = "<Up>";    # Go to parent folder  | back history command
              "<A-r>" = "<Down>";  # Enter file/folder    | forward history command

              "<A-\">"= "<C-W>";                          # Delete word before cursor
              "<A-q>" = "<C-U>";                          # Delete all char before cursor
              "<A-g>" = "<BS>";                           # Delete char before cursor
              "<A-h>" = "<Del>";                          # Delete char after cursor
            };
        in
          helpers.keymaps.mkKeymaps
          {options.silent = true;}
          command;

}

