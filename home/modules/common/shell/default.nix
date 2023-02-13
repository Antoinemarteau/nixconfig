{
    imports = [
        ./zsh.nix
    ];

    home = {
        shellAliases = {
            c = "cd";

            nrs = "sudo nixos-rebuild switch --flake ~/nixconfig -v";
            nfu = "nix flake update";
            nsp = "nix-shell -p";

            fs = "pcmanfm";

            vs = "nvim -c ':vert Git'";

            vulab = "nmcli con up G2Elab";
            vdlab = "nmcli con down G2Elab";
        };
    };
}
