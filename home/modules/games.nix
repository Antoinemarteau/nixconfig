{ pkgs, ... }:
{
    home.packages = with pkgs; [
        prismlauncher
        #minecraft TODO test if it is fixed
        lutris
        wine
    ];
}
