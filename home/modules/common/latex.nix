{ pkgs, config, ... }:
{
    home.packages = with pkgs; [
        texlive.combined.scheme-full
        inkscape # for svg support
        liberation-sans-narrow # for phd thesis frontpage
        python312Packages.pygments # for minted latex package, for Documenter.jl latex export
    ];

    # Palatino font for plots in julia for latex document
    xdg.dataFile."fonts/Palatino_Font.ttf".source = ./../../../nixos/modules/common/other_fonts/Palatino_Font.ttf;
}

