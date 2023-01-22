{ lib, ...}:
{
    imports = [
        ../modules/common
        ../modules/games.nix
    ];

    home = {
        username = "antoine";
        homeDirectory = "/home/antoine";
        stateVersion = "22.11";
    };

    programs.kitty.font.size = lib.mkForce 18;
}
