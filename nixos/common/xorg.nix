{ pkgs, ... }:
{
    # Enable the X11 windowing system.
    services.xserver = {
        enable = true;

        # session login screen
        displayManager.lightdm = {
            enable = true;
            greeters.gtk = {
                enable = true;
                theme = {
                    name = "Matcha-dark-aliz";
                    package = pkgs.matcha-gtk-theme;
                };
                cursorTheme = {
                    name = "Numix-Cursor-Light";
                    package = pkgs.numix-cursor-theme;
                };
            };
        };

        windowManager.i3 = {
            enable = true;
            package = pkgs.i3-gaps;
        };
    };
}
