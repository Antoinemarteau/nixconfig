{ pkgs, ... }:
{
    programs.firefox = {
        enable = true;

        profiles.default.userChrome =
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
    };
}
