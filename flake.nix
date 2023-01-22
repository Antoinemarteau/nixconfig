{
    description = "antoine-nixos";

    inputs = {
        nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
        home-manager = {
            url = github:nix-community/home-manager;
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
                            #users.antoine = import ./home/${hostname};
                            users.antoine = {
                                imports = [ ./home/${hostname} ];
                                home.sessionVariables.HOSTNAME = hostname;
                            };
                        };
                    }
                ];
            };
        };
    in {
        nixosConfigurations = builtins.listToAttrs (
            builtins.map mkNixosSystem [ "framework" "desktop" "vm" "manjaro" ]
        );
    };
}

