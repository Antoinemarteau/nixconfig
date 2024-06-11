{ lib, config, pkgs, ...}:
{
    imports = [
        ../modules/common
    ];

    home = {
        username = "antoine";
        homeDirectory = "/home/antoine";
        stateVersion = "24.05";

        packages = with pkgs; [
            mesa
            zoom-us
            openconnect
        ];
    };

    xsession.windowManager.i3.config = {
      assigns = {
          "4" = [{class = "ode"; }];
          "7" = [{class = "oom"; }];
      };
      startup = [
        { command = "code"; }
        { command = "zoom-us"; }
      ];

      keybindings = let
          mod = config.xsession.windowManager.i3.config.modifier;
          math_office_output = pkgs.writeScript "math_office" ''
          #!/bin/sh
          xrandr --output eDP-1 --off --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --off --output DP-5 --off --output DP-4-1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-4-2 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-4-3 --off
      '';
      in {
          "${mod}+m" = "exec --no-startup-id ${math_office_output}";
      };
    };

    services.picom.enable = lib.mkForce false;

    # Font size overrides
    programs.kitty.font.size = lib.mkForce 14;
    services.dunst.settings.global.font = lib.mkForce "DejaVu Sans 16";
    gtk.font.name = lib.mkForce "DejaVu Sans 14";

    programs.firefox.profiles.default.userChrome = lib.mkForce
    ''
        /* menu and toolbars font size */
        #navigator-toolbox {
            font-size: 14pt !important;
        }

        /* global font size*/
        * {
            font-size: 14pt !important;
        }
    '';
}
