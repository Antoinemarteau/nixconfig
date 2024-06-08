{
    description = "antoine-nixos";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixvim = {
          url = "github:pta2002/nixvim";
          inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {
        self,
        nixpkgs,
        home-manager,
        nixvim
    }:
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs {
            inherit system;
        };
        nixvim' = nixvim.legacyPackages.${system};
        my-nvim = nixvim'.makeNixvimWithModule {
          inherit pkgs;
          module = ./vimconfig;
          # You can use `extraSpecialArgs` to pass additional arguments to your module files
          extraSpecialArgs = {
            inherit self;
          };
        };

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
                            extraSpecialArgs = { inherit my-nvim; };
                            #users.antoine = import ./home/${hostname};
                            users.antoine = {
                                imports = [
                                    ./home/${hostname}
                                    nixvim.homeManagerModules.nixvim
                                ];
                                home.sessionVariables.HOSTNAME = hostname;
                            };
                        };
                    }
                ];
            };
        };
    in {
        nixosConfigurations = builtins.listToAttrs (
            builtins.map mkNixosSystem [ "framework" "desktop" "vm" "mage" ]
        );
        packages.${system}.default = my-nvim;
    };
}

