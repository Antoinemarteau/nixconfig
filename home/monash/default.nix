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
            mesa # for openGL rendering glMakie without graphic card ?
            zoom-us
            openconnect # for the Cisco vpn
            paraview
        ];
    };

    xsession.windowManager.i3.config = {
      assigns = {
          "4" = [{class = "ode"; }]; # vscode
          "7" = [{class = "oom"; }]; # zoom-us
          "8" = [{class = "ara"; }]; # paraview
      };
      startup = [
        { command = "code"; }
        { command = "zoom-us"; }
        { command = "paraview"; }
      ];

      keybindings = let
        mod = config.xsession.windowManager.i3.config.modifier;
      in {
        # update display to monash math office from /nixos/monash/default.nix
        "${mod}+Shift+m" = "${pkgs.autorandr}/bin/autorandr --load math_office";
        # update display to default
        "${mod}+Shift+l" = "${pkgs.autorandr}/bin/autorandr --load laptop";
        # update display rendering (automatic detection)
        "${mod}+Shift+u" = "${pkgs.autorandr}/bin/autorandr -c";
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
