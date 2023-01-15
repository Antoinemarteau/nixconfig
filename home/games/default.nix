{ pkgs, ... }:
{
    home.packages = with pkgs; [
        prismlauncher
        minecraft
        lutris
        wine
    ];
}
