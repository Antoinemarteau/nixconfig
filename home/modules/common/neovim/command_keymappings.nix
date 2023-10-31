{ config, ... }:
{
    programs.nixvim = {

        maps = config.nixvim.helpers.keymaps.mkMaps {silent = false;} {
          # Navigation & completion in command mode
          command."<A-v>" = "<C-B>";                          # Go to begining of line
          command."<A-d>" = "<S-Left>";                       # Cursor one word left
          command."<A-l>" = "<S-Right>";                      # Cursor one word right
          command."<A-j>" = "<End>";                          # Go to end of line

          command."<A-c>" = "<Up>";    # Go to parent folder  | back history command
          command."<A-r>" = "<Down>";  # Enter file/folder    | forward history command

          command."<A-\">"= "<C-W>";                          # Delete word before cursor
          command."<A-q>" = "<C-U>";                          # Delete all char before cursor
          command."<A-g>" = "<BS>";                           # Delete char before cursor
          command."<A-h>" = "<Del>";                          # Delete char after cursor
        };
    };
}

