{ self, ... }:
{
    imports = [
        ./settings.nix
        ./keymappings.nix
        ./autocommands.nix
        ./colorscheme.nix
        ./plugins
    ];

    luaLoader.enable = true;

}
