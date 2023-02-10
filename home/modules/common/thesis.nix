{ config, pkgs, ... }:
{
    home.packages = with pkgs; [
        gmsh
        #singularity
    ];

    #programs.singularity.enable = true;
}
