{ config, ...}:
{
    imports = [
        ../modules/common
    ];

    home = {
        username = "antoine";
        homeDirectory = "/home/antoine";
        stateVersion = "22.11";

        file."common_with_host".source = config.lib.file.mkOutOfStoreSymlink /mnt/common_with_host;
    };
}
