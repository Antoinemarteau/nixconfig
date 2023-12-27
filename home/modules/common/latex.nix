{ pkgs, config, ... }:
{
    home.packages = with pkgs; [
        texlive.combined.scheme-full
        inkscape # for svg support
    ];

    # Palatino font for plots in julia for latex document
    xdg.dataFile."fonts/Palatino_Font.ttf".source = ./../../../nixos/modules/common/other_fonts/Palatino_Font.ttf;
}

