{ lib, pkgs, ...}:
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
