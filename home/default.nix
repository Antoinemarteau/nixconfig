{ pkgs, ... }:
{
    imports = [
        ./flameshot.nix
        ./games
        ./git.nix
        ./gtk.nix
        ./i3
        ./julia.nix
        ./kitty.nix
        ./less.nix
        ./neovim
        #./picom.nix
        ./readline.nix
        ./rofi.nix
        ./shell
        ./ssh.nix
        ./tmux.nix
        ./xdg.nix
        ./zathura.nix
    ];

    home = {
        username = "antoine";
        homeDirectory = "/home/antoine";

        packages = with pkgs; [
            # essentials and basics
            redshift
            udiskie

            # file readers
            pcmanfm
            gthumb
            vlc
            zathura #TODO
            mpv

            # gui applications
            signal-desktop
            spotify
            # set setting layout.css.devPixelsPerPx = 1.5 in zotero GUI,
            # and change font in the gui "view" menu
            zotero

            #latex
            texlive.combined.scheme-full

            # # cpp dev
            # gdb
            # cmake
            # cppman
            # ccls
            # valgrind
        ];


        stateVersion = "22.11";
    };

    services = {
        blueman-applet.enable = true;
        network-manager-applet.enable = true;
        udiskie.enable = true;
        nextcloud-client.enable = true;
    };
}
