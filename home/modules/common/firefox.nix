{ pkgs, config, ... }:
{
    programs.firefox = {
        enable = true;
        configPath = "${config.xdg.configHome}/mozilla/firefox";

        profiles.default.userChrome =
        ''
            /* menu and toolbars font size */
            #navigator-toolbox {
                font-size: 14pt !important;
            }

            /* global font size*/
            * {
                font-size: 12pt !important;
            }
        '';
    };
}
