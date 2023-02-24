{ pkgs, ... }:
{
    imports = [
        ./dunst.nix
        ./firefox.nix
        ./flameshot.nix
        ./git.nix
        ./gtk.nix
        ./i3
        ./julia.nix
        ./kitty.nix
        ./less.nix
        ./neovim
        ./note.nix
        ./picom.nix
        ./readline.nix
        ./rofi.nix
        ./shell
        ./ssh.nix
        ./thesis.nix
        ./tmux.nix
        ./xdg.nix
        ./zathura.nix
    ];

    home.packages = with pkgs; [
        # essentials and basics
        redshift
        udiskie
        jmtpfs # mount android phone

        # file readers
        pcmanfm
        gthumb
        vlc
        zathura
        mpv
        gnome.gedit

        #file editors
        pinta
        libreoffice

        # gui applications
        signal-desktop
        spotify
        # set setting layout.css.devPixelsPerPx = 1.5 in zotero GUI,
        # and change font in the gui "view" menu
        zotero

        # screen management
        arandr
        mons
        remmina # xrdp client

        #latex
        texlive.combined.scheme-full

        # # cpp dev
        # gdb
        # cmake
        # cppman
        # ccls
        # valgrind
    ];

    services = {
        blueman-applet.enable = true;
        network-manager-applet.enable = true;
        udiskie.enable = true;
        nextcloud-client.enable = true;
    };
}
