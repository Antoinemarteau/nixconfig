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
        system = "x86_64-linux";

        nixpkgs-outPath = {
            environment.etc."nix/inputs/nixpkgs".source = nixpkgs.outPath;
        };
    in {
        nixosConfigurations = {
            framework = nixpkgs.lib.nixosSystem {
                modules = [
                    ./nixos
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
    };
}

