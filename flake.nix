{
    description = "antoine-nixos";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {
        self,
        nixpkgs,
        home-manager
    }:
    let
        nixpkgs-outPath = {
            environment.etc."nix/inputs/nixpkgs".source = nixpkgs.outPath;
        };

        mkNixosSystem = hostname: {
            name = hostname;
            value = nixpkgs.lib.nixosSystem {
                modules = [
                    ./nixos/${hostname}
                    nixpkgs-outPath

                    home-manager.nixosModules.home-manager
                    {
                        home-manager = {
                            useGlobalPkgs = true;
                            useUserPackages = true;
                            users.antoine = import ./home;
                        };
                    }
                ];
            };
        };
    in {
        nixosConfigurations = builtins.listToAttrs (
            builtins.map mkNixosSystem [ "framework" ]
        );
    };
}

