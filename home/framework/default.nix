{ lib, config, pkgs, ...}:
{
    imports = [
        ../modules/common
        ../modules/games.nix
    ];

    home = {
        username = "antoine";
        homeDirectory = "/home/antoine";
        stateVersion = "22.11";

        packages = with pkgs; [
            mesa
        ];
    };

    xsession.windowManager.i3.config = {
      keybindings = let
        mod = config.xsession.windowManager.i3.config.modifier;
      in {
        # update display to default
        "${mod}+Shift+l" = "${pkgs.autorandr}/bin/autorandr --load laptop";
        # update display rendering (automatic detection)
        "${mod}+Shift+u" = "${pkgs.autorandr}/bin/autorandr -c";
      };
    };

    services.picom.enable = lib.mkForce false;

    # Font size overrides
    programs.kitty.font.size = lib.mkForce 18;
    services.dunst.settings.global.font = lib.mkForce "DejaVu Sans 22";
    gtk.font.name = lib.mkForce "DejaVu Sans 18";

    programs.firefox.profiles.default.userChrome = lib.mkForce
    ''
        /* menu and toolbars font size */
        #navigator-toolbox {
            font-size: 18pt !important;
        }

        /* global font size*/
        * {
            font-size: 16pt !important;
        }
    '';
}
