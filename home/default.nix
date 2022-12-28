{ pkgs, ... }:
{
    imports = [
        ./git.nix
        ./i3
        ./julia.nix
        ./kitty.nix
        ./less.nix
        ./neovim
        ./shell
        ./ssh.nix
        ./tmux.nix
        ./xdg.nix
    ];

    home = {
        username = "antoine";
        homeDirectory = "/home/antoine";

        packages = with pkgs; [
            redshift

            gthumb
            mpv
            signal-desktop
            spotify
            vlc
            zathura #TODO
            zotero
        ];

        stateVersion = "22.11";
    };
}
