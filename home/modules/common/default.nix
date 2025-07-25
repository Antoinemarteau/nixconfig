{ pkgs, config, ... }:
{
    imports = [
        #./cpp.nix
        ./dunst.nix
        ./firefox.nix
        ./flameshot.nix
        ./git.nix
        ./gtk.nix
        ./i3
        ./julia.nix
        ./kitty.nix
        ./latex.nix
        ./less.nix
        ./neovim.nix
        ./note.nix
        ./picom.nix
        ./readline.nix
        ./rofi.nix
        ./shell
        ./ssh.nix
        ./thesis.nix
        ./tmux.nix
        ./vscode.nix
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
        gedit

        #file editors
        pinta
        inkscape
        libreoffice
        pdfsam-basic

        # gui applications
        signal-desktop
        spotify
        # set setting layout.css.devPixelsPerPx = 1.5 in zotero GUI,
        # and change font in the gui "view" menu
        zotero
        # write math with tablet
        xournalpp

        # tui applications
        bluetuith

        # screen management
        arandr
        mons
        remmina # xrdp client

        #debug network-manager-applet.enable = true
        networkmanagerapplet
    ];

    services = {
        udiskie.enable = true;
        nextcloud-client.enable = true;
    };

    # XCompose file for bepo_antoine
    home.file."${config.home.homeDirectory}/.XCompose".source = config.lib.file.mkOutOfStoreSymlink "${../../../nixos/modules/common/keyboard/XCompose}";
}
