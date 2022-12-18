{
    description = "antoine-nixos";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
    };

    outputs = {
        self,
        nixpkgs,
    }:
    {
        nixosConfigurations = {
            framework = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [ ./nixos ];
            };
        };
    };
}

