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
        };
    };
}
