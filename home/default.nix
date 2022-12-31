{ pkgs, ... }:
{
    imports = [
        ./flameshot.nix
        ./git.nix
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
        network-manager-applet.enable = true;
        udiskie.enable = true;
        nextcloud-client.enable = true;
    };
}
