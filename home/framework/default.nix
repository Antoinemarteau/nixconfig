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

    # Font size overrides
    programs.kitty.font.size = lib.mkForce 18;
    services.dunst.settings.global.font = lib.mkForce "DejaVu Sans 22";
}
