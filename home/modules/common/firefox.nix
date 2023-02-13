{ pkgs, ... }:
{
    programs.firefox = {
        enable = true;

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
